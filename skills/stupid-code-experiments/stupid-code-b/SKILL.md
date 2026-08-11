---
name: stupid-code-b
description: Find stupid code in one module by exhaustively inventorying every decision embedded in it, then defending or condemning each one on the merits.
---

# Stupid code detector — decision interrogation

Every module is a pile of decisions: numbers, mechanisms, state, error
handling, abstractions. In this codebase many of them were never really made —
they are defaults, cargo cult, or the first thing that worked. You will make
each decision visible and then make it justify itself. A decision that cannot
be defended is stupid code.

Work through the phases in order. Do not skip the inventory: the whole method
is that stupidity hides in decisions nobody notices are decisions.

## Phase 1 — Read

Read the entire module top to bottom. No specs, no docs outside the module —
the code and your domain common sense are the only inputs. Reconstruct in one
or two sentences what the module is for.

## Phase 2 — Inventory the decisions

Go back through and list every embedded decision, mechanically. Sweep these
categories:

1. **Every constant** — timeouts, intervals, retry counts, buffer sizes,
   limits. Each number is a policy.
2. **Every loop or schedule** — anything that polls, sleeps, ticks, or
   retries. Each is a choice against some push/notify/idempotent alternative.
3. **Every piece of stored state** — caches, flags, counters, duplicated
   truths. Each needs an owner and an invalidation story.
4. **Every error-handling choice** — panic vs Result vs log-and-continue vs
   swallow. Each is a policy about which failures matter.
5. **Every abstraction** — traits, generics, config options, extension
   points. Each claims more than one user exists.
6. **Every hand-rolled mechanism** — anything the standard library, an
   existing dependency, or a sibling module already provides.

Write the inventory as a numbered list with `file:line`. Aim for completeness
over insight here — insight is Phase 3.

## Phase 3 — Defend or condemn

For each inventoried decision, write the strongest honest defense you can,
appealing **only to the problem**: a real constraint, a real tradeoff, a real
cost of the alternative. Specs, comments, tests, and "it's always been this
way" are inadmissible — that is provenance, not merit.

- Defense holds → the decision survives. Move on.
- Defense is hollow — you find yourself writing "presumably", "maybe they
  wanted", or defending a number no one would pick twice → **condemned**.
  Record the sensible alternative and what the gap actually costs.

A condemnation needs both: a clearly better alternative at similar or lower
effort, and a real cost (resources, fragility, misbehavior at scale, reader
tax). Costless suboptimality survives. Bugs and style are out of scope
entirely — do not inventory them.

## Phase 4 — Report

From the condemned list, report the top 5 by cost, ranked. If nothing was
condemned, say so — an inventory where every decision survives is a valid,
complete outcome.

Each finding:

- **Where**: `file:line`
- **The decision**: one concrete sentence
- **Why the defense failed**: the hollow defense you attempted, in one line
- **The sensible version**: the alternative a competent engineer would pick
- **Real cost**: concretely
- **Level**: *code* (mechanism) or *policy* (the decision itself, however
  well implemented). Only now may you check specs, solely to classify: a
  spec mandating the behavior makes it policy — it never acquits it.

Include the full inventory with per-decision verdicts (survived/condemned) as
an appendix, so the coverage is auditable.
