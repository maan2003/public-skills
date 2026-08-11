# Stupid-code protocol — two agents, one record

The core detector is a pair of skills joined by a written artifact. Around
it sits a bench of specialist roles (see "The bench" below) that find
classes the pair misses; field them together on high-stakes modules.

**Unit of operation: one component, chosen by a human** (e.g. one
service's crates), not the whole repository. Within the component the machine is
autonomous: a triage skim (`stupid-code-p`) ranks its modules and routes
specialists; the pair and bench run per module; records accumulate under
`reviews/stupid-code/`; an aggregation pass fuses them into the component
digest with a convergence ledger. Cross-component targeting is the
human's call.

1. **Scan.** An engineer with the `stupid-code` skill reads a module cold
   and writes a **record**: findings, a decision inventory with a verdict
   *and defense* per decision, named weakest acquittals, unresolved leads.
   The record's format is a forcing function, not paperwork — every clause
   exists because its absence let a scanner evade a judgment (skip a
   decision, absorb a false comment, acquit in silence).
2. **Check.** A second engineer with the `stupid-code-check` skill attacks
   the record hostilely: overturns acquittals by recomputation, verifies
   convictions at their cited sites, regenerates the inventory for at
   least one file. The scanner's derivation alone never yields a checked
   verdict.
3. **The checked report is the deliverable.** Findings that survive both
   agents, ranked. The scanner's own report is testimony and is not
   published on its own.

The protocol is self-driving: the scanner spawns its own checker, passing
only the record file, scope, and repo path — the check must not inherit
the scanner's unwritten reasoning.

## Lifecycle

Records live in the audited repo: the scanner writes
`reviews/stupid-code/<module>.md`, the checker writes
`<module>-checked.md` beside it, dated. Versioned with the code they
judge:

- **Acquittals are falsifiable claims.** Each is scoped to the code it
  judged; a change inside a record's scope stales its acquittals, and a
  re-scan inherits the old record's leads and weakest acquittals instead
  of starting cold.
- **Findings pay rent.** Each checked finding either becomes a fix or a
  human-accepted residual with a one-line ruling ("known, kept because
  X"). Agents never accept residuals; humans do. Convicted-and-accepted
  is a recorded state, not a re-flagged annoyance.
- **No rungs, no proofs.** Verdicts here are engineering judgment, not
  lemmas; the record carries defenses and arithmetic, nothing heavier.

## The bench

Specialist roles, each with a proven distinct catch-class (validation
audit, 2026-08). They are complements, not alternatives; overlap between roles is
cross-validation, and a finding converged on by independent roles outranks
any single verdict:

- **`coroner/`** — future incident postmortems; catches state-lifecycle
  and operational-harm holes forward scanning misses.
- **`burden/`** — decisions start convicted; highest recall, lowest
  precision; always follow with the checker or defense.
- **`policy-court/`** — tries the specs first; the only role that catches
  spec-laundered policy and spec-internal inconsistency, including the
  mandatory interaction pass over mandate combinations.
- **`courier/`** — escorts core data end to end across the component;
  the only role that reaches multi-module journey findings.
- **`historian/`** — version-history archaeology; provenance evidence
  (known-but-unfixed, tuned-number-instead-of-fix) and the role that can
  distinguish symptom patching from honest convergence.
- **`scout/`** — cheap triage; ranks modules and routes the roles above.
- **`defense/`** — audits convictions the way the checker audits
  acquittals; without it, convictions are unaudited.

Retired: rewrite/diff detection. The detector model
shares priors with the models that wrote the code, so its greenfield
rewrite re-adopts the same flaws; convergence between a model's design and
the code is correlated evidence and never acquits. Corollary for every
role: the "what a competent engineer would build" standard is a comparison
inside an adversarial argument, not an oracle — an acquittal needs a
problem-grounded defense, not a matching intuition.

## Why the artifact is the mechanism (experiment notes, 2026-08)

Every variant that beat baseline did so because its mandatory document made
a specific evasion unwritable: an inventory forbids silently skipping a
decision; required arithmetic forbids "cheap" as a word; scenario narration
forbids not noticing redone work; a claims audit forbids absorbing a false
comment; a mandatory weakest-acquittal forbids the empty confident report;
and the checker forbids the steelman that dies unexamined in one head. The
persona and stance mattered far less than the artifact. Design the document
first; the judgment follows.
