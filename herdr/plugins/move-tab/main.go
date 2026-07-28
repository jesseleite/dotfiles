// herdr-move-tab: shift the current tab left or right within its workspace,
// like tmux's swap-window -t -1/+1.
//
// Herdr has no built-in move-tab keybinding, only the tab.move socket API.
// Its insert index is measured against the tab list that still contains the
// moving tab, so shifting one slot right is index+2, not index+1.
//
// Build: go build -o herdr-move-tab .
package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"net"
	"os"
	"path/filepath"
	"strings"
)

type tab struct {
	TabID       string `json:"tab_id"`
	WorkspaceID string `json:"workspace_id"`
	Focused     bool   `json:"focused"`
}

func main() {
	if len(os.Args) < 2 || (os.Args[1] != "left" && os.Args[1] != "right") {
		fail("usage: herdr-move-tab left|right")
	}

	var list struct {
		Tabs []tab `json:"tabs"`
	}
	rpc("tab.list", nil, &list)

	// Plugin actions get HERDR_TAB_ID; fall back to whatever herdr reports as
	// focused so the binary also works when run by hand.
	current := os.Getenv("HERDR_TAB_ID")
	if current == "" {
		for _, t := range list.Tabs {
			if t.Focused {
				current = t.TabID
				break
			}
		}
	}
	if current == "" {
		return
	}

	var workspace string
	for _, t := range list.Tabs {
		if t.TabID == current {
			workspace = t.WorkspaceID
			break
		}
	}
	if workspace == "" {
		fail("tab " + current + " not found")
	}

	var order []string
	for _, t := range list.Tabs {
		if t.WorkspaceID == workspace {
			order = append(order, t.TabID)
		}
	}
	at := -1
	for i, id := range order {
		if id == current {
			at = i
			break
		}
	}

	insert := at - 1
	if os.Args[1] == "right" {
		insert = at + 2
	}
	if at < 0 || insert < 0 || insert > len(order) {
		return // already at the edge, nothing to do
	}

	rpc("tab.move", map[string]any{"tab_id": current, "insert_index": insert}, nil)
}

// rpc sends one newline-framed request; the server answers and closes.
func rpc(method string, params map[string]any, result any) {
	socket := os.Getenv("HERDR_SOCKET_PATH")
	if socket == "" {
		home, _ := os.UserHomeDir()
		socket = filepath.Join(home, ".config/herdr/herdr.sock")
	}
	conn, err := net.Dial("unix", socket)
	if err != nil {
		fail("dial " + socket + ": " + err.Error())
	}
	defer conn.Close()

	if params == nil {
		params = map[string]any{}
	}
	req, _ := json.Marshal(map[string]any{"id": "1", "method": method, "params": params})
	if _, err := conn.Write(append(req, '\n')); err != nil {
		fail(method + ": " + err.Error())
	}

	sc := bufio.NewScanner(conn)
	sc.Buffer(make([]byte, 0, 64*1024), 4*1024*1024)
	for sc.Scan() {
		line := strings.TrimSpace(sc.Text())
		if line == "" {
			continue
		}
		var msg struct {
			Result json.RawMessage `json:"result"`
			Error  *struct {
				Message string `json:"message"`
			} `json:"error"`
		}
		if json.Unmarshal([]byte(line), &msg) != nil {
			continue
		}
		if msg.Error != nil {
			fail(method + ": " + msg.Error.Message)
		}
		if result != nil && len(msg.Result) > 0 {
			json.Unmarshal(msg.Result, result)
		}
		return
	}
	fail(method + ": no response")
}

func fail(message string) {
	fmt.Fprintln(os.Stderr, "move-tab: "+message)
	os.Exit(1)
}
