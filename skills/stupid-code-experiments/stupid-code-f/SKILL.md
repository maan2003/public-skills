---
name: stupid-code-f
description: Find stupid code in one module by auditing the code's own testimony — every rationale claim in comments and docs verified against the code — and judging the decisions whose defense was false, unverifiable, or absent.
---

# Stupid code detector — claim audit

Code written by many authors defends itself in comments and doc-comments,
and later readers absorb those defenses as facts. You are the auditor who
does not: every inline rationale is *testimony*, and testimony gets
verified against the code, never believed. The most dangerous stupidity in
a codebase like this hides behind a confident comment that is simply wrong.
You are not a linter and not hunting bugs; style is out of scope. Do not
read specs during the audit.

## Phase 1 — harvest the testimony

Read the whole module top to bottom. Collect, with `file:line`, every claim
a comment or doc-comment makes that could in principle be false:

- **Cost claims**: "cheap", "bounded", "costs one X", "negligible",
  "idempotent so this is fine".
- **Behavior claims**: "this never happens", "the caller handles it",
  "already validated elsewhere", "X guarantees Y", "retried later".
- **Necessity claims**: "required because Z", "must happen before W",
  "kept for future use".

Also record the *silent* decision sites: constants, schedules, retained
state, and error swallowing that carry **no** rationale at all where one is
clearly owed. Absence of testimony is itself testimony.

## Phase 2 — verify every claim

For each claim, establish a verdict by reading the code (including the
providing modules a claim points at): **true**, **false**, or
**unverifiable**. Recompute cost claims arithmetically over the real
operating regime — the fleet, the process lifetime, correlated restarts,
failure paths — not one process for one minute. A claim that is true of one
process but false of the fleet is false.

## Phase 3 — judge the marked sites

Every false or unverifiable claim, and every silent site, marks a decision.
Judge each on its merits with the claim struck from evidence: would a
competent engineer writing this module today make this decision? The better
design may cost up to ~2× the build effort. Steelman honestly — a decision
can survive even though its comment was wrong (then the finding is the
false comment's correction, noted but not ranked). Convict when the
obviously better version exists and the gap has real cost (resources,
fragility, misbehavior at scale, undebuggable failures, reader tax).

## Report

1. **Audit table**: every claim with its verdict; false and unverifiable
   ones first, each with the one-line reason.
2. **Findings**: up to 5 convictions, ranked by cost. Each: **Where**
   (`file:line`), **the struck testimony** (what the code claimed), **what
   the code actually does**, **the sensible version**, **real cost**, and
   **Level** — *code* or *policy* (specs may be opened only now, solely to
   classify; a spec mandating the behavior upgrades the finding, never
   excuses it).
3. "All testimony verified true and every silent site defensible" is a
   valid outcome — do not manufacture findings.
