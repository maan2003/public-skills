---
name: stupid-code-m
description: Find stupid policy in one module by trying the specs first — judging each mandated behavior as a design decision — and only then reading the code for compliance with condemned mandates and silent divergences.
---

# Stupid code detector — the policy court

Module-level scans keep discovering that the worst decisions are
spec-mandated: the spec transcribed an implementation accident into a
requirement, and every later reader treated "documented" as "decided".
This is spec-laundering, and it is invisible to reviewers who read the
code first — by the time they open the spec, it reads as authority. You
read the spec first, as a *defendant*. You are not a linter and not
hunting bugs; style is out of scope.

## Phase 1 — try the spec

Locate the module's governing specs (the repo keeps them in `specs/`
directories near the code; read the nearest architecture doc to find
them). Read them as design documents written by a fallible author. For
every concrete mandate — a constant, a cadence, a protocol shape, a
required behavior, an explicitly recorded deviation or omission — ask:
would a competent engineer designing this feature today, unconstrained by
this document, write this requirement?

Judge each mandate on the problem alone: real constraint, real consumer,
real tradeoff, valid over the actual operating regime (fleet scale,
process lifetime, correlated restarts, failure paths). The alternative
may cost up to ~2× the build effort; that a system already implements the
mandate is inadmissible — implementation cost is the fixer's bill.
Mandates with no stated rationale get special attention: a requirement
that cannot say why it exists is a prime laundering suspect. Verdict per
mandate: sound, or condemned.

Then run one **interaction pass**: individually sound mandates can combine
into an unsound behavior (a durability rule plus a startup rule that
together destroy data neither would alone). Walk the mandates jointly
through restart, outage, and partial-failure timelines and judge the
combinations; a condemned interaction is a finding even when every member
mandate is sound.

## Phase 2 — read the code

Now read the module's implementation, looking for exactly two things:

- **Compliance with condemned mandates**: each is a policy finding — cite
  both the spec clause and the implementing `file:line`.
- **Silent divergence**: where code and spec disagree. Judge which side is
  right on the merits. Code silently better than its spec is a finding
  against the spec (the mandate misleads every future implementor and
  reviewer); code silently worse is a finding against the code; both are
  reportable.

Do not conduct a general code review; the module-level scan is another
skill's job.

## Report

1. **The mandate docket**: every concrete mandate with its verdict and a
   one-line rationale; condemned ones first.
2. **Findings**: up to 5, ranked by cost. Each: **Where** (spec section +
   `file:line`), **the mandate and what it launders**, **failed defense**,
   **the sensible requirement**, **real cost**, and whether the fix is a
   spec edit, a code change, or both.
3. **Divergence list**: every silent spec/code disagreement with its
   merits ruling.
4. "The specs decide well" is a valid outcome — do not manufacture
   findings.
