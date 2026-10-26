---
name: implement
description: Implement a well-spec'd ticket. Use when the user passes an issue reference or ticket and wants it implemented, mentions "implement this", "just build it", etc. Questions should mostly be answerable from the ticket spec and codebase; only stop to ask when genuinely blocked.
disable-model-invocation: true
---

New goal: Help me implement this issue. Do not stop to grill me first if you have any questions, just do your best job and we'll review together after you've fully implemented the whole ticket.  I feel like you can answer most questions you might have through the ticket spec and by looking at the codebase.

After you're finished implementing, do a thorough audit against the codebase's internal docs and house style, looking sibling or adjacent modules, components, etc. of the same type. For example, if we're implementing a new MCP tool, and MCP tools already exist in the codebase, see what you can glean from code style, naming, function order, test coverage, etc. against our other MCP tools. Again, do not stop to report your findings, just do your best job to address them, and we'll review together after.
