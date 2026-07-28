// smart-titles — tmux-style auto-naming for herdr, fully event-driven.
//
// Holds a persistent connection to the herdr socket API and subscribes to
// pane/tab events (no polling). Pane labels mirror terminal titles (fallback:
// foreground process, then cwd tail); agent-detected panes take the agent's
// own session name verbatim, whatever the harness puts there. Tab labels
// mirror their active pane's display name, which for agent panes is the agent
// kind herdr detected, so tabs stay short while pane labels stay descriptive.
// Manual renames win: any label this daemon didn't set is left alone until
// the `reset` action clears the memory.
//
// herdr owns agent detection and naming; this plugin does no parsing of its
// own. That is deliberate — see agentPaneLabel.
//
// Build: go build -o smart-titles .
package main

import (
	"bufio"
	"encoding/json"
	"errors"
	"fmt"
	"net"
	"os"
	"os/exec"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
	"sync"
	"syscall"
	"time"
)

const (
	reconnectDelay = 2 * time.Second
	maxLogBytes    = 512 * 1024
)

var (
	shells       = map[string]bool{"zsh": true, "bash": true, "sh": true, "fish": true}
	integerLabel = regexp.MustCompile(`^\d+$`)

	// pane.updated fires on any pane state change (output revision, scroll, …);
	// only these fields can affect a display name, so everything else is
	// dropped before any work happens.
	nameFields = []string{"title", "display_agent", "terminal_title_stripped", "label", "agent", "foreground_cwd", "cwd", "tab_id"}

	// pane.agent_status_changed also carries a reported session title, but it
	// is a per-pane subscription (requires pane_id) and cannot be taken out
	// globally; pane.updated covers the same fields for every pane.
	subscriptions = []string{
		"pane.created", "pane.updated", "pane.closed", "pane.focused",
		"tab.created", "tab.renamed", "tab.moved", "tab.closed",
	}

	socketPath, configDir, pidFile, stateFile, logFile string
)

func init() {
	home, _ := os.UserHomeDir()
	socketPath = os.Getenv("HERDR_SOCKET_PATH")
	if socketPath == "" {
		socketPath = filepath.Join(home, ".config/herdr/herdr.sock")
	}
	configDir = os.Getenv("HERDR_PLUGIN_CONFIG_DIR")
	if configDir == "" {
		configDir = filepath.Join(home, ".config/herdr/plugins/config/smart-titles")
	}
	pidFile = filepath.Join(configDir, "daemon.pid")
	stateFile = filepath.Join(configDir, "state.json")
	logFile = filepath.Join(configDir, "daemon.log")
}

func logf(format string, args ...any) {
	if info, err := os.Stat(logFile); err == nil && info.Size() > maxLogBytes {
		os.Remove(logFile)
	}
	f, err := os.OpenFile(logFile, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0o644)
	if err != nil {
		return
	}
	defer f.Close()
	fmt.Fprintf(f, "%s %s\n", time.Now().UTC().Format("2006-01-02T15:04:05.000Z"), fmt.Sprintf(format, args...))
}

// --- state ---

type ownership struct {
	Set    string `json:"set,omitempty"`
	Manual bool   `json:"manual,omitempty"`
}

type stateData struct {
	Panes           map[string]*ownership `json:"panes"`
	Tabs            map[string]*ownership `json:"tabs"`
	ActivePaneByTab map[string]string     `json:"activePaneByTab"`
}

func loadState() *stateData {
	st := &stateData{
		Panes:           map[string]*ownership{},
		Tabs:            map[string]*ownership{},
		ActivePaneByTab: map[string]string{},
	}
	if raw, err := os.ReadFile(stateFile); err == nil {
		json.Unmarshal(raw, st)
		if st.Panes == nil {
			st.Panes = map[string]*ownership{}
		}
		if st.Tabs == nil {
			st.Tabs = map[string]*ownership{}
		}
		if st.ActivePaneByTab == nil {
			st.ActivePaneByTab = map[string]string{}
		}
	}
	return st
}

func (s *stateData) pane(id string) *ownership {
	if s.Panes[id] == nil {
		s.Panes[id] = &ownership{}
	}
	return s.Panes[id]
}

func (s *stateData) tab(id string) *ownership {
	if s.Tabs[id] == nil {
		s.Tabs[id] = &ownership{}
	}
	return s.Tabs[id]
}

// --- socket API (newline-framed JSON) ---
// The server answers one request per connection and then closes it; only a
// connection that sent events.subscribe stays open, as an event stream. So:
// one short-lived connection per RPC, one persistent connection for events.

func newScanner(conn net.Conn) *bufio.Scanner {
	sc := bufio.NewScanner(conn)
	sc.Buffer(make([]byte, 0, 64*1024), 4*1024*1024)
	return sc
}

// rpc returns the response's result object, or nil on any error.
func rpc(method string, params map[string]any) map[string]any {
	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		return nil
	}
	defer conn.Close()
	if params == nil {
		params = map[string]any{}
	}
	req, _ := json.Marshal(map[string]any{"id": "1", "method": method, "params": params})
	if _, err := conn.Write(append(req, '\n')); err != nil {
		return nil
	}
	sc := newScanner(conn)
	for sc.Scan() {
		line := strings.TrimSpace(sc.Text())
		if line == "" {
			continue
		}
		var msg map[string]any
		if json.Unmarshal([]byte(line), &msg) != nil {
			continue
		}
		if msg["id"] == "1" {
			result, _ := msg["result"].(map[string]any)
			return result // error responses resolve to nil
		}
	}
	return nil
}

// --- sync engine ---

var (
	dataMu    sync.Mutex
	st        *stateData
	panes     = map[string]map[string]any{} // pane_id -> PaneInfo (from events / pane.list)
	tabLabels = map[string]*string{}
	names     = map[string]*string{} // pane_id -> display name
)

func saveState() {
	raw, _ := json.Marshal(st)
	os.WriteFile(stateFile, raw, 0o644)
}

func getStr(m map[string]any, key string) string {
	s, _ := m[key].(string)
	return s
}

func getStrPtr(m map[string]any, key string) *string {
	if s, ok := m[key].(string); ok {
		return &s
	}
	return nil
}

func cwdTail(cwd string) *string {
	trimmed := strings.TrimRight(cwd, "/")
	if trimmed == "" {
		return nil
	}
	parts := strings.Split(trimmed, "/")
	tail := parts[len(parts)-1]
	if tail == "" {
		return nil
	}
	return &tail
}

func paneDisplayName(pane map[string]any) *string {
	// Agent kind wins over terminal title: agents retitle constantly (spinner
	// glyphs, task summaries) and those feed herdr's state detection, not names.
	if agent := getStr(pane, "agent"); agent != "" {
		return &agent
	}
	if title := strings.TrimSpace(getStr(pane, "terminal_title_stripped")); title != "" {
		return &title
	}
	if info := rpc("pane.process_info", map[string]any{"pane_id": getStr(pane, "pane_id")}); info != nil {
		if pi, ok := info["process_info"].(map[string]any); ok {
			if fps, ok := pi["foreground_processes"].([]any); ok && len(fps) > 0 {
				if fp, ok := fps[0].(map[string]any); ok {
					if proc := getStr(fp, "name"); proc != "" && !shells[proc] {
						return &proc
					}
				}
			}
		}
	}
	cwd := getStr(pane, "foreground_cwd")
	if cwd == "" {
		cwd = getStr(pane, "cwd")
	}
	return cwdTail(cwd)
}

// Agent panes take the agent's own session name verbatim. Whatever a harness
// puts in its terminal title is what the pane is called — no parsing, no
// stripping, no guessing which part is "really" the session name. Every
// attempt to be clever here (peeling brand suffixes, dropping status glyphs,
// holding the label mid-turn) traded a cosmetic win for a way to be wrong on
// some harness, so the plugin no longer tries. herdr owns agent detection;
// this owns nothing but the passthrough.
//
// Order: a session name an integration reported over pane.report_metadata,
// then the terminal title, then herdr's name for the agent as a placeholder
// until the session has a name of its own.
func agentPaneLabel(pane map[string]any) *string {
	if reported := strings.TrimSpace(getStr(pane, "title")); reported != "" {
		return &reported
	}
	if title := strings.TrimSpace(getStr(pane, "terminal_title_stripped")); title != "" {
		return &title
	}
	if display := strings.TrimSpace(getStr(pane, "display_agent")); display != "" {
		return &display
	}
	if kind := strings.TrimSpace(getStr(pane, "agent")); kind != "" {
		return &kind
	}
	return nil
}

// A label the daemon didn't set means the user named it — stop managing it.
// Unlabeled panes and default numeric tab labels count as unowned, not manual.
// Caller must hold dataMu.
func claim(own *ownership, current, id string) bool {
	if own.Manual {
		return false
	}
	if current != "" && current != own.Set {
		own.Manual = true
		logf("manual takeover: %s (current=%q, set=%q)", id, current, own.Set)
		return false
	}
	return true
}

// Per-pane/tab job chains serialize syncs so a rename's response is recorded
// (own.Set) before the next pass evaluates the echoed event.
type scheduler struct {
	mu      sync.Mutex
	queues  map[string][]func()
	running map[string]bool
}

func newScheduler() *scheduler {
	return &scheduler{queues: map[string][]func(){}, running: map[string]bool{}}
}

func (s *scheduler) schedule(id string, fn func()) {
	wrapped := func() {
		defer func() {
			if r := recover(); r != nil {
				logf("sync error (%s): %v", id, r)
			}
		}()
		fn()
	}
	s.mu.Lock()
	s.queues[id] = append(s.queues[id], wrapped)
	if !s.running[id] {
		s.running[id] = true
		go s.drain(id)
	}
	s.mu.Unlock()
}

func (s *scheduler) drain(id string) {
	for {
		s.mu.Lock()
		queue := s.queues[id]
		if len(queue) == 0 {
			delete(s.running, id)
			delete(s.queues, id)
			s.mu.Unlock()
			return
		}
		fn := queue[0]
		s.queues[id] = queue[1:]
		s.mu.Unlock()
		fn()
	}
}

func (s *scheduler) idle() bool {
	s.mu.Lock()
	defer s.mu.Unlock()
	return len(s.running) == 0
}

var (
	paneJobs = newScheduler()
	tabJobs  = newScheduler()
)

func schedulePane(paneID string) { paneJobs.schedule(paneID, func() { syncPane(paneID) }) }
func scheduleTab(tabID string)   { tabJobs.schedule(tabID, func() { syncTab(tabID) }) }

func drainJobs() {
	for !paneJobs.idle() || !tabJobs.idle() {
		time.Sleep(10 * time.Millisecond)
	}
}

func syncPane(paneID string) {
	dataMu.Lock()
	_, known := panes[paneID]
	dataMu.Unlock()
	if !known {
		return
	}
	// Re-read at decision time rather than trusting the event snapshot: it can
	// be stale, and renaming from it would clobber a manual rename that landed
	// in between. Deriving the name and judging ownership from the same fresh
	// view keeps the two from disagreeing.
	freshRes := rpc("pane.get", map[string]any{"pane_id": paneID})
	pane, ok := freshRes["pane"].(map[string]any)
	if !ok {
		return
	}
	name := paneDisplayName(pane)
	dataMu.Lock()
	panes[paneID] = pane
	names[paneID] = name
	dataMu.Unlock()
	label := name
	kind := getStr(pane, "agent")
	if kind != "" {
		label = agentPaneLabel(pane)
	}
	current := getStr(pane, "label")
	dataMu.Lock()
	own := st.pane(paneID)
	// Herdr can stamp an agent pane's label itself (e.g. the agent kind or its
	// display name on detection). Like native tab renames, that's system
	// plumbing, not a user rename — re-adopt it instead of disowning the pane.
	if kind != "" && !own.Manual && current != "" && current != own.Set &&
		(current == kind || current == getStr(pane, "display_agent")) {
		own.Set = current
	}
	claimed := claim(own, current, paneID)
	dataMu.Unlock()
	if claimed && label != nil && *label != current {
		if rpc("pane.rename", map[string]any{"pane_id": paneID, "label": *label}) != nil {
			dataMu.Lock()
			own.Set = *label
			pane["label"] = *label
			dataMu.Unlock()
		}
	}
	dataMu.Lock()
	saveState()
	dataMu.Unlock()
	if tabID := getStr(pane, "tab_id"); tabID != "" {
		scheduleTab(tabID)
	}
}

func syncTab(tabID string) {
	dataMu.Lock()
	var tabPanes []map[string]any
	for _, p := range panes {
		if getStr(p, "tab_id") == tabID {
			tabPanes = append(tabPanes, p)
		}
	}
	activeID := st.ActivePaneByTab[tabID]
	dataMu.Unlock()
	if len(tabPanes) == 0 {
		return
	}
	active := tabPanes[0]
	for _, p := range tabPanes {
		if getStr(p, "pane_id") == activeID {
			active = p
			break
		}
	}
	// Read the label at decision time: event-fed caches can be stale (a late
	// event echo can carry a pre-rename label), and judging ownership from
	// stale data disowns tabs we in fact renamed ourselves.
	listedRes := rpc("tab.list", nil)
	if listedRes == nil {
		return
	}
	listed, _ := listedRes["tabs"].([]any)
	var self map[string]any
	for _, t := range listed {
		if tm, ok := t.(map[string]any); ok && getStr(tm, "tab_id") == tabID {
			self = tm
			break
		}
	}
	if self == nil {
		return
	}
	label := getStrPtr(self, "label")
	activePaneID := getStr(active, "pane_id")

	dataMu.Lock()
	tabLabels[tabID] = label
	current := "" // "" plays the role of null
	if label != nil && !integerLabel.MatchString(*label) {
		current = *label // integers are herdr defaults
	}
	own := st.tab(tabID)
	// Herdr natively renames agent tabs (e.g. to the agent session name). When
	// the label we didn't set is exactly the active pane's display name, that's
	// system plumbing, not a user rename — re-adopt it instead of disowning.
	raw := names[activePaneID]
	if !own.Manual && current != "" && current != own.Set && raw != nil && current == *raw {
		own.Set = current
	}
	claimed := claim(own, current, tabID)
	rawName := names[activePaneID]
	dataMu.Unlock()

	if claimed {
		name := ""
		if rawName != nil {
			// tmux-style dense tab numbering: prefix the tab's position within
			// its workspace, so it renumbers on close/reorder like tmux's
			// renumber-windows. tab.list returns display order, which tracks
			// reorders (the sticky `number` field does not).
			wsID := getStr(self, "workspace_id")
			pos := 0
			idx := 0
			for _, t := range listed {
				tm, ok := t.(map[string]any)
				if !ok || getStr(tm, "workspace_id") != wsID {
					continue
				}
				idx++
				if getStr(tm, "tab_id") == tabID {
					pos = idx
				}
			}
			name = fmt.Sprintf("%d: %s", pos, *rawName)
		}
		if name != "" && name != current {
			if rpc("tab.rename", map[string]any{"tab_id": tabID, "label": name}) != nil {
				dataMu.Lock()
				own.Set = name
				value := name
				tabLabels[tabID] = &value
				dataMu.Unlock()
			}
		}
	}
	dataMu.Lock()
	saveState()
	dataMu.Unlock()
}

func handleEvent(event string, data map[string]any) {
	switch event {
	case "pane_created", "pane_updated":
		pane, ok := data["pane"].(map[string]any)
		if !ok {
			return
		}
		paneID := getStr(pane, "pane_id")
		dataMu.Lock()
		prev := panes[paneID]
		panes[paneID] = pane
		if focused, _ := pane["focused"].(bool); focused {
			st.ActivePaneByTab[getStr(pane, "tab_id")] = paneID
		}
		changed := prev == nil
		if !changed {
			for _, f := range nameFields {
				if prev[f] != pane[f] {
					changed = true
					break
				}
			}
		}
		dataMu.Unlock()
		if changed {
			schedulePane(paneID)
		}
	case "pane_focused":
		paneID := getStr(data, "pane_id")
		dataMu.Lock()
		pane := panes[paneID]
		var tabID string
		if pane != nil {
			tabID = getStr(pane, "tab_id")
			st.ActivePaneByTab[tabID] = paneID
		}
		dataMu.Unlock()
		if tabID != "" {
			scheduleTab(tabID)
		}
	case "pane_closed":
		paneID := getStr(data, "pane_id")
		dataMu.Lock()
		pane := panes[paneID]
		delete(panes, paneID)
		delete(names, paneID)
		delete(st.Panes, paneID)
		saveState()
		var tabID string
		if pane != nil {
			tabID = getStr(pane, "tab_id")
		}
		dataMu.Unlock()
		if tabID != "" {
			scheduleTab(tabID)
		}
	case "tab_created":
		if tab, ok := data["tab"].(map[string]any); ok {
			dataMu.Lock()
			tabLabels[getStr(tab, "tab_id")] = getStrPtr(tab, "label")
			dataMu.Unlock()
		}
	case "tab_moved":
		// Positions shift for every tab in the workspace; renumber them all.
		// Don't copy payload labels into tabLabels — they're a move-time
		// snapshot and can clobber a fresher label from our own rename.
		if tabs, ok := data["tabs"].([]any); ok {
			for _, t := range tabs {
				if tm, ok := t.(map[string]any); ok {
					scheduleTab(getStr(tm, "tab_id"))
				}
			}
		}
	case "tab_renamed":
		// Just track it; manual-rename detection happens in claim() on the
		// next syncTab pass, avoiding a race against our own rename's echo.
		dataMu.Lock()
		tabLabels[getStr(data, "tab_id")] = getStrPtr(data, "label")
		dataMu.Unlock()
	case "tab_closed":
		tabID := getStr(data, "tab_id")
		dataMu.Lock()
		delete(tabLabels, tabID)
		delete(st.Tabs, tabID)
		delete(st.ActivePaneByTab, tabID)
		saveState()
		// Positions of later tabs shift down; renumber the workspace's tabs
		prefix := strings.SplitN(tabID, ":", 2)[0] + ":"
		var siblings []string
		for id := range tabLabels {
			if strings.HasPrefix(id, prefix) {
				siblings = append(siblings, id)
			}
		}
		dataMu.Unlock()
		for _, id := range siblings {
			scheduleTab(id)
		}
	}
}

func fullSync() {
	paneRes := rpc("pane.list", nil)
	tabRes := rpc("tab.list", nil)
	if paneRes == nil || tabRes == nil {
		return
	}
	livePanes, _ := paneRes["panes"].([]any)
	liveTabs, _ := tabRes["tabs"].([]any)
	if len(livePanes) == 0 || len(liveTabs) == 0 {
		return
	}

	dataMu.Lock()
	panes = map[string]map[string]any{}
	names = map[string]*string{}
	tabLabels = map[string]*string{}
	for _, p := range livePanes {
		pm, ok := p.(map[string]any)
		if !ok {
			continue
		}
		paneID := getStr(pm, "pane_id")
		panes[paneID] = pm
		if focused, _ := pm["focused"].(bool); focused {
			st.ActivePaneByTab[getStr(pm, "tab_id")] = paneID
		}
	}
	for _, t := range liveTabs {
		if tm, ok := t.(map[string]any); ok {
			tabLabels[getStr(tm, "tab_id")] = getStrPtr(tm, "label")
		}
	}

	// Adopt current labels for anything we hold no ownership record for (fresh
	// panes/tabs, or after reset / lost state) — otherwise claim() would treat
	// every pre-existing label as a manual rename and stop managing it.
	for _, pm := range panes {
		if label := getStr(pm, "label"); label != "" {
			own := st.pane(getStr(pm, "pane_id"))
			if own.Set == "" {
				own.Set = label
			}
		}
	}
	for id, label := range tabLabels {
		if label != nil && *label != "" && !integerLabel.MatchString(*label) {
			own := st.tab(id)
			if own.Set == "" {
				own.Set = *label
			}
		}
	}

	// Drop state for closed panes/tabs
	for id := range st.Panes {
		if _, ok := panes[id]; !ok {
			delete(st.Panes, id)
		}
	}
	for id := range st.Tabs {
		if _, ok := tabLabels[id]; !ok {
			delete(st.Tabs, id)
		}
	}
	for id := range st.ActivePaneByTab {
		if _, ok := tabLabels[id]; !ok {
			delete(st.ActivePaneByTab, id)
		}
	}
	saveState()
	paneIDs := make([]string, 0, len(panes))
	for id := range panes {
		paneIDs = append(paneIDs, id)
	}
	dataMu.Unlock()

	for _, id := range paneIDs {
		schedulePane(id)
	}
}

// Returns when the event stream drops; the daemon loop reconnects.
func runConnection() error {
	conn, err := net.Dial("unix", socketPath)
	if err != nil {
		return err
	}
	defer conn.Close()
	subs := make([]map[string]string, len(subscriptions))
	for i, t := range subscriptions {
		subs[i] = map[string]string{"type": t}
	}
	req, _ := json.Marshal(map[string]any{
		"id": "sub", "method": "events.subscribe",
		"params": map[string]any{"subscriptions": subs},
	})
	if _, err := conn.Write(append(req, '\n')); err != nil {
		return err
	}
	subscribed := false
	sc := newScanner(conn)
	for sc.Scan() {
		line := strings.TrimSpace(sc.Text())
		if line == "" {
			continue
		}
		var msg map[string]any
		if json.Unmarshal([]byte(line), &msg) != nil {
			continue
		}
		if !subscribed && msg["id"] == "sub" {
			if msg["result"] == nil || msg["result"] == false {
				return errors.New("events.subscribe failed")
			}
			subscribed = true
			fullSync()
			logf("connected; event-driven sync active")
			continue
		}
		if event, ok := msg["event"].(string); ok {
			data, _ := msg["data"].(map[string]any)
			if data == nil {
				data = map[string]any{}
			}
			handleEvent(event, data)
		}
	}
	logf("event stream closed")
	return nil
}

// --- daemon lifecycle ---

func daemon() {
	os.WriteFile(pidFile, []byte(strconv.Itoa(os.Getpid())), 0o644)
	logf("daemon started (pid %d)", os.Getpid())
	for {
		if err := runConnection(); err != nil {
			logf("connection error: %v", err)
		}
		time.Sleep(reconnectDelay)
	}
}

func daemonPid() int {
	raw, err := os.ReadFile(pidFile)
	if err != nil {
		return 0
	}
	pid, err := strconv.Atoi(strings.TrimSpace(string(raw)))
	if err != nil || pid <= 0 {
		return 0
	}
	if syscall.Kill(pid, 0) != nil {
		return 0
	}
	return pid
}

func main() {
	cmd := "status"
	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}
	os.MkdirAll(configDir, 0o755)
	st = loadState()

	switch cmd {
	case "daemon":
		daemon()
	case "start":
		if daemonPid() != 0 {
			fmt.Println("smart-titles already running")
			return
		}
		exe, err := os.Executable()
		if err != nil {
			fmt.Fprintln(os.Stderr, "smart-titles: cannot locate own binary:", err)
			os.Exit(1)
		}
		child := exec.Command(exe, "daemon")
		child.SysProcAttr = &syscall.SysProcAttr{Setsid: true}
		if err := child.Start(); err != nil {
			fmt.Fprintln(os.Stderr, "smart-titles: failed to start daemon:", err)
			os.Exit(1)
		}
		pid := child.Process.Pid
		child.Process.Release()
		fmt.Printf("smart-titles started (pid %d)\n", pid)
	case "stop":
		if pid := daemonPid(); pid != 0 {
			syscall.Kill(pid, syscall.SIGTERM)
			os.Remove(pidFile)
			fmt.Println("smart-titles stopped")
		} else {
			fmt.Println("smart-titles not running")
		}
	case "status":
		if pid := daemonPid(); pid != 0 {
			fmt.Printf("smart-titles running (pid %d)\n", pid)
		} else {
			fmt.Println("smart-titles stopped")
		}
	case "sync":
		fullSync()
		drainJobs()
		fmt.Println("synced")
	case "reset":
		os.Remove(stateFile)
		fmt.Println("smart-titles state cleared; auto-naming resumes on all panes/tabs")
	default:
		fmt.Fprintf(os.Stderr, "unknown command: %s\n", cmd)
		os.Exit(1)
	}
}
