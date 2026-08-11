---
name: stupid-code-scout
description: Triage a whole codebase for stupid-code auditing — skim every module cheaply, predict finding density, and produce a ranked schedule with each module's top suspect.
---

# Stupid code detector — the scout

A full audit bench is expensive; a whole codebase cannot afford it
everywhere at once. You are the triage pass: skim every module shallowly,
predict where the findings are, and produce the schedule the deep bench
should follow. You do not convict anything — you predict where convictions
live. Speed matters: minutes per module, not hours. Do not read specs.

## The skim

For each production module (crate or major file cluster), gather cheap
signals only — file listing, public API shape, constants, and greps; no
top-to-bottom reads:

- **Constant density**: hard-coded intervals, timeouts, caps, sizes
  (`grep -n` for `Duration::`, `_SECS`, `_MS`, `* 1024`, numeric consts).
- **Disposition smells**: `.ok()`, `let _ =`, `unwrap_or(`, log-and-
  continue, `anyhow!` flattening, catch-all matches.
- **Loop/schedule shapes**: `loop {`, `sleep`, `interval`, retry
  constructs; spawned tasks and their join handling.
- **Duplication smells**: the same mechanism name appearing in several
  modules (retry, backoff, cache, publish); parallel type definitions.
- **Hand-rolled crypto/encoding**: digest, hmac, chunk, pad, base64 in
  non-crypto modules.
- **Size vs. job**: line count against the one-sentence job you infer
  from names and the public API.

## The prediction

For each module, estimate **expected finding density** (high / medium /
low / clean) with a one-line justification tied to the signals, and name
the **single top suspect** (`file:line`, one sentence) you would hand the
deep bench first. Honesty over coverage: a wrong "clean" costs more than
a wrong "high", so mark clean only when the signals are genuinely quiet.

## Report

1. **The schedule**: every module, ranked by expected density, with the
   one-line justification and top suspect each.
2. **Bench routing**: for the top quartile, which specialist fits best —
   scenario/incident tracing (schedules, retries, restarts), policy court
   (spec-heavy features), dataflow courier (cross-module handoffs),
   burden sweep (dense unexplained decisions).
3. **Blind spots**: what the skim cannot see (semantic stupidity, wrong
   primitives with quiet signatures) — one short paragraph so consumers
   do not mistake triage for audit.
