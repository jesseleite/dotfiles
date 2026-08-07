// herdr-move-workspace: shift the current workspace up or down in the
// sidebar list, like tmux's swap-window for sessions.
//
// Herdr has no built-in move-workspace keybinding, only the workspace.move
// socket API. Its insert index is measured against the list that still
// contains the moving workspace, so shifting one slot down is index+2,
// not index+1 (same semantics as tab.move).
//
// Build: go build -o herdr-move-workspace .
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

type workspace struct {
	WorkspaceID string `json:"workspace_id"`
	Focused     bool   `json:"focused"`
}

func main() {
	if len(os.Args) < 2 || (os.Args[1] != "up" && os.Args[1] != "down") {
		fail("usage: herdr-move-workspace up|down")
	}

	var list struct {
		Workspaces []workspace `json:"workspaces"`
	}
	rpc("workspace.list", nil, &list)

	// Plugin actions get HERDR_WORKSPACE_ID (and sometimes the ACTIVE_ form);
	// fall back to whatever herdr reports as focused so the binary also
	// works when run by hand.
	current := firstEnv("HERDR_WORKSPACE_ID", "HERDR_ACTIVE_WORKSPACE_ID")
	if current == "" {
		for _, w := range list.Workspaces {
			if w.Focused {
				current = w.WorkspaceID
				break
			}
		}
	}
	if current == "" {
		return
	}

	order := make([]string, 0, len(list.Workspaces))
	for _, w := range list.Workspaces {
		order = append(order, w.WorkspaceID)
	}
	at := -1
	for i, id := range order {
		if id == current {
			at = i
			break
		}
	}

	insert := at - 1
	if os.Args[1] == "down" {
		insert = at + 2
	}
	if at < 0 || insert < 0 || insert > len(order) {
		return // already at the edge, nothing to do
	}

	rpc("workspace.move", map[string]any{"workspace_id": current, "insert_index": insert}, nil)
}

func firstEnv(keys ...string) string {
	for _, k := range keys {
		if v := os.Getenv(k); v != "" {
			return v
		}
	}
	return ""
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
	fmt.Fprintln(os.Stderr, "move-workspace: "+message)
	os.Exit(1)
}
