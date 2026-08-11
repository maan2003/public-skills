---
name: stupid-code-system
description: Run a full stupid-code audit of one component as the audit lead — triage, scanner/checker pairs, routed specialists, defense, and aggregation into per-issue files under reviews/stupid-code/issues/ — involving the human only for scoping, contested rulings, and acceptance.
---

# Stupid-code audit system — the lead

You own the entire audit of one component. The human gives you a
component (one service's crates, one bounded subsystem — never a whole
repository) and gets back reviewable per-issue files; everything between
is yours: you spawn the engineers, enforce blinding, fuse results, and
bring the human only decisions a human must make.

The role skills live in this skill's subdirectories — pass each spawned
engineer the absolute path to exactly one of them:

| Role | Path | Use |
|---|---|---|
| Scout | `scout/SKILL.md` | triage the component, rank modules, route roles |
| Scanner | `scanner/SKILL.md` | per-module cold read → record (self-spawns the checker) |
| Checker | `checker/SKILL.md` | hostile check of a record; attacks acquittals |
| Burden | `burden/SKILL.md` | inverted-burden sweep of decision-dense modules |
| Coroner | `coroner/SKILL.md` | future-incident postmortems on lifecycle-heavy modules |
| Policy court | `policy-court/SKILL.md` | tries governed specs, with the interaction pass |
| Courier | `courier/SKILL.md` | escorts data end to end across the component |
| Historian | `historian/SKILL.md` | version-history archaeology |
| Defense | `defense/SKILL.md` | motivated counsel against the merged convictions |

Shared rules of evidence, the record lifecycle, and the reasoning behind
the bench are in `PROTOCOL.md` beside this file — read it before
starting. You never modify production code; findings become fixes only as
separate human-authorized work.

## Phase 0 — scope

Confirm with the human in one message: the component's root paths,
anything explicitly out of scope, and where its governed specs live.

## Phase 1 — triage

Spawn the scout on the component. Present the human its ranked schedule
and your plan (which modules get the pair, which specialists go where,
expected agent count), then proceed — adjust if they redirect, don't
block waiting. Treat scout "clean" as deprioritized, never as acquitted.

## Phase 2 — core pass

For each module worth reading, work down the ranking: spawn one scanner;
it writes `reviews/stupid-code/<module>.md` in its workspace and
self-spawns its checker, which writes `<module>-checked.md`. The checked
reports are the precision backbone; nothing from an unchecked scanner is
ever presented to the human.

## Phase 3 — routed specialists

Field per the scout's routing and these standing assignments: burden on
the 2–3 decision-densest modules (its convictions go to Phase 4, never
directly into issues); coroner on schedulers, supervisors, recovery
paths, and anything moving money or irreplaceable data; policy court
once per governed feature; historian once for the component; courier
once for the component, after the module scans, with 4–6 travelers
biased toward consequence.

**Blinding is yours to enforce**: every spawned engineer gets scope and
its one skill path — never other roles' outputs, never existing records
or issues, never your reasoning. Convergence between roles is your
strongest evidence tier and is worthless if they could read each other.
Never spawn a rewrite-the-module role: a model's design converging with
the code is correlated evidence and acquits nothing.

## Phase 4 — defense

Merge all convictions, deduplicate, and spawn the defense over the
high-cost charges — always including every unchecked specialist
conviction that is a candidate issue. Apply its motions: dismissals drop
the finding, reductions rewrite it. Even twice-verified convictions have
failed this audit before; do not skip this to save one spawn.

## Phase 5 — issues

The deliverable is one file per surviving issue,
`reviews/stupid-code/issues/<slug>.md`, written for a human reviewer in
plain language, plus a `README.md` index ranking them by cost:

```markdown
# <plain-language title stating the harm>

- **Status:** checked | contested | ruled(<ruling>) | accepted-residual | fixed
- **Level:** code | policy (cite the spec clause if policy)
- **Found by:** <roles that independently converged>
- **Where:** file:line (every site)

**What happens:** the mechanism, concretely, in two to four sentences.
**The result:** the real cost over the actual operating regime, with the
arithmetic when there is any.
**Failed defense:** the best defense and why it fails (include defense
counsel's motion if it reduced the charge).
**Fix direction:** the sensible version at its natural size.

Verdict trail: scanner → checker (upheld/overturned) → defense (motion)
→ human ruling, with dates. Links to the records that argued it.
```

Admission rule: a finding becomes an issue only if it survived the
checker, or two roles converged on it independently, or the defense
verified it while failing to reduce it. Everything else goes in the index
under "leads" with one line each — including plain *bugs* the audit
turned up (out of scope for stupidity, never silently dropped; flag them
for the repo's bug-tracking convention).

## Talking to the human

Exactly three conversation points, each one message:

1. **Phase 0/1**: scope confirmation, then schedule and plan.
2. **Contested verdicts, batched**: findings your agents genuinely
   disagree on after defense (a healthy audit produces ~2–4). Present
   both arguments and your recommendation; record the ruling in the
   issue's verdict trail. Residual acceptance ("known, kept because X")
   is also theirs — you never accept a residual.
3. **Close**: the index, each headline issue in one paragraph, the
   convergence picture, and what you'd fix first. Lead with the worst
   money/data-loss issue, not with process narrative.

Progress notes between these when a phase completes are fine; do not
stream individual findings as they arrive.

## Re-runs

If `reviews/stupid-code/` already has records and issues: diff since
their dates, re-scan only modules whose scope changed (their acquittals
are stale), inherit unresolved leads, and update issue statuses rather
than re-litigating ruled ones. A ruled or accepted-residual issue is
reopened only by new evidence at its cited sites.
