---
name: commit
description: Plan a sequenced set of commits matching repo message style, then land them one at a time with staged diffs previewed in Hunk to the right of the agent. Use when the user wants to break work into commits, land a series of commits, or runs /commit.
---

When asked to break work into commits or run /commit, do the following in order:

1. Plan commits (do not stage yet):
    - Inspect the worktree and recent commits on this branch/repo
    - Propose a sensible sequence of commits
        - Ideally not too small or too big
        - Find the right balance between atomic and related changes, by functionality and intent
        - Don't be concerned about the number of commits if there are a lot of unstaged changes
        - Match commit atomicity and message style already used on this branch
            - Only sample the user's own commits for style (eg. `git log --author=...`)
            - Do not glean style from bot-generated commits or merge commits
        - No ticket numbers in commit subjects unless specifically referencing a different ticket
        - If helpful, include relevant context, reasoning, and decision making in the commit body
    - Wait for the user to agree on the high-level plan before staging anything
    - Grill the user if sequencing or scope is genuinely ambiguous

2. For each commit, one at a time:
    - Git stage only that commit's changes
    - Open (or reuse, if one exists) a Herdr pane to the **right** of the current agent pane
    - Show the staged diff there with Hunk (eg. `hunk diff --staged --watch --sidebar`)
    - Tell the user the commit number, proposed message, and that Hunk is ready on the right
        - Always refresh the Hunk diff and clear review notes at this point
        - Do **not** steal focus from the agent pane while they may still be typing
    - **Stop.** Wait for approval, message edits, or Hunk notes
    - If they leave Hunk notes:
        - Address any changes that need to be made
        - Grill the user if further clarification is needed
        - Feel free to reply to specific user notes as agent notes in Hunk
        - Re-stage relevant changes and wait again
            - With `hunk --watch` flag, you shouldn't need to refresh hunk for user to see changes
    - Commit only when the user is happy and explicitly says to
        - Never git push unless explicitly asked (and NEVER push to main/master/default branch)

3. After each successful commit, immediately stage and preview the next one the same way until the plan is done (or the user pauses).

4. When finished:
    - Summarize what landed
    - Leave the Hunk pane alone unless they want it closed
