---
name: agentic-claims
description: Write and check claim records (claims/*.md) — falsifiable claims that a named bad thing cannot happen, argued from explicit axioms and checked through a two-role protocol (blind falsifier + argument auditor). Use when the user asks to prove or check a guarantee, assess a risk, write or re-run a claim record, or when a change touches code a claim record depends on.
---

# Claims

A claim record argues, from the current code, that one concretely feared
bad thing cannot happen. It decomposes the claim into lemmas over explicit
axioms, like a proof; it must be able to fail, like a test. Records are
checked by falsification — attempting to construct a counterexample —
never by re-reading the argument sympathetically.

## Records

Records live in `claims/` within the package they cover, one record per
property, named by the property's violation: `claims/<bad-thing>.md`. A
record opens with a `Scope:` line naming the code globs its lemmas read;
staleness detection is diff ∩ scope. There
is no further classification — safety, liveness, completeness, and
confinement properties all use the same form; what distinguishes them is
stated inside the record (see the falsification procedure). A record
contains, in order:

1. **Claim** — what can never happen, with its adversary model.
2. **Axioms** — the trusted, unchecked base.
3. **Argument** — lemmas, each labeled with its enforcement rung.
4. **Residual windows** — accepted executions outside the claim.
5. **Weakest links** — lemmas ranked by rung.
6. **Falsification procedure** — self-contained; runnable from the claim
   and axioms alone, without the argument. It names what a counterexample
   is for this property: a violating trace, a stuck state, a missing
   element in an enumeration, or a leaking channel.
7. **Verdict** — dated, gated on the two-role check.

### Composing records

Split only at an independently falsifiable bad thing, never merely to move a
long lemma elsewhere. A composition record declares an `Imports:` block after
`Scope:`, with one relative claim-record path and the exact imported conclusion
per entry. Imports must form a DAG.

An import is a checked lemma, not an axiom and not shorthand for trusting a
`PASS` label:

- its record must have a current `pass` verdict at the same revision;
- the parent's effective scope is its explicit scope plus every imported
  record and the recursive union of imported effective scopes;
- the parent states any additional axioms, while its trusted base also includes
  the explicit axiom union of its imports; conflicting definitions or axioms
  fail the composition;
- the parent argument labels use of the exact imported conclusion as `claim`
  and separately label any local case split or glue (`enum`, `code`, and so
  on); mechanisms inside the leaf are not relabeled as if the parent checked
  them directly;
- the parent blind packet contains its own claim/axioms/procedure plus each
  imported leaf's claim, axioms, and falsification procedure—never leaf
  arguments. Leaf two-role checks run independently; the parent blind role
  attacks exhaustiveness, interface identity, axiom compatibility, and paths
  between or outside the leaves;
- the parent auditor reads all imported records and regenerates both the glue
  and each claimed interface. The parent cannot pass until every leaf and the
  composition have passed their respective two-role checks.

Changing an imported record or anything in its effective scope stales the
parent transitively. This recursive staleness rule is part of the import
contract even before automated scope tooling exists; a parent whose leaf was
not rechecked is provisional, not pass.

Records are evidential, not normative — the inverse of `specs/` records.
A record that disagrees with the code is stale; re-derive it, never obey
it. A record is never cited to reject a code change. Falsified records
stay in the repo with their counterexample recorded.

A record must pay rent in a found bug or a named residual. Do not write
records for invariants already on the `type` rung, for module coverage,
or with risk scores or likelihood estimates.

## Claims

- Quantify over a domain a checker can mechanically enumerate: deletion
  sites, outcome writers, exit channels, call sites.
- Name the exact durable predicate, not the intuition ("consensus
  durably observed", not "reached consensus").
- State the adversary model in the claim: crash points, malicious peers,
  concurrent verbs. An unstated concurrency model is an unfiled residual.

## Axioms

- Every axiom is used by a lemma; every external lean of a lemma is
  covered by an axiom.
- State where the guarantee bottoms out (hash hardness, signature
  unforgeability, single-instance locks, child-process behavior).
- The common defect is the smuggled premise: a protocol, crypto, or
  deployment fact the argument uses and never states. The auditor hunts
  these.

## Rungs

Each lemma is labeled with the mechanism that catches its regression:

- `type` — compiler-checked; misuse does not build.
- `schema` — database constraint; violation fails the write.
- `claim` — exact conclusion of an explicitly imported, currently passing
  claim record; checked transitively as described above.
- `test` — a named test fails.
- `code` — a local reading of one guard or ordering.
- `enum` — an enumeration; regenerated on every check, never trusted as
  written.
- axiom — trusted, not checked.

Label by what mechanically catches the regression, not what the code
gestures at: a compile-time const referencing an invariant enforced by a
runtime constructor is `code`, not `type`. Do not derive an invariant
from a one-time gate check; under concurrency a lemma needs the gate and
the guarded action in one critical section, or a durable recheck, and
must say which.

## Residuals

- Each residual states why it falls outside the claim's quantifiers.
  Misfiling an in-claim counterexample as a residual is an argument bug.
- Agents do not accept new residuals. A newly discovered residual is
  surfaced to the component owner; an existing one cites the ruling that
  accepted it.

## The two-role check

Both roles run as separate agents before any verdict:

- **Blind falsifier**: workspace forked from a revision without the
  record; receives only the claim, axioms, and falsification procedure;
  must not read `claims/`. It regenerates the enumerations, derives each
  site's guards and reachability, and attempts counterexample traces. A
  pass is credible only with the attempted counterexamples and what
  blocked each.
- **Argument auditor**: receives the record; attacks the argument, not the
  conclusion — misread guards, lock scopes, and orderings at line level;
  non-exhaustive case splits; smuggled assumptions; enumerations
  regenerated against the record's lists; residual filing; axiom
  sufficiency. Point it at the specific joints a hostile reviewer would
  attack.

The falsifier catches bugs the argument missed; the auditor catches true
conclusions reached through invalid arguments. Fold both reports into
the record. The author's own derivation alone never yields a pass.

## Verdicts

The verdict line carries pass / falsified / provisional, the date, and
what each role found, including repairs the check forced. Provisional
means the two-role check has not completed. Falsified names the
counterexample and stands until the code changes and the argument is
re-derived. A pass means "survived falsification as of this date",
never "cannot happen".

## Re-checking on code changes

The rung is the re-check policy:

- `type` / `schema` — re-checked by every build and migration; cannot go
  stale.
- `claim` — stale when the imported record, verdict, or any part of its
  effective scope changes; recheck the leaf first, then the parent's glue.
- `test` — re-checked by CI; the only obligation is that the named test
  still exists and still forces the failure path.
- `code` — stale when a file the lemma cites changes; re-read the guard,
  update or repair the lemma.
- `enum` — stale on any change within the record's scope; regenerate the
  enumeration and diff it against the lemma.
- axiom — stale on dependency and deployment changes (a library bump, a
  new process model); re-examined with the owner.

A change landing inside a record's scope carries the re-check in the same
PR, the same rule as spec/code sync: regenerate stale `enum` lemmas,
re-read stale `code` lemmas, update the verdict date — or, if a lemma no
longer holds, the record is falsified in that PR and says so. A PR that
invalidates a lemma and leaves the record silently green is a bug. The
full two-role check re-runs only when the claim or the argument's
structure changes, not for lemma-local re-checks.

Staleness is promotion pressure: a lemma that keeps going stale should
move up a rung — an `enum` over call sites becomes a lint or a pinned
test (a disallowed-method lint reduces "exactly two deletion sites" to
build time), a `code` ordering becomes a test. A healthy record shrinks
toward pointers at machine-checked facts. Detection stays an obligation
on changes until scope-diffing demonstrably needs tooling.

## Author procedure

- Derive from code, never from memory; re-derivation is where claims
  gain precision.
- Before spawning the roles, run your own falsification: enumerate all
  writers, all exit channels (an RPC response is an exit channel), all
  interleavings the lemmas assume away.
- When a check exposes a failure mode this skill did not anticipate,
  repair the record and add the rule here.
