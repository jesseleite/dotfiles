---
name: commit
description: Plan a sequenced set of commits matching repo message style, then land them one at a time with staged diffs previewed in Hunk beside the agent. Use when the user wants to break work into commits, land a series of commits, or runs /commit.
disable-model-invocation: true
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
        - Never include agent attribution in commit messages (ie. `Co-Authored-By: [agent]` trailers, or "Generated with [agent]" lines)
    - Wait for the user to agree on the high-level plan before staging anything
    - Grill the user if sequencing or scope is genuinely ambiguous

2. For each commit, one at a time:
    - Git stage only that commit's changes
    - Run `~/.config/rex/hunk-preview` to show the staged diff in Hunk
        - It opens a live Hunk preview beside the agent (a pane on the right, or the next tab on small screens), without stealing focus
        - Hunk watches the staged diff, so it only needs to be opened once, and running it again just reuses it
        - Do not open, size, or manage the preview yourself
    - Tell the user the commit number, proposed message, and where Hunk is (as the script reported)
        - Always clear review notes at this point
    - **Stop.** Wait for approval, message edits, or Hunk notes
    - If they leave Hunk notes:
        - Address any changes that need to be made
        - Grill the user if further clarification is needed
        - Feel free to reply to specific user notes as agent notes in Hunk
        - Re-stage relevant changes and wait again
            - Hunk is watching, so you shouldn't need to refresh it for the user to see changes
    - Commit only when the user is happy and explicitly says to
        - Never git push unless explicitly asked (and NEVER push to main/master/default branch)

3. After each successful commit, immediately stage and preview the next one the same way until the plan is done (or the user pauses).

4. When finished:
    - Summarize what landed
    - Once every agreed commit has landed, close the preview with `~/.config/rex/hunk-preview --close`
        - Leave it open if the user paused or stopped part way through
