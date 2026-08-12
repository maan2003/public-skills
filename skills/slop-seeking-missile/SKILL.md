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
   (`../stupid-code-system/scanner/SKILL.md`) on the module. It writes
   its record in the audited repo and self-spawns its hostile checker.
   The checked report is the backbone; nothing unchecked is ever
   presented as checked.
2. **Two or three specialists, blinded, in parallel.** Pick by
   catch-class fit; each gets only the module scope and its one skill
   path — never the pair's record, never each other's output, never
   your reasoning:
   - `../stupid-code-system/burden/SKILL.md` — decision-dense code
   - `../stupid-code-system/coroner/SKILL.md` — lifecycle, recovery,
     money, irreplaceable data
   - `../stupid-code-system/policy-court/SKILL.md` — spec-governed
     behavior
   - `../stupid-code-system/courier/SKILL.md` — data crossing the
     module's boundaries end to end
   - `../stupid-code-system/historian/SKILL.md` — reverted or laundered
     decisions
   - `ops-drill/SKILL.md` (here) — paper-operate the module for a year:
     restarts, outages, hostile traffic, storage loss. Its brief is a
     one-paragraph purpose statement you write from the module's
     interface and docs — what the module is for, **never** failure
     categories or leads; seeding corrupts convergence.

   Specialists mail you only their record path, counts, and one
   headline. Reports travel as files, never as message bodies.

## Records

- Records live in `reviews/underwriting/` in the audited repo and
  version with the code they judge; a later change inside a record's
  scope stales its acquittals, and a re-run inherits its leads. Prior
  `reviews/stupid-code/` records are admissible inherited leads.
- **Write-once, distinct paths.** Each agent writes to a path carrying
  its role and attempt; a replacement agent never reuses its
  predecessor's output path. A presumed-dead agent that finishes late
  must not be able to silently overwrite a record already synthesized
  from.

## The verdict

Synthesize from disk into one message with three sections, all
mandatory:

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
field `../stupid-code-system/defense/SKILL.md` against the convictions,
or a fresh role against the survivors. Iterated depth on one site is
where the best verdicts have historically come from.

## Calibration

When ground truth exists — known flaws, prior incidents — run blind and
score afterwards. Every confirmed miss becomes either a bench fix or a
new named exclusion; a miss the system cannot name is a debt against
every future verdict.
