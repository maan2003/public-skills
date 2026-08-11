---
name: stupid-code-h
description: Find stupid code in one module under the working assumption that at least one indefensible decision exists — produce a ranked suspect list with verdicts; an empty report is not an option.
---

# Stupid code detector — the plant

Working assumption, given to you as fact: **this module contains at least
one decision its author could not defend out loud to a colleague.** The
codebase's history justifies the prior — it was written by many authors
with no shared taste, and every module audited so far contained something.
Your deliverable is not "is there stupidity?" but "what is the *most*
embarrassing decision here, and what comes after it?" A reviewer who
returns nothing has not proven the module clean; they have failed to find
the plant.

This changes your posture, not your honesty: verdicts may still be
acquittals, but the *ranking* is mandatory. You are not a linter and not
hunting bugs; style is out of scope. Do not read specs during the hunt.

## The hunt

Read the whole module top to bottom, twice — the second time as a
prosecutor building a case list. Everything is a suspect: every constant,
schedule, retry, retained state, error disposition, hand-rolled mechanism,
abstraction, and every decision hiding behind a confident comment (comments
are the defendant's own testimony; verify their factual claims against the
code and treat a false claim as consciousness of guilt). For each suspect,
ask what a competent engineer writing this module today would do — the
boring version, judged over the real regime: fleet scale, process lifetime,
correlated restarts, failure paths. The better design may cost up to ~2×
the build effort; migration cost is never a defense.

## The lineup

Select the **top 5 suspects** — the five decisions you'd least want to
defend out loud — and rank them by embarrassment × cost. For each, write
the strongest honest defense, then rule. Rules of the ranking:

- The list must contain 5 entries (or every decision in a trivially small
  module). Acquittals stay in the list with their defense — the ranking is
  the deliverable, the verdicts are your honest judgment on each.
- If you acquit all five, say plainly which acquittal you are least sure
  of and why. That sentence is the most useful one in the report.
- Do not pad the lineup with style or taste; if you cannot fill it with
  real decisions, your read was too shallow — read again.

## Report

For each ranked suspect: **Where** (`file:line`), **the decision** (one
concrete sentence), **best defense**, **verdict** (convicted/acquitted,
with the one-line reason), and for convictions: **the sensible version**,
**real cost**, and **Level** — *code* or *policy* (specs may be opened only
now, solely to classify; a spec mandating the behavior upgrades the
finding, never excuses it).

Close with: the single decision you'd flag to a human reviewer first, in
one sentence, regardless of verdict.
