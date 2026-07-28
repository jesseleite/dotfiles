// herdr-smart-next-agent: cycle herdr agents, neediest first.
//
// Every agent lives in one ranked list: blocked first, then finished-but-unseen
// (status "done"), freshest first, then everyone else in panel order. A press
// jumps to whatever became needy since the last press; failing that it carries
// on from wherever the last press left you, so holding the key tours every
// agent instead of ping-ponging between two tabs.
//
// That tour needs two facts a single `herdr agent list` cannot supply: which
// pane we sent you to last, and how far agent state had moved when we did.
// Both live in state.json next to the plugin config; nothing else is kept.
//
// Build: go build -o herdr-smart-next-agent .
// Pass --dry-run to print the target instead of jumping.
package main

import (
	"encoding/json"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
)

type agent struct {
	PaneID         string `json:"pane_id"`
	Status         string `json:"agent_status"`
	Focused        bool   `json:"focused"`
	StateChangeSeq int64  `json:"state_change_seq"`
}

type state struct {
	LastTarget string `json:"last_target"`
	SeenSeq    int64  `json:"seen_seq"`
}

var attention = map[string]int{"blocked": 2, "done": 1}

func main() {
	dryRun := len(os.Args) > 1 && os.Args[1] == "--dry-run"

	target, next, ok := choose(listAgents(), loadState())
	if !ok {
		return
	}
	if dryRun {
		fmt.Printf("would focus: %s (%s)\n", target.PaneID, target.Status)
		return
	}

	saveState(next)
	if err := exec.Command("herdr", "agent", "focus", target.PaneID).Run(); err != nil {
		fail("herdr agent focus "+target.PaneID, err)
	}
}

// choose picks the next agent to focus, in order of preference:
//
//  1. Anything that became needy since the last press. A new notification wins
//     wherever it sits in the order; that is the whole point of the key.
//  2. If you are still standing where the last press put you, continue the
//     tour: the next needy agent while you are among them, otherwise the next
//     agent in the ranked list.
//  3. Otherwise this press came from somewhere we did not send you, so start at
//     the top: the neediest agent, or plain panel-order cycling when nobody
//     needs anything.
func choose(agents []agent, st state) (agent, state, bool) {
	if len(agents) == 0 {
		return agent{}, st, false
	}

	var needy, rest []agent
	for _, a := range agents {
		if attention[a.Status] > 0 {
			needy = append(needy, a)
		} else {
			rest = append(rest, a)
		}
	}
	// Stable, so equal-rank agents keep panel order and the list stays put
	// underneath a tour; only a genuine status change moves anyone.
	sort.SliceStable(needy, func(i, j int) bool {
		if attention[needy[i].Status] != attention[needy[j].Status] {
			return attention[needy[i].Status] > attention[needy[j].Status]
		}
		return needy[i].StateChangeSeq > needy[j].StateChangeSeq
	})
	ranked := append(append([]agent{}, needy...), rest...)

	focused, focusedNeedy := "", false
	for _, a := range agents {
		if a.Focused {
			focused, focusedNeedy = a.PaneID, attention[a.Status] > 0
			break
		}
	}

	var target *agent
	for i := range needy {
		if needy[i].StateChangeSeq > st.SeenSeq {
			target = &needy[i] // needy is ranked already, so this is the most urgent new one
			break
		}
	}
	if target == nil {
		switch {
		case focused != "" && focused == st.LastTarget:
			if focusedNeedy && len(needy) > 1 {
				target = nextAfter(needy, focused)
			} else {
				target = nextAfter(ranked, focused)
			}
		case len(needy) > 0:
			target = &needy[0]
		case focused != "":
			target = nextAfter(ranked, focused)
		default:
			target = &ranked[0]
		}
	}

	// Never re-focus the pane we are already on; step past it instead.
	if target == nil || target.PaneID == focused {
		if target = nextAfter(ranked, focused); target == nil {
			return agent{}, st, false
		}
	}

	seen := st.SeenSeq
	for _, a := range agents {
		if a.StateChangeSeq > seen {
			seen = a.StateChangeSeq
		}
	}
	return *target, state{LastTarget: target.PaneID, SeenSeq: seen}, true
}

// nextAfter returns the entry following paneID, wrapping at the end. It returns
// nil when there is nowhere else to go, and the first entry when paneID is not
// in the list at all.
func nextAfter(list []agent, paneID string) *agent {
	if len(list) < 2 {
		return nil
	}
	for i := range list {
		if list[i].PaneID == paneID {
			return &list[(i+1)%len(list)]
		}
	}
	return &list[0]
}

func listAgents() []agent {
	out, err := exec.Command("herdr", "agent", "list").Output()
	if err != nil {
		fail("herdr agent list", err)
	}

	var resp struct {
		Result struct {
			Agents []agent `json:"agents"`
		} `json:"result"`
	}
	if err := json.Unmarshal(out, &resp); err != nil {
		fail("parse agent list", err)
	}
	return resp.Result.Agents
}

func statePath() string {
	dir := os.Getenv("HERDR_PLUGIN_CONFIG_DIR")
	if dir == "" {
		home, _ := os.UserHomeDir()
		dir = filepath.Join(home, ".config/herdr/plugins/config/smart-next-agent")
	}
	return filepath.Join(dir, "state.json")
}

func loadState() state {
	var st state
	if raw, err := os.ReadFile(statePath()); err == nil {
		json.Unmarshal(raw, &st)
	}
	return st
}

func saveState(st state) {
	path := statePath()
	if os.MkdirAll(filepath.Dir(path), 0o755) != nil {
		return
	}
	if raw, err := json.Marshal(st); err == nil {
		os.WriteFile(path, raw, 0o644)
	}
}

func fail(what string, err error) {
	fmt.Fprintf(os.Stderr, "smart-next-agent: %s: %v\n", what, err)
	os.Exit(1)
}
