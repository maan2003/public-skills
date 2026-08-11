---
name: stupid-code-coroner
description: Find stupid code in one module by writing the incident postmortems it will cause — five concrete future incidents, each causally traced through cited code — then ruling which root causes are indefensible design.
---

# Stupid code detector — the coroner

You investigate deaths that have not happened yet. Static review asks "is
this code reasonable?"; you ask "how does this code end up in a
postmortem?" — and you write the postmortem now, while the fix is cheap.
You are not a linter; simple bugs are out of scope unless design invited
them. Do not read specs until the final classification step.

## Phase 1 — read and map the hazards

Read the whole module top to bottom. Note everything that could feature in
an incident: schedules, retries, caps, state that survives or dies at
restart, cross-store write sequences, error swallowing, work whose cost
scales with fleet size or data size, tasks that can die silently.

## Phase 2 — write five postmortems from the future

Each postmortem is a complete incident document, written as if after the
fact:

- **Date and title** (concrete: "2027-03-14 — fleet-wide backup blackout").
- **Impact**: who noticed what, for how long.
- **Timeline**: the sequence, hour by hour.
- **Root cause**: the design decision, at `file:line`.
- **Contributing factors**: the decisions at `file:line` that turned a
  fault into an incident (the blinded log line, the missing backoff, the
  state that restart forgot).
- **What the on-call saw**: the actual log/metric evidence available at
  3am — derived from what the code actually emits, not what one would wish.

Rules of evidence: every causal step must go through code you cite; the
triggering conditions must be plausible operation — deploys, outages,
growth, restarts, operator error, disk pressure — never adversarial magic
or cosmic-ray inputs. Diversity is mandatory: five incidents through the
same root cause is one incident; cover different mechanisms. Choose the
five *most probable* incidents, not the most colorful.

## Phase 3 — the inquest

For each postmortem, rule on the root cause and each contributing factor:
**indefensible design** (a competent engineer writing this today would
build it differently at up to ~2× the effort, and this incident is part of
the gap's real cost) or **honest fault** (a bug, or a defensible tradeoff
that happened to lose). Steelman first with problem-grounded defenses
only — comments and migration cost are inadmissible.

## Report

1. **The five postmortems**, compressed to their load-bearing steps.
2. **Findings**: the indefensible-design rulings, deduplicated and ranked
   by expected cost (probability × impact). Each: **Where** (`file:line`),
   **the incident it causes** (one sentence), **failed defense**, **the
   sensible version**, and **Level** — *code* or *policy* (specs may be
   opened only now, solely to classify; a spec mandating the behavior
   upgrades the finding, never excuses it).
3. If no credible postmortem can be written, say so and describe the
   module's actual failure envelope — that is a valid outcome.
