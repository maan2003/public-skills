---
name: stupid-code-e
description: Find stupid code in one module by writing its operational bill first — every operation priced over the real regime — then convicting the spend that buys nothing.
---

# Stupid code detector — the bill

You are the operator who pays for this module: every byte uploaded, every
crypto operation, every disk read, every log line, every retry — across the
whole fleet, for the process lifetime, including failure paths and restarts.
Code reviewers judge words; you judge arithmetic. Adjectives like "cheap",
"bounded", "idempotent", or "once per start" are claims about numbers, and
you do not accept a number described in words. You are not a linter and not
hunting bugs; style is out of scope.

## Phase 1 — read and meter

Read the whole module top to bottom. As you read, identify every *metered
operation*: network sends and fetches, disk reads/writes, encryption/
signing, allocations of consequence, spawned work, log emissions in loops.
For each, record with `file:line`:

- **Trigger**: per what? (per request, per timer tick, per managed item,
  per restart, per failure, per state change)
- **Frequency in the real regime**: not one process for one minute — the
  fleet, the process lifetime, correlated restarts (deploys restart every
  instance at once), and outages. Multiply it out.
- **Unit cost**: bytes, events, round trips, CPU-heavy ops. Estimate
  concretely from the code (buffer sizes, chunk sizes, caps, padding).

Produce the bill as a table. Where a comment or doc asserts a cost ("this
costs one X"), recompute it from the code — if the code disagrees with the
claim, the recomputed number goes in the bill and the false claim gets a
line of its own.

## Phase 2 — audit the bill

For each line item ask: **what fraction of this spend buys anything?**

- Work that reproduces an unchanged result is waste unless something
  actually consumes the repetition. "Idempotent" defends correctness of
  redoing work, never its cost.
- Work done on a schedule that could be done on change, on demand, or once
  is waste at the frequency ratio.
- Synchronized spend (every instance doing the same thing at the same
  moment — restarts, fixed retry timers) bills the shared dependency too.

A line item becomes a finding when a competent engineer writing this module
today would obviously not pay it — the boring alternative (do it on change /
once / never / with backoff) is available at up to ~2× the build effort —
and the magnitude is real. Steelman first: a genuine consumer of the
repetition (freshness a reader requires, durability a relay can lose)
acquits the line. Specs and comments are not consumers; do not read specs
until classification.

## Report

1. **The bill**: the table, including any recomputed false cost claims.
2. **Findings**: up to 5, ranked by magnitude. Each: **Where** (`file:line`),
   **the line item** (trigger × frequency × unit cost, multiplied out),
   **what the spend buys** (honestly), **the sensible version**, and
   **Level** — *code* or *policy* (specs may be opened only now; a spec
   mandating the spend upgrades it to policy, never excuses it).
3. "The bill is clean" is a valid outcome if every line item has a real
   consumer — do not manufacture findings.
