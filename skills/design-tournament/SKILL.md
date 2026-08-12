---
name: design-tournament
description: Find a product's best experience by selection pressure — many independent blinded theses, a pruning panel, prototypes for the survivors, and pairwise blinded duels on identical journeys — betting that breadth plus comparison beats curated distinctness and single-vision depth.
---

# Design tournament

The bet this system makes: the best design is **found, not authored**.
A director writing three theses samples their own imagination three
times; a single auteur samples it once. This system samples many
independent minds cheaply, then lets selection pressure — not
synthesis, not conviction — decide. Its second bet: judgment is most
reliable **pairwise**. People and models are poor at absolute scoring
and good at "which of these two served this person better, and why."

Shared law (not part of the bet): experience first, technology is a
cost, not a wall — the current implementation is evidence of what is
cheap, never a definition of what is possible; only the human declares
constraints immovable, attributed in `design/INTENT.md`, which speaks
of people and goals, never mechanisms. Prototypes are the medium —
real DOM, mocked world, journeys experienceable end to end. Reports
travel as files; mail carries pointers; write-once distinct paths.
Nobody publishes, deploys, or pushes.

You are the tournament organizer. You author no thesis, build no
prototype, and judge no duel — organizers with a horse in the race
corrupt every round.

## Round 0 — the commons

Prepare what every competitor shares, so entries differ only in
design: `design/INTENT.md` (draft from hands-on use if missing,
nothing self-declared fixed), one fixture story (named people, one
concrete goal), and one adversity script (the same bad afternoon for
everyone). Publish these as files.

## Round 1 — open call

Spawn **6–8 thesis writers** in parallel (respect your concurrency
cap), each blinded, each receiving only: the intent file, the fixture
story, and the product to experience hands-on. Each returns a
one-page thesis: the experience bet in one sentence, the shape of the
journey scene by scene, what mechanism changes it requires and a
rough price, and what it deliberately sacrifices. Instruct genuine
conviction — a thesis hedging toward the current product wastes its
slot; the current product is already in the tournament as the
incumbent baseline.

## Round 2 — the cut

Field a pruning panel of **two blinded jurors**; each independently
ranks all theses on ambition, coherence, and distinctiveness-from-
each-other, in writing. You combine the two rankings mechanically
(agreed top picks first), enforcing diversity: never advance two
theses that are one idea at two polish levels, even if both rank
high. Advance **3–4** theses. Record every cut thesis and why — cut
ideas are inherited leads for future tournaments.

## Round 3 — build

Spawn one builder per surviving thesis, each in its own workspace,
each plugging into the shared mock world, fixture story, and
adversity script. Prototypes declare their mock boundary and builder-
reported effort as their price. Every prototype must complete the
fixture journey end to end in a browser.

## Round 4 — duels

Round-robin, pairwise: for each pair of surviving prototypes, spawn
one **fresh blinded duel judge** who receives two running prototypes
(neutral labels, randomized order), the intent file, the fixture
story, and the adversity script — never the theses, never other
duels' outcomes, never standings. The judge walks the identical
journey and the identical bad afternoon through both, then files:
which served the fixture people better, the three moments that
decided it (replay frames attached), and what the loser did better
that the winner should steal. No scores — a pick, its reasons, and
the theft list.

A duel judge that cannot honestly pick declares a tie with reasons;
ties are legal results, not failures. Before any judge charges that a
control does not respond, it proves the interaction reached the
element (scrolled into view, event landed on the element, not the page
root) — browser harnesses silently miss off-viewport targets, and an
unreceived event is not product evidence.

## The verdict

Standings from duel results (wins, with ties split). Deliver to the
human:

- The champion prototype, running, with a sub-two-minute replay.
- The bracket: every duel's pick and deciding moments.
- The **theft list**: what the champion must adopt from each defeated
  entry, as concrete revisions.
- The cut record from round 2 — the roads not built.
- The ruling requested: back the champion's bet, or name the defeated
  or cut thesis that deserved to win — either way one choice, banked
  in `design/preferences.md`.

Label all judge and lens evidence as simulated behavioral review,
never as user research. Paths in the closing message are
**workspace-absolute** — your workspace root plus the file path,
never the repo root: the reader is outside your workspace.
