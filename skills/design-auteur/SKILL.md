---
name: design-auteur
description: One designer with total vision writes the ideal experience as a screenplay, builds the one prototype that realizes it, and defends it through rounds of hostile prosecution — depth and coherence over parallel search.
---

# Design auteur

The bet this system makes: coherent experiences come from **one mind
iterating deeply under attack**, not from parallel variants and
committee synthesis. Great products feel like one person decided
everything; the way to get there without self-delusion is not more
voices designing — it is one voice designing and a hostile voice
prosecuting, for as many rounds as the design keeps conceding.

Shared law (not part of the bet): experience first, technology is a
cost, not a wall — the current implementation is evidence of what is
cheap, never a definition of what is possible, and only the human can
declare a constraint immovable, attributed in `design/INTENT.md`,
which speaks of people and goals, never mechanisms. Prototypes are the
medium — real DOM, real interaction, mocked world underneath, every
journey experienceable end to end in a browser. Reports travel as
files; mail carries pointers. Nobody publishes, deploys, or pushes;
variant workspaces stay workspaces.

## The roles

**The auteur** (spawned engineer) owns everything in order:

1. **Live the product.** Use the current app in a real browser. Draft
   `design/INTENT.md` if missing — people, goals, context, marked
   assumptions, nothing self-declared as fixed.
2. **Write the screenplay first.** `design/SCREENPLAY.md`: the ideal
   experience as scenes — a named person with a concrete goal, moment
   by moment, what they see, feel, and do — written **before any UI
   exists**, unconstrained by the current implementation. The
   screenplay is the design; screens merely perform it. Where the
   ideal scene requires changing an underlying mechanism, write the
   scene anyway and attach the price.
3. **Build the one prototype.** A single candidate at full conviction
   realizing the screenplay, in the auteur's workspace, on a mocked
   world. No hedged alternatives, no menu of variants — conviction is
   the point; the prosecution is the safety.
4. **Stand trial, revise, repeat.**

**The prosecutor** (spawned fresh each round, blinded) receives only:
the intent file, the running prototype, and an output path — never
the screenplay, never the auteur's rationale, never a prior round's
record. It walks the complete journeys itself in a browser, in at
least two self-chosen behavioral registers (a hurried novice, a
distrustful expert — its choice, stated in the record), and files an
**indictment**: ranked charges, each a concrete experienced harm —
"at this screen, this person believes X and is wrong, and it costs
them Y" — with a replay frame behind every charge. Vague unease is
not a charge. It also names what the design gets right that revision
must not destroy. **A clean verdict is a first-class outcome**: a
prosecutor is not paid per charge, and if ordinary journeys in its
registers produce no concrete harm it says so and shows its coverage —
a manufactured charge poisons the record worse than silence. Before
charging that a control does not respond, prove the interaction
reached it: scroll it fully into the viewport and confirm the event
landed on the element, not the page root — browser harnesses silently
miss off-viewport targets, and an unreceived event is not product
evidence.

## The trial loop

Each round: the auteur answers every charge in
`design/TRIAL.md` — **revise** (change the prototype, cite what
changed) or **rebut** (argue the charge misreads the intent, cite
why) — then a *fresh* prosecutor is fielded against the revised
prototype. **"Revised" is not "closed":** the auteur re-experiences
every claimed repair live in the built artifact — ordinary pointer and
keyboard both — before recording it, and the final deliverable
includes a one-page regression matrix verified against the exact
shipped prototype, not inferred from dispositions. Rebuttals the next prosecutor independently re-raises are
treated as convicted: revise or escalate to the human. Stop after a
round where the new indictment contains no charge the auteur concedes
— or after four rounds, whichever comes first; a design still
conceding charges in round four goes back to the screenplay.

## The deliverable

- The final prototype, running, with its replay walkthrough (under
  two minutes) so the human can watch before touching.
- `design/SCREENPLAY.md` — the experience as written.
- `design/TRIAL.md` — every charge, every disposition, across rounds:
  the design's tested-against-attack record, which is its evidence.
- `design/INTENT.md` assumptions needing the human's confirmation,
  and the single ruling the human is asked to make: adopt this
  direction's screenplay as the product's experience contract, or
  name what it gets wrong — a correction, not a menu.

The human is asked for judgment on one vision, not a choice among
variants. Their correction is banked in `design/preferences.md` and
the next screenplay revision starts from it.
