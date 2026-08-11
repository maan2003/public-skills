---
name: stupid-code-c
description: Find stupid code in one module by clean-room sketching the obvious implementation from the module's purpose alone, then diffing the real code against the sketch.
---

# Stupid code detector — clean-room diff

You cannot see stupidity by reading code sympathetically: the text anchors
you, and every weird choice starts to look inevitable. So you will build the
reference point *first*. Sketch how the module obviously ought to work before
you ever read its internals, then diff reality against the sketch. Every
divergence is either a constraint you didn't know — or a finding.

The order of phases is the entire method. Do not read function bodies before
Phase 2 is written down; once you have read the implementation you can never
get the unanchored view back.

## Phase 1 — Surface only

Read only the module's outside: its public API (signatures, exported types,
doc comments on exported items) and how its callers use it. Grep for call
sites in the rest of the repo if needed. **Do not read function bodies. Do
not read specs.** From this, state the module's purpose in one or two
sentences.

## Phase 2 — The clean-room sketch

Write down (in your report, not just your head) how an experienced engineer
would obviously build this: roughly half a page of outline or pseudocode.

- Use the primitives the ecosystem actually offers — the async runtime,
  existing dependencies in Cargo.toml, subscription/notify APIs, the type
  system. Check Cargo.toml for what is already available.
- Note which policies/numbers the design would need (timeouts, limits) and
  what would drive choosing them.
- Note what state is genuinely necessary, and who owns it.
- Prefer the boring design. You are sketching the obvious, not the clever.

## Phase 3 — Read and diff

Now read the real implementation top to bottom. List every material
divergence between the sketch and reality. For each, decide honestly which
side is right:

- **The code knows something you didn't** — a real constraint (an API quirk,
  a protocol requirement, a failure mode your sketch missed). Adopt it: note
  the constraint and move on. Expect this to be the common case.
- **Your sketch is genuinely simpler or better** — candidate finding. Before
  it becomes a finding, steelman the code once more: the best defense appeals
  to the problem itself. "A spec/comment/test says so" is provenance, not a
  defense, and does not count.

A candidate becomes a finding only if the sketch's version is obviously
better at similar or lower effort **and** the gap has real cost (resources,
fragility, misbehavior at scale, reader tax). Bugs and style are not
divergences you track. Costless differences are noise — drop them.

## Phase 4 — Report

Report, in order:

1. **Purpose** (from Phase 1) and the **clean-room sketch** (from Phase 2),
   as written before reading the internals.
2. **Findings**: the divergences that survived, ranked by cost, hard cap 5.
   "The implementation matched the obvious design" is a valid, complete
   outcome. Each finding:
   - **Where**: `file:line`
   - **Reality vs sketch**: one sentence each
   - **Real cost**: concretely — "inelegant" is not a cost
   - **Level**: *code* (mechanism) or *policy* (the decision itself, however
     well implemented). You may check specs only at this step, solely to
     classify: a spec mandating the behavior makes it policy, never excuses
     it.
3. **Constraints adopted**: one line each for divergences where the code was
   right and your sketch was wrong — this keeps you honest about the diff.
