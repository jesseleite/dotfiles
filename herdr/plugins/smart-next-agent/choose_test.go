package main

import "testing"

// press runs one keypress against agents, moves focus to whatever was chosen
// (as herdr would) and returns the new pane and state.
func press(t *testing.T, agents []agent, st state) ([]agent, state, string) {
	t.Helper()
	target, next, ok := choose(agents, st)
	if !ok {
		return agents, st, ""
	}
	for i := range agents {
		agents[i].Focused = agents[i].PaneID == target.PaneID
	}
	return agents, next, target.PaneID
}

func agents(specs ...agent) []agent { return specs }

func blocked(id string, seq int64) agent { return agent{PaneID: id, Status: "blocked", StateChangeSeq: seq} }
func done(id string, seq int64) agent    { return agent{PaneID: id, Status: "done", StateChangeSeq: seq} }
func idle(id string, seq int64) agent    { return agent{PaneID: id, Status: "idle", StateChangeSeq: seq} }

func focus(list []agent, id string) []agent {
	for i := range list {
		list[i].Focused = list[i].PaneID == id
	}
	return list
}

// The old bug: a lone blocked agent was a fixed point, because pool[(i+1)%1]
// is the agent you are already on.
func TestLoneBlockedAgentDoesNotStall(t *testing.T) {
	list := focus(agents(blocked("a", 10), idle("b", 1), idle("c", 2)), "a")
	st := state{LastTarget: "a", SeenSeq: 10}

	target, _, ok := choose(list, st)
	if !ok || target.PaneID == "a" {
		t.Fatalf("expected to move off the blocked agent, got %q (ok=%v)", target.PaneID, ok)
	}
}

// Holding the key should walk everyone rather than bouncing between two tabs.
func TestTourVisitsEveryAgent(t *testing.T) {
	list := focus(agents(blocked("a", 10), idle("b", 1), idle("c", 2), idle("d", 3)), "d")
	st := state{}

	seen := map[string]bool{}
	for i := 0; i < 4; i++ {
		var target string
		list, st, target = press(t, list, st)
		if target == "" {
			t.Fatalf("press %d chose nothing", i)
		}
		seen[target] = true
	}
	for _, id := range []string{"a", "b", "c", "d"} {
		if !seen[id] {
			t.Errorf("four presses never reached %q (visited %v)", id, seen)
		}
	}
}

// A notification arriving mid-tour wins the next press, wherever it sits.
func TestNewNotificationInterruptsTour(t *testing.T) {
	list := focus(agents(idle("a", 1), idle("b", 2), idle("c", 3)), "a")
	st := state{}

	list, st, _ = press(t, list, st) // tour into the idles
	list, st, _ = press(t, list, st)

	list[0].Status = "blocked" // "a" starts needing input, seq moves past SeenSeq
	list[0].StateChangeSeq = 99

	target, _, ok := choose(list, st)
	if !ok || target.PaneID != "a" {
		t.Fatalf("expected the newly blocked agent, got %q (ok=%v)", target.PaneID, ok)
	}
}

// Two agents wanting attention should both be reachable by repeated presses.
func TestCyclesThroughMultipleNeedy(t *testing.T) {
	list := focus(agents(blocked("a", 10), done("b", 9), idle("c", 1)), "c")
	st := state{SeenSeq: 10} // both already seen, so this is a tour, not an interrupt

	list, st, first := press(t, list, st)
	_, _, second := press(t, list, st)

	if first != "a" || second != "b" {
		t.Fatalf("expected a then b, got %q then %q", first, second)
	}
}

// A press from a pane we did not send you to starts over at the neediest.
func TestFreshPressStartsAtNeediest(t *testing.T) {
	list := focus(agents(idle("a", 1), blocked("b", 5), done("c", 4)), "a")
	st := state{LastTarget: "c", SeenSeq: 99} // nothing is new; we are not where we were sent

	target, _, ok := choose(list, st)
	if !ok || target.PaneID != "b" {
		t.Fatalf("expected the blocked agent, got %q (ok=%v)", target.PaneID, ok)
	}
}

func TestNowhereToGo(t *testing.T) {
	if _, _, ok := choose(nil, state{}); ok {
		t.Error("expected no target with no agents")
	}
	if _, _, ok := choose(focus(agents(blocked("a", 1)), "a"), state{}); ok {
		t.Error("expected no target when the only agent is already focused")
	}
}
