package main

import (
	"bufio"
	"encoding/json"
	"fmt"
	"os"
	"regexp"
	"strings"
	"unicode/utf8"
)

func respond(w *bufio.Writer, id any, result any) {
	data, _ := json.Marshal(map[string]any{"jsonrpc": "2.0", "id": id, "result": result})
	fmt.Fprintf(w, "%s\n", data)
	w.Flush()
}

var (
	reBold   = regexp.MustCompile(`\*\*(.+?)\*\*`)
	reItalic = regexp.MustCompile(`\*(.+?)\*`)
	reCode   = regexp.MustCompile("`([^`]+)`")
)

// visibleWidth returns the rendered width of a string after markdown
// inline formatting markers (bold, italic, inline code) are consumed.
func visibleWidth(s string) int {
	s = reBold.ReplaceAllString(s, "$1")
	s = reItalic.ReplaceAllString(s, "$1")
	s = reCode.ReplaceAllString(s, "$1")
	return utf8.RuneCountInString(s)
}

const instructions = "Call the `render` tool whenever you are about to render a markdown-formatted table. " +
	"Pass the raw markdown table text (including the header, separator, and data rows) inside `data.table`. " +
	"Then output the result EXACTLY as returned, as plain text. " +
	"NEVER wrap the returned table in a fenced code block. " +
	"Don't just rely on the harness to display tool output; ALWAYS render the output text from the tool when responding to me with the table."

func parseMarkdownTable(input string) ([]string, [][]string) {
	lines := strings.Split(strings.TrimSpace(input), "\n")

	var headers []string
	var rows [][]string

	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}

		// Strip leading/trailing pipes
		line = strings.TrimPrefix(line, "|")
		line = strings.TrimSuffix(line, "|")

		// Check if this is a separator row (e.g. ---|---|---)
		stripped := strings.ReplaceAll(line, "-", "")
		stripped = strings.ReplaceAll(stripped, "|", "")
		stripped = strings.ReplaceAll(stripped, ":", "")
		stripped = strings.TrimSpace(stripped)
		if stripped == "" {
			continue
		}

		cells := strings.Split(line, "|")
		var trimmed []string
		for _, cell := range cells {
			trimmed = append(trimmed, strings.TrimSpace(cell))
		}

		if headers == nil {
			headers = trimmed
		} else {
			rows = append(rows, trimmed)
		}
	}

	return headers, rows
}

func renderTable(headers []string, rows [][]string) string {
	numCols := len(headers)

	// Normalize all rows to have the same number of columns
	for i := range rows {
		for len(rows[i]) < numCols {
			rows[i] = append(rows[i], "")
		}
	}

	// Compute column widths based on visible text (stripping markdown formatting)
	widths := make([]int, numCols)
	for i, h := range headers {
		if w := visibleWidth(h); w > widths[i] {
			widths[i] = w
		}
	}
	for _, row := range rows {
		for i := 0; i < numCols && i < len(row); i++ {
			if w := visibleWidth(row[i]); w > widths[i] {
				widths[i] = w
			}
		}
	}

	// Helper to build a horizontal border line
	borderLine := func(left, mid, right, fill string) string {
		parts := make([]string, numCols)
		for i, w := range widths {
			parts[i] = strings.Repeat(fill, w+2) // +2 for padding spaces
		}
		return left + strings.Join(parts, mid) + right
	}

	// Helper to build a data row, padding based on visible width
	dataRow := func(cells []string) string {
		parts := make([]string, numCols)
		for i := 0; i < numCols; i++ {
			cell := ""
			if i < len(cells) {
				cell = cells[i]
			}
			pad := widths[i] - visibleWidth(cell)
			if pad < 0 {
				pad = 0
			}
			parts[i] = " " + cell + strings.Repeat(" ", pad) + " "
		}
		return "│" + strings.Join(parts, "│") + "│"
	}

	var sb strings.Builder

	// Top border
	sb.WriteString(borderLine("┌", "┬", "┐", "─"))
	sb.WriteString("\n")

	// Header row (bold)
	bolded := make([]string, numCols)
	for i, h := range headers {
		bolded[i] = "**" + h + "**"
	}
	sb.WriteString(dataRow(bolded))
	sb.WriteString("\n")

	// Rows with separators between each
	for _, row := range rows {
		sb.WriteString(borderLine("├", "┼", "┤", "─"))
		sb.WriteString("\n")
		sb.WriteString(dataRow(row))
		sb.WriteString("\n")
	}

	// Bottom border
	sb.WriteString(borderLine("└", "┴", "┘", "─"))

	return sb.String()
}

func main() {
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
				"protocolVersion": "2025-11-25",
				"capabilities":    map[string]any{"tools": map[string]any{}},
				"serverInfo":      map[string]any{"name": "pretty_table", "version": "1.0.0"},
				"instructions":    instructions,
			})
		case "prompts/list":
			respond(writer, req.ID, map[string]any{"prompts": []any{}})
		case "resources/list":
			respond(writer, req.ID, map[string]any{"resources": []any{}})
		case "tools/list":
			respond(writer, req.ID, map[string]any{
				"tools": []map[string]any{{
					"name":        "render",
					"description": instructions,
					"inputSchema": map[string]any{
						"type": "object",
						"properties": map[string]any{
							"data": map[string]any{
								"type": "object",
								"properties": map[string]any{
									"table": map[string]any{
										"type":        "string",
										"description": "The raw markdown table text, including header row, separator row, and data rows.",
									},
								},
								"required": []string{"table"},
							},
						},
						"required": []string{"data"},
					},
				}},
			})
		case "tools/call":
			// Parse the arguments to get the table text from data.table
			var fullReq struct {
				Params struct {
					Arguments map[string]any `json:"arguments"`
				} `json:"params"`
			}
			json.Unmarshal(line, &fullReq)

			var tableText string
			if data, ok := fullReq.Params.Arguments["data"].(map[string]any); ok {
				tableText, _ = data["table"].(string)
			}

			if tableText == "" {
				respond(writer, req.ID, map[string]any{
					"content": []map[string]any{{
						"type": "text",
						"text": "Error: no table text provided.",
					}},
				})
				continue
			}

			headers, rows := parseMarkdownTable(tableText)

			if len(headers) == 0 {
				respond(writer, req.ID, map[string]any{
					"content": []map[string]any{{
						"type": "text",
						"text": "Error: could not parse markdown table.",
					}},
				})
				continue
			}

			result := renderTable(headers, rows)
			respond(writer, req.ID, map[string]any{
				"content": []map[string]any{{
					"type": "text",
					"text": result,
				}},
			})
		}
	}
}
