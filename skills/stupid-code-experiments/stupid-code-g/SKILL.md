---
name: stupid-code-g
description: Find stupid code in one module by tracing concrete operational scenarios step by step — restart, deploy wave, outage, scale — and convicting the steps that sound absurd when narrated aloud.
---

# Stupid code detector — scenario trace

Static reading judges code sympathetically: each function looks reasonable
in isolation. You will instead *run the machine in your head*. Pick the
scenarios operations actually lives through, walk the code through each one
step by step, and narrate exactly what the system does — every network
call, every byte, every crypto operation, every log line, counted. Stupid
code cannot survive narration: "then it re-does the work it completed
yesterday, for every record, on every instance at once" sounds exactly as
absurd as it is. You are not a linter and not hunting bugs; style is out of
scope. Do not read specs during the trace.

## Phase 1 — read and map the triggers

Read the whole module top to bottom. List everything that causes it to act:
startup, timers, state changes, external requests, failures, shutdown —
with `file:line`.

## Phase 2 — choose the scenarios

Pick 5–6 concrete scenarios that together cover the module's real life.
Always include:

1. **First start** (empty state).
2. **Restart with mature state** (N of everything already exists — be
   concrete: pick N=20 and real sizes from the code's own constants).
3. **Deploy wave**: every instance in the fleet restarts within one minute.
4. **Dependency outage**: the network peer / database / child this module
   talks to is down for an hour, then recovers.
5. **One component dies**: a task this module spawned panics mid-life.
6. **10× scale**: the deployment grows; which numbers grow with it?

## Phase 3 — narrate each scenario

Walk the code in execution order and write the narration, citing
`file:line` at each step, counting the work: how many events, how many
bytes (use the code's own buffer/chunk/padding constants), how many round
trips, how many log lines, over what wall-clock pattern. Where a comment
claims what happens, trace what the *code* does; if they disagree, the code
wins and the disagreement is noted. Then read each narration aloud to
yourself and mark every step that a competent engineer would wince at —
work redone with unchanged inputs, waits that make no sense for the state
machine's purpose, failures that leave no trace, whole-fleet synchronized
behavior, quantities that scale with the wrong variable.

## Phase 4 — steelman and report

For each marked step, construct the best problem-grounded defense (a real
consumer of the repetition, a real constraint). If it holds, unmark.
Convict when the boring alternative — do it on change, once, on demand,
with backoff, with a trace — is what a competent engineer writing this
today would obviously do (up to ~2× build effort is fair game) and the gap
has real cost.

Report:

1. **The traces**: each scenario's narration, compressed to its countable
   steps.
2. **Findings**: up to 5, ranked by cost. Each: **Where** (`file:line`),
   **the absurd step** (quoted from the narration, with the numbers),
   **the sensible version**, **real cost**, and **Level** — *code* or
   *policy* (specs may be opened only now, solely to classify; a spec
   mandating the behavior upgrades the finding, never excuses it).
3. "Every narration reads sanely" is a valid outcome — do not manufacture
   findings.
