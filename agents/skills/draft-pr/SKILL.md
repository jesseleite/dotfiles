---
name: draft-pr
description: Draft a consistent, well-structured PR title and description by analyzing the Linear issue's title and full branch diff
---

## Instructions

When asked to write a PR description, follow these steps:

1. Identify a PR title (usually from the associated Linear issue's diff)
1. Identify the base branch (usually `main` or `master`)
2. Run `git log --oneline <base>..HEAD` to understand the full commit history
3. Run `git diff <base>...HEAD --stat` for a high-level summary of files changed
4. Run `git diff <base>...HEAD` to read through the actual changes
5. Draft a PR description using the format below

## PR Description Format

```
## Summary

<1-3 sentences explaining what this PR does and why>

## New

<Optional — Any changes that add functionality of any kind. Omit this section entirely if there's nothing noteworthy.>

## Improved

<Optional — Any changes that improve functionality. Maybe somethign is not new per se, but is a code quality improvement or some kind of cleanup. Omit this section entirely if there's nothing noteworthy.>

## Fixed

<Optional — Any changes that improve functionality. Maybe somethign is not new per se, but is a code quality improvement or some kind of cleanup. Omit this section entirely if there's nothing noteworthy.>

## Additional Notes

<Optional — anything reviewers should know re: follow-up work, breaking changes, related issues, etc. Omit this section entirely if there's nothing noteworthy.>

## Manual Testing

<Optional — any specific steps reviewers should take to manually test, or any notes about testing considerations.>
```

## Guidelines

- Summary section:
    - The summary should focus on **why**, not just **what**
    - Don't break lines to specific lengths, let them wrap naturally
- Changes sections (ie. 'New', 'Improved', 'Fixed'):
    - If the PR title starts with `Fix` or the PR looks like a bugfix, show the 'Fixed' section above the other changes sections
    - Don't list every file touched; highlight what matters to a reviewer
    - Group changes by logical concern in a high-level human-readable fashion, not by file or commit
    - Nest bullet points where it makes sense
    - Keep it scannable — prefer bullet points over paragraphs
    - All bullet points should be 100 characters or less — keep it short and sweet
    - All bullet points should be checkboxes (ie. `- [x]`)
        - Except for 'Additional Notes' section bullet points, since these are completed changes, but rather just notes
    - Where possible, start each bullet point with singular verb (ie. `Add ___`, `Ensure ___`, `Fix ___`, etc.)
    - When it comes to bullet points for test coverage:
        - Don't consider these bullet points as 'New' section items
        - Don't get too granular with these bullet points
        - Keep these bullet points super generic (ie. 'Add test coverage' or 'Fleshed out test coverage')
- Additional Notes section:
    - If there are breaking changes, call them out here
    - If there are related issues or tickets, link them here
    - If there is anything else noteworthy in the Linear ticket itself, include it here
- Omit sections that would be empty — don't include placeholder text

## Examples

Here are some examples of well written and structured PRs and their associated Linear issues:

- PR #2375 for SC-3091
- PR #2372 for SC-3080
- PR #2369 for SC-3075
- PR #2361 for SC-3068
