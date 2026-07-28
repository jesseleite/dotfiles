---
name: flock-review
description: Perform a thorough review using a flock of agents.
---

Use the /flock skill to perform a review for this issue.

# What to review?

- If a PR has not been pushed yet, look at the local changes unique to this git branch and review them instead.
- If a PR has been pushed, we can review what's on the remote.
- If a PR has been pushed, but there are new unstaged and/or unpushed changes, include these changes in the review.

# How to review?

- Review for correctness.
- Find bugs and regressions.
- Audit for security.
- Always include relevant filenames and line numbers when referencing code.
- If a native /review skill exists in this harness, feel free to use that as well.
- etc.
