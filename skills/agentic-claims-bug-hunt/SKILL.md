---
name: agentic-claims-bug-hunt
description: Hunt implementation bugs by writing falsifiable absence claims under an honest-counterparty, adverse-environment fault model — crashes at any await point, restarts, transient IO failure, concurrency. Use when the user wants to find bugs systematically ("does X have bugs", "audit X's crash safety"), as the complement of a security-oriented claims tree. Builds on the agentic-claims skill, which defines the record mechanics.
---

# Bug-hunt claims

**Depends on [`agentic-claims`](../agentic-claims/SKILL.md) — load and follow
it first.** This skill applies that convention to bug finding and defines no
record mechanics of its own: record structure, rungs, axioms, residuals,
hostile argument checks, verdicts, imports, staleness, and re-checking are
exactly as `agentic-claims` specifies; this skill adds only the fault model,
the root shape, and the hunt heuristics. The productive output is falsifications: a
first pass over crash/restart surfaces should be expected to falsify most of
its claims, and each falsification is a found bug with a precise trace.

## The premise

"X has no bugs" is not falsifiable — a bug is any divergence from intent, and
intent is not enumerable. Scope the tree to named harms instead. A harm list
that has worked:

- **H1 value** — money/value owed to someone is lost, double-moved, or
  silently misdirected.
- **H2 durable data** — durable state is lost, corrupted, or made mutually
  inconsistent.
- **H3 wedged state** — a supported operation whose preconditions hold is
  permanently refused, or a state is reachable that no supported operation can
  leave; recovery needs manual surgery.
- **H4 false report** — an answer asserts a durable fact that is not durably
  true.
- **H5 dropped obligation** — work durably accepted is neither completed nor
  surfaced as failed.

Everything else — performance, availability during a fault, log quality,
cosmetics — is an explicit residual of the root, not silently ignored.

## The fault model

Every external counterparty is **honest and protocol-conformant**; the
environment is **adverse**: the process may crash or be SIGKILLed at any
statement or await boundary and restart any number of times; supported
operations run concurrently with each other and with background tasks; any IO
may fail transiently and later recover; child processes crash independently;
the clock is monotonic but may pause (two events can share a wall-clock
second).

If a security claims tree exists, the division of labor is exact and worth
stating in the root: a behavior only an attacker triggers belongs there; a
behavior an unlucky honest deployment triggers belongs here. Records may
import across trees under the normal import rules. A security falsification
whose trigger needs no adversary should be re-derived here as an honest-model
bug — several will be.

## The root record

The root's only local contribution is an `enum`-rung **feature × harm**
table. Regenerate features from mechanical sources: RPC verb enums, service
traits, admin command enums, plus a hand-collected inventory of background
tasks and startup/replay paths. The task inventory is the enumeration's weak
edge — say so in weakest links. Every verb and task appears in exactly one
row; a new verb or task with no row stales the root.

Each row lists which harms are live for it and an owner: a leaf record, a
cited record from another tree, or **unowned**. Unowned cells are the
commissioning queue. As leaf verdicts land, reconcile the owner cells and the
root verdict in the same change that folds the leaf.

## Where the bugs live

First-pass heuristics, each validated by found bugs. When commissioning a
leaf, put the applicable questions in the brief; when writing one, answer
them before arguing anything.

- **Fire-and-forget continuations.** Work acknowledged durably, completed by
  a detached task. Ask: after one transient error in that task, what re-drives
  the obligation? If the answer is "the caller might retry", it's H5.
- **Startup reconstruction weaker than durable state.** In-memory flags,
  queues, and requirements rebuilt at startup from less than the durable
  facts. Ask: for each durable predicate, does restart recompute it or assume
  it false?
- **Guard windows.** Protection that begins when the system *observes* an
  event, while the thing being protected came into existence earlier. Ask:
  what exists before the guard switches on, and which operations are legal in
  the window?
- **Success before observed effect.** Teardown/stop/cleanup paths that log
  and discard errors, then report success. Ask: what did the caller conclude
  that the code did not verify?
- **Optimistic reads reported as fact.** Status computed from a local or
  lenient view rather than the authoritative fact. For truthfulness
  claims, classify every answer field as durable-fact / live-observation /
  input-echo (`enum` rung) and argue only the first class; an answer that
  cannot be classified is itself a finding.
- **External replacement/tie-break semantics.** Anything last-writer-wins
  keyed on coarse timestamps: a crash-delayed write can beat a newer one.
  Ask: what orders replacements, and can both sides of a restart share a key?
- **Shared-resource consolidation.** Machinery that batches or consolidates
  across an accounting boundary. Ask: whose balance pays the operation's
  costs, and can a routine operation touch value it does not own?

## Commissioning leaves

- One leaf (or engineer) per row-group; parallel commissions work well when
  each brief names its rows, its harms, the fault model, and the prior art it
  must cite rather than re-litigate.
- Falsification is success. Record the counterexample trace and stop; do not
  repair code in the same change as the record.
- Do not re-prove or re-litigate an existing record's counterexample: cite
  it, scope the new claim to the remainder, or find an independent trace.
- Cite, never import, records whose current verdict is falsified or
  provisional — an import requires a current pass.
- An executable witness (a small model script whose run reproduces the
  numbers in the counterexample) outranks prose; keep it in scope.
- Thin surfaces deserve honest treatment: a short record with a narrow pass
  and named residuals beats a padded one. If a row yields neither a bug nor a
  meaningful claim, the record says that in its residuals.

## Plain-language companions

Keep a `found-bugs/` directory beside the records: one short file per found
bug in simple language — what happens, why it matters, fix direction, link to
the formal record — plus an index. They are companions, not records; if a
summary and its record disagree, the record wins. Write one in the same
change that folds a falsified leaf.
