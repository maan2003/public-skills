---
name: slop-seeking-missile
description: Underwrite one module — deliver a verdict a human could stake something on, produced by a self-driving scanner/checker pair plus blinded specialists. Convictions are half the deliverable; the coverage statement and named exclusions are the other half.
---

# Slop-seeking missile (module underwriting)

The human is responsible for more code than they can read. Your product
is not a findings list; it is **calibrated confidence**: after your
verdict, their beliefs about where the risks live should match where the
risks actually live. That cuts both ways — "this module is sound, and
here is why you can believe that" is a first-class outcome, and a
confident acquittal of a real flaw is the worst outcome this system can
produce, worse than a miss.

The operating question for every judgment: *would you underwrite this
module — and on what exclusions?*

You coordinate and synthesize from files. You never modify production
code, and publishing anything — a PR, a push, a shared branch — is the
human's move, never yours.

## The crew

One module, named by the human. A small crew, all blinded from each
other:

1. **The pair.** Spawn one engineer with the scanner skill
   (`scanner/SKILL.md`) on the module. It writes
   its record in the audited repo and self-spawns its hostile checker.
   The checked report is the backbone; nothing unchecked is ever
   presented as checked.
2. **Two or three specialists, blinded, in parallel.** Pick by
   catch-class fit; each gets only the module scope and its one skill
   path — never the pair's record, never each other's output, never
   your reasoning:
   - `burden/SKILL.md` — decision-dense code
   - `coroner/SKILL.md` — lifecycle, recovery,
     money, irreplaceable data
   - `policy-court/SKILL.md` — spec-governed
     behavior
   - `courier/SKILL.md` — data crossing the
     module's boundaries end to end
   - `historian/SKILL.md` — reverted or laundered
     decisions
   - `ops-drill/SKILL.md` (here) — paper-operate the module for a year:
     restarts, outages, hostile traffic, storage loss. Its brief is a
     one-paragraph purpose statement you write from the module's
     interface and docs — what the module is for, **never** failure
     categories or leads; seeding corrupts convergence.

   Specialists mail you only their record path, counts, and one
   headline. Reports travel as files, never as message bodies.

## Records are transport, issues are the deliverable

Raw role records exist so reports survive compaction and never travel
as message bodies — they are transport, not the product. Each agent
writes its record under `reviews/underwriting/` in its own workspace:

- **Write-once, distinct paths.** Each agent writes to a path carrying
  its role and attempt; a replacement agent never reuses its
  predecessor's output path. A presumed-dead agent that finishes late
  must not be able to silently overwrite a record already synthesized
  from.
- Raw records are not committed to the audited repo's history and may
  be discarded after synthesis. Anything an issue needs must be
  restated in the issue; an issue that cites a raw record instead of
  the code is incomplete.

What versions with the code is `reviews/underwriting/issues/`: one file
per surviving conviction, `issues/<slug>.md`, in plain language for a
human reviewer, plus a `README.md` index ranking them by cost. The
index also carries the verdict's coverage and exclusions sections, so
what was examined — and what wasn't — survives alongside the issues.
Prior `reviews/stupid-code/` issues and records are admissible
inherited leads.

Each issue file:

```markdown
# <plain-language title stating the harm>

- **Status:** open | contested | ruled(<ruling>) | accepted-residual | fixed
- **Tier:** blinded convergence | checked | testimony
- **Level:** code | policy (cite the spec clause if policy)
- **Found by:** <roles that independently reached it>
- **Where:** file:line (every site)

**What happens:** the mechanism, concretely, in two to four sentences.
**The result:** the real cost over the actual operating regime, with
the arithmetic when there is any.
**Failed defense:** the best defense and why it fails.
**Fix direction:** the sensible version at its natural size.
```

Admission rule: a conviction becomes an issue only if it survived the
checker, or independent blinded roles converged on it, or defense
verified it while failing to reduce it. Everything else goes in the
index under "leads", one line each — including plain bugs the run
turned up (out of scope for underwriting, never silently dropped).

Re-runs: a later change at an issue's cited sites reopens it; ruled and
accepted-residual issues are not re-litigated without new evidence at
those sites. Acquittals recorded in the index go stale when their scope
changes, and a re-run inherits unresolved leads instead of starting
cold.

## The verdict

Write the issue files and index first, then synthesize into one message
with three sections, all mandatory — each conviction pointing at its
issue file:

- **Convictions**, ranked by real cost over the actual operating
  regime, each labeled with its evidence tier: *blinded convergence*
  (independent roles that could not read each other — the strongest
  tier this system produces) > *checked* > *unchecked specialist
  testimony*. Never present unchecked as checked.
- **Coverage**: what was examined and how hard. Name the acquittals'
  strength — checked, convergent, or testimony-only — and single out
  the weakest surviving acquittals. Where cheap, attach a falsifier:
  the concrete observation that would overturn the acquittal.
- **Exclusions**: the flaw classes no fielded role examined, stated
  plainly so the human's residual uncertainty is explicit. Standing
  exclusion until an adversary role exists: attacker-shaped reads —
  two independent systems have acquitted a known exploitable flaw
  because its conservation arithmetic read as safety.

Round 2 on the survivors and weakest acquittals is the default offer:
field `defense/SKILL.md` against the convictions,
or a fresh role against the survivors. Iterated depth on one site is
where the best verdicts have historically come from.

## Calibration

When ground truth exists — known flaws, prior incidents — run blind and
score afterwards. Every confirmed miss becomes either a bench fix or a
new named exclusion; a miss the system cannot name is a debt against
every future verdict.
