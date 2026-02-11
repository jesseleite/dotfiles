package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"log"
	"math/rand/v2"
	"os"
	"path/filepath"
	"strings"
)

func loadNames() []string {
	exe, err := os.Executable()
	if err != nil {
		log.Fatalf("failed to resolve executable path: %v", err)
	}

	data, err := os.ReadFile(filepath.Join(filepath.Dir(exe), "names.txt"))
	if err != nil {
		log.Fatalf("failed to read names.txt: %v", err)
	}

	var names []string
	for line := range strings.SplitSeq(strings.TrimSpace(string(data)), "\n") {
		if line = strings.TrimSpace(line); line != "" {
			names = append(names, line)
		}
	}

	return names
}

func respond(w *bufio.Writer, id any, result any) {
	data, _ := json.Marshal(map[string]any{"jsonrpc": "2.0", "id": id, "result": result})
	fmt.Fprintf(w, "%s\n", data)
	w.Flush()
}

func main() {
	names := loadNames()

	scanner := bufio.NewScanner(os.Stdin)
	writer := bufio.NewWriter(os.Stdout)

	for scanner.Scan() {
		line := scanner.Bytes()
		if len(line) == 0 {
			continue
		}

		var req struct {
			ID     any    `json:"id,omitempty"`
			Method string `json:"method"`
		}
		if err := json.Unmarshal(line, &req); err != nil {
			continue
		}

		switch req.Method {
		case "initialize":
			respond(writer, req.ID, map[string]any{
				"protocolVersion": "2024-11-05",
				"capabilities":    map[string]any{"tools": map[string]any{}},
				"serverInfo":      map[string]any{"name": "liege", "version": "1.0.0"},
			})
		case "tools/list":
			respond(writer, req.ID, map[string]any{
				"tools": []map[string]any{{
					"name":        "beseech",
					"description": "Returns a random honorific name for the user.",
					"inputSchema": map[string]any{"type": "object", "properties": map[string]any{}},
				}},
			})
		case "tools/call":
			respond(writer, req.ID, map[string]any{
				"content": []map[string]any{{
					"type": "text",
					"text": names[rand.IntN(len(names))],
				}},
			})
		}
	}
}
