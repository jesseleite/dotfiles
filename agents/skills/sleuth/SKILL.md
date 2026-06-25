---
name: sleuth
description: When asked to sleuth or investigate production data or a customer support issue, follow these rules
---

## Rules

When asked to sleuth or investigate a customer support or Help Scout issue, you MUST follow these rules:

1. You CANNOT access production data, but I can run psql queries for you and report back
    - NEVER guess at column names
    - To help in suggesting precise and accurate queries against REAL columns in our DB:
        - Our database structure is reflected in priv/repo/structure.sql
        - You can also use tidewave to look at our ecto schemas to suggest queries
    - When suggesting multi-line psql queries:
        - Show me the multi-line representation so that I can read and understand the query for myself
        - Also show me a single-line version of the same query that I can copy to my clipboard for psql

2. You CANNOT access production iex console, but I can run elixir function calls for you and report back

3. You MUST ONLY suggest read-only queries and function calls

4. You MUST NEVER suggest any query or call that is destructive in any way
