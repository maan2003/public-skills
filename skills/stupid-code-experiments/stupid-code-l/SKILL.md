---
name: stupid-code-l
description: Find stupid code in one module under an inverted burden of proof — every decision starts convicted, and only a reconstructed author-rationale that survives the operating regime can acquit it.
---

# Stupid code detector — burden of proof

In this codebase the usual presumption is inverted. Its history justifies
this: it was written by many authors under pressure, and audits keep
finding that decisions were never really made — constants nobody chose,
schedules nobody priced, state nobody owns. So the court's rule is:
**every decision is convicted until a rationale is reconstructed that
acquits it.** You are not a linter and not hunting bugs; style is out of
scope. Do not read specs before the final classification step.

## The docket

Read the whole module top to bottom, then list every decision with
`file:line`: constants, schedules, timeouts, caps, retries, error
dispositions, retained state, duplicated truths, hand-rolled mechanisms,
cross-store write orderings, and what the code does when there is no work.
Every entry starts **CONVICTED**.

## Acquittal standard

To acquit an entry, write the rationale its author would have to state —
the specific, problem-grounded reason this decision is right:

- A real constraint, a real consumer of the behavior, or a real tradeoff —
  named concretely, not gestured at. "I can imagine there's a reason" is
  not a reason; write the reason itself, and check it against the code.
- The rationale must hold over the actual operating regime: the fleet, the
  process lifetime, correlated restarts, failure paths. A rationale true
  of one process for one minute acquits nothing.
- A comment claiming a rationale is testimony: verify its factual claims
  (recompute cost claims arithmetically, checking sizes after every
  encoding layer) before the rationale may acquit.
- Inadmissible: citation ("spec/tests say so"), migration cost, and "it
  works". The alternative may cost up to ~2× the build effort.

An entry with no reconstructible rationale stays convicted — even when you
cannot articulate the damage yet. A decision nobody can explain is not
neutral; it is unowned.

## Report

1. **The docket**: every entry; acquitted ones with their reconstructed
   rationale in one line, convicted ones marked.
2. **Findings**: the top 5 convictions ranked by real cost, in standard
   form — **Where** (`file:line`), **what it does**, **why no rationale
   acquits it**, **the sensible version**, **real cost**, and **Level** —
   *code* or *policy* (specs may be opened only now, solely to classify; a
   spec mandating the behavior upgrades the finding, never excuses it).
3. Convictions beyond the top 5 stay in the docket as one-liners. If
   everything acquits, the module is clean — but every acquittal line must
   carry its rationale, and the weakest one must be named.
