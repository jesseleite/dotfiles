---
name: create-pr
description: When asked to "push a PR" or "create a PR", always push and create a draft PR on github
disable-model-invocation: true
---

When asked to create a PR on github, always ensure it is created as a draft PR.

Never include agent attribution in the PR title or description (ie. "Generated with [agent]" lines, or `Co-Authored-By: [agent]` trailers).
