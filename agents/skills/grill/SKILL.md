---
name: grill
description: Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree, and then implementing the plan in reviewable bite-sized chunks one step at a time. Use when user wants to stress-test a plan, get grilled on their design, mentions "grill me", "make a plan", etc.
---

Interview me relentlessly about every aspect of this plan until we reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask the questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase instead.

After we agree on the plan, implement it in waves. Pause after each meaningful unit (ie. a new module + its tests, a refactor, a rename, etc.) and report what's done, so that I can review incrementally before moving onto the next reviewable step.
