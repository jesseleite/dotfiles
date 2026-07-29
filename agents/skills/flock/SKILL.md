---
name: flock
description: Perform a given action by asking a flock of various agents to tackle in parallel.
---

When asked to perform a given action using the flock skill, do the following steps in this order:

1. Given the following agents:
    - Claude (via `claude` CLI)
    - GPT (via `opencode` CLI)
    - Grok (via `grok` CLI)

2. Open all of the agents in new /herdr tabs in this workspace.
    - Name each herdr tab using this format `flock-{agent}` (ie. `flock-claude`, `flock-gpt`, etc.)

3. Perform the action the user has provided in these new agent tabs, using herdr to prompt each in parallel.

4. After all agents are finished, combine and consolidate their output as sensibly as possible.
    - Do not rush the agents, give them the time they need.
    - Only intervene if they are legitimately stuck (ie. can't write to /tmp as herdr suggests, etc.)

5. Report back to this agent with the consolidated findings.

6. Close all herdr tabs you opened for this flock task.
