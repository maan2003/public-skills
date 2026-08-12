---
name: slop-seeking-missile-courier
description: Find stupid code across a whole codebase by escorting core data end to end — following a payment, an error, a secret, an event from birth to death — and judging every handoff it survives.
---

# Stupid code detector — the courier

Module reviews judge rooms; you judge journeys. Pick the things the system
exists to move — money, errors, secrets, external messages, identity — and
escort each one through the whole codebase, from where it is born to where
it dies. Stupidity that is invisible in any single module lives at the
handoffs: each module looks reasonable, but the journey is absurd. You are
not a linter and not hunting bugs; style is out of scope. Do not read
specs before the final classification step.

## Phase 1 — choose the cargo

Skim the codebase's crate map and pick 4-6 concrete travelers, biased
toward consequence, e.g.:

- a unit of **value** (a payment from acceptance to settlement/refund),
- an **error** (from the deepest failure site to the operator's eyes),
- a **secret or config** (from generation to storage, backup, restore),
- an **external message** (from a peer/relay into decisions it feeds),
- an **identity or credential** (from derivation to every consumer).

Name each traveler concretely ("the payment for order N", "an I/O error
inside X during startup").

## Phase 2 — escort each traveler

Walk the actual code path, `file:line` at every step, across every module
and crate boundary, including storage and process restarts. Record every
**handoff** — function call across a module boundary, serialization,
persistence, channel send, task spawn — and at each one ask:

- Does the receiver get **less truth** than the sender had (fields
  dropped, error causes flattened, provenance lost)?
- Is the same truth now **stored twice** with no owner of agreement?
- Is it **re-parsed, re-validated, or re-fetched** where it was already
  known?
- Is **trust upgraded** silently — unverified data entering a signed,
  paid, or irreversible consumer?
- Does the traveler **wait, retry, or get redone** for reasons that serve
  no consumer on its route?
- Where can the traveler **die silently** — and who notices?

Follow failure branches, not just the happy route: a payment's journey
includes the crash between debit and record.

## Phase 3 — judge the journeys

For each marked handoff, steelman with problem-grounded defenses only
(real constraint, real consumer, real tradeoff, valid over the fleet, the
process lifetime, correlated restarts; comments are testimony to verify,
never defense; migration cost inadmissible). Convict where a competent
engineer designing the *journey* today would route it differently at up
to ~2× the build effort and the gap has real cost. State the sensible
version at the journey's natural size — often a cross-module rework; do
not shrink it to fit one module.

## Report

1. **Itineraries**: each traveler's journey compressed to its handoffs,
   with `file:line`.
2. **Findings**: up to 6, ranked by cost, deduplicated across travelers.
   Each: **Where** (the handoff chain, `file:line`), **what happens to
   the traveler**, **failed defense**, **the sensible route**, **real
   cost**, **Level** — *code* or *policy* (specs opened only now, solely
   to classify; a spec mandating the route upgrades the finding, never
   excuses it).
3. "Every journey reads sanely" is a valid outcome — do not manufacture
   findings.
