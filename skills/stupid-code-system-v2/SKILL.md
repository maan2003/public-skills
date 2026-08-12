---
name: stupid-code-system-v2
description: Siege one module for stupid code with a minimal crew — a self-driving scanner/checker pair plus two blinded specialists — and hand the human the checked findings directly. Depth over coverage; no phases, no index.
---

# Stupid-code siege — minimal system

One module, named by the human. Four working agents, no bureaucracy:
experience with the larger system (`../stupid-code-system/`) showed the
findings live in the artifacts and the adversarial pair, while process
layers mostly managed — and sometimes destroyed — what the small crew
had already found. You coordinate, then synthesize from files. You never
modify production code.

The role skills are the big system's bench, referenced in place:
`../stupid-code-system/<role>/SKILL.md`.

## The recipe

1. **The pair.** Spawn one engineer with the scanner skill on the
   module. It writes `reviews/stupid-code/<module>.md` in the audited
   repo and self-spawns its hostile checker, which writes
   `<module>-checked.md`. The checked report is the backbone; nothing
   unchecked is ever presented as checked.
2. **Two specialists, blinded, in parallel with the pair.** Pick the two
   bench roles whose catch-class best fits the module, and spawn each
   with only the module scope and its one skill path — never the pair's
   record, never each other's output, never your reasoning:
   - `burden/` — decision-dense code; highest recall, lowest precision
   - `coroner/` — lifecycle, recovery, money, irreplaceable data
   - `policy-court/` — spec-governed behavior, mandate interactions
   - `courier/` — data crossing the module's boundaries end to end
   - `historian/` — code that smells of reverted or laundered decisions
   Have each write its report to `reviews/stupid-code/<role>-<module>.md`
   and mail you only the path, counts, and its one headline finding —
   reports travel as files, never as message bodies.
3. **Synthesize from disk.** Read the checked report and both specialist
   reports from their files, then deliver one message to the human:
   convictions ranked by real cost, blinded convergences flagged (a
   finding reached independently by roles that could not read each other
   is the strongest evidence this system produces), specialist-only
   convictions marked unchecked, and the weakest surviving acquittals
   named. Point at the record files; do not re-package them into a new
   format.
4. **Round 2 is the human's call, not a phase.** If they want more,
   field `defense/` against the convictions, or a fresh role against the
   survivors and weakest acquittals. Iterating on survivors is where the
   best findings have historically come from — offer it, don't assume it.

## Rules that survive from the big system

- Blinding is absolute among your agents; convergence is only evidence
  when they could not have read each other. Never field a
  rewrite-the-module role: a model's design converging with the code is
  correlated evidence and acquits nothing.
- Records live in the audited repo and version with the code they
  judge; a later change inside a record's scope stales its acquittals,
  and a re-run inherits its leads.
- Publishing the records anywhere — a pull request, a push, a shared
  branch — is the human's move, never yours. The siege ends with your
  synthesis message.
