---
name: stupid-code-i
description: Find stupid code in one module by writing the module yourself first — from its interface and callers only, never its implementation — then diffing your decisions against the real code.
---

# Stupid code detector — the rewrite

Reading code first makes you its advocate: every decision you encounter
becomes the anchor you judge alternatives against. You will not read the
module's implementation until you have already committed, in writing, to
your own. You are not a linter and not hunting bugs; style is out of scope.
Do not read specs at any point before the final classification step.

## Phase 1 — learn the contract, not the code

You may read, with care to stop at the boundary:

- The module's **public item signatures and type definitions** (extract
  them mechanically — `grep`/`sed` for `pub fn`, `pub struct`, `pub enum`
  declarations — do not open function bodies).
- Its **callers**: every site that uses the module, in full.
- The **menu**: the APIs of the dependencies and sibling modules it could
  build on.
- Its **tests**, as statements of required behavior.

You may NOT read the module's function bodies, private items, or comments.
From this, write down the module's job in a paragraph: inputs, outputs,
invariants, the operating regime (fleet size, process lifetime, restart
correlation, failure modes of its dependencies).

## Phase 2 — commit to your design

Write your implementation plan at full decision fidelity — not prose
hand-waving but every decision an implementor must make, with `why` per
decision: data shapes and where each truth lives; schedules/triggers and
their cadences; every error's disposition; commit/ordering protocol for
anything touching two stores; constants with the reasoning that picked
them; what happens at restart, during dependency outage, and when there is
no work. Where the contract genuinely permits two designs, note both and
pick one. This document is your commitment — you do not revise it after
Phase 3 begins.

## Phase 3 — read the real module and diff

Now read the implementation top to bottom. Produce the decision diff:

- **Convergent** — the code chose what you chose: acquitted by
  convergence, one line each.
- **Code is better** — the code knew a constraint you missed: acquit and
  record what the constraint was. Be honest here; these lines are what
  makes your convictions credible.
- **Yours is better** — candidate finding. Steelman the code's choice with
  a problem-grounded defense (a real constraint, a real consumer, a real
  tradeoff, valid over the actual regime — not comments, not migration
  cost). Convict when your version is what a competent engineer writing
  this today would build at up to ~2× the build effort and the gap has
  real cost.
- **Decision you never faced** — the code does something your design
  didn't need at all. Judge whether the requirement is real (find its
  consumer) or invented.

## Report

1. **Your committed design** (Phase 2 document, unedited).
2. **The decision diff**, grouped as above.
3. **Findings**: up to 5, ranked by cost. Each: **Where** (`file:line`),
   **what the code does / what you built**, **failed defense**, **real
   cost**, and **Level** — *code* or *policy* (specs may be opened only
   now, solely to classify; a spec mandating the behavior upgrades the
   finding, never excuses it).
4. "The code converged with or beat my design throughout" is a valid
   outcome — do not manufacture findings.
