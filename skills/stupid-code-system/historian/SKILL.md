---
name: stupid-code-historian
description: Find stupid code by excavating version history — repeated constant bumps, fix-on-fix chains, churn without redesign — and judging the current code at each fossil site.
---

# Stupid code detector — the historian

Stupid designs are rarely fixed; they are patched, and patches leave
fossils that no static read of today's code can see. A timeout bumped
four times is a design nobody priced; a file fixed weekly is a shape
nobody owns; a comment added months after the code it defends is a
justification invented under questioning. You dig where the record shows
repeated disturbance, then judge what stands there today. You are not a
linter and not hunting bugs; style is out of scope. Do not read specs
before the final classification step.

## Phase 1 — survey the record

Use the version history (`git log`, `git log --follow -p -- <path>`,
`git log -S<string>`, blame) to find dig sites:

- **Repeated tuning**: the same constant, timeout, cadence, or cap
  changed more than once — especially "perf:"/"fix:" commits that only
  move a number.
- **Fix-on-fix chains**: commits whose messages patch the outcome of a
  prior patch; reverts and re-reverts.
- **Churn without redesign**: files with high commit counts whose shape
  never changed — symptom treatment as a lifestyle.
- **Post-hoc testimony**: comments or docs added well after the code they
  justify, especially following a bug fix.
- **Abandoned intentions**: TODO/HACK markers old enough to vote;
  configurability added and never configured since.

List each dig site with the commits that mark it and the current
`file:line` it points at.

## Phase 2 — excavate and judge

At each dig site, read the current production code and reconstruct the
story: what problem did the patches chase, and what would a competent
engineer writing this part today build instead — knowing everything the
patch history revealed? The history is evidence of cost already paid
(every bump was an incident or a complaint); use it to price the gap
concretely. Steelman with problem-grounded defenses only; a patch series
that converged on a genuinely sound design acquits its site. Comments are
testimony — a rationale added after the fact is verified like any claim.
The better design may cost up to ~2× the build effort; migration cost is
never a defense.

## Report

1. **Dig sites**: each with its commit evidence (hashes, one-line story)
   and verdict.
2. **Findings**: up to 5, ranked by cost. Each: **Where** (`file:line`),
   **the fossil record** (the patch story in two lines, with hashes),
   **what stands today**, **failed defense**, **the sensible version**,
   **real cost**, **Level** — *code* or *policy* (specs opened only now,
   solely to classify; a spec mandating the behavior upgrades the
   finding, never excuses it).
3. "The record shows honest convergence" is a valid outcome — do not
   manufacture findings.
