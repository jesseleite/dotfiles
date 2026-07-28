package main

import "testing"

// The contract is a passthrough, and these cases exist to keep it one: the
// agent's session name arrives verbatim, whatever shape a given harness gives
// it. Anything that looks like cleanup belongs in herdr, not here.
func TestAgentPaneLabel(t *testing.T) {
	cases := []struct {
		name string
		pane map[string]any
		want string
	}{
		// Whatever the harness puts in its title is the label, untouched.
		{"claude", map[string]any{"agent": "claude", "terminal_title_stripped": "✳ Fix the title sync"}, "✳ Fix the title sync"},
		{"grok", map[string]any{"agent": "grok", "terminal_title_stripped": "User Demands Title - grok"}, "User Demands Title - grok"},
		{"grok mid-turn", map[string]any{"agent": "grok", "terminal_title_stripped": "⠧ - Responding - User Demands Title - grok"}, "⠧ - Responding - User Demands Title - grok"},
		{"non-latin", map[string]any{"agent": "claude", "terminal_title_stripped": "修复标题同步"}, "修复标题同步"},

		// A session name reported over pane.report_metadata outranks the title.
		{"reported title wins", map[string]any{"agent": "opencode", "title": "Explaining git rebase", "terminal_title_stripped": "opencode"}, "Explaining git rebase"},

		// No title yet: fall back to herdr's name for the agent.
		{"display agent fallback", map[string]any{"agent": "opencode", "display_agent": "opencode (gpt-5.6)"}, "opencode (gpt-5.6)"},
		{"kind fallback", map[string]any{"agent": "gemini"}, "gemini"},
	}
	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			got := agentPaneLabel(tc.pane)
			if got == nil {
				t.Fatalf("got nil, want %q", tc.want)
			}
			if *got != tc.want {
				t.Fatalf("got %q, want %q", *got, tc.want)
			}
		})
	}
}
