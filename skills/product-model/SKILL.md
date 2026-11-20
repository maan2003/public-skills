---
name: product-model
description: Use whenever designing, reviewing, judging, or changing anything a user sees or does in a project that adopts the Product Model convention, including when reading, citing, or questioning its modules (product/*.md with user, day, value, non-goal, bet, journey, flow, concept, screen, and rule declarations).
user-invocable: true
---

# Product Model

The Product Model describes a product the way its user experiences it, in Markdown modules written in the user's words. It sits between a project's values and its code: it says what the user can see and do, why, and what a visit costs them. Engineering knowledge, such as architecture, decisions, and contracts, belongs elsewhere, for example in Linked Specs.

The convention exists because agents reason from the richest text they can find. In most projects that is the code, so a question about a screen turns into a question about a function, and the answer comes back in the code's vocabulary. Modules in the user's language give agents something at the right level to reason from, and a vocabulary that findings and proposals must be stated in.

Consulting this skill does not mean a module should be created or changed. Ordinary work that changes what the user sees reads the modules; it changes one only when the product itself changed in a way the modules describe.

## Modules

The model lives in a `product/` directory inside the directory that holds the product: the project root, or a package root when a repository ships several products. Every file in it is a module with the same grammar. `index.md` is the module about the product as a whole: its user, its day, its values, and its non-goals. Every other module is one area of the product, named as the user would name it, such as `deal.md`, `chat.md`, or `notes.md`, and holds the bets, journeys, flows, concepts, screens, and rules of its area together, so a reader opens one file to understand one area. `rg '^## (user|day|value|non-goal|bet|journey|flow|concept|screen|rule) '` lists every declaration.

Everything in a module is written in the third person: the user, they, their; never I or you. A module starts with `# <module>` and a sentence or two on what the area is for. After that, each `##` heading is a declaration: `## bet Chat is the medium`, `## journey An idea becomes a merged result`, `## flow Clear what waits`, `## concept Card`, `## screen Home`, `## rule <short name>`. Bets come first, because they are the first how; journeys next, because they are what the flows serve. A declaration's body is labeled lines, `label: text`, and lists under a label. Lines not covered by a label are prose and are allowed anywhere.

Declarations and their labels:

- `user`: who they are, their situation, the devices, how often and for how long they are in the product, and what they remember between visits. Prose. Normally once, in `index.md`.
- `day`: what the user does in the product, as a numbered list in order of weight: a bold name and one sentence each. These are the reasons the user is there at all, independent of how the product serves them; every journey and flow serves one of them. A line that runs under all the others goes after the list. Normally once, in `index.md`.
- `value <Name>`: one or two sentences in the user's situation, and `test:` a question to ask of a change, answerable yes or no. Values are numbered in `index.md`; when two values conflict, the earlier one wins, and a value declared in an area module ranks after every value in `index.md`. A value must decide between designs; a value no design would violate is a cut.
- `non-goal <Name>`: a thing a reasonable designer would add and this product does not want, with one sentence on what it does instead.
- `bet <Name>`: one large design choice, named as a sentence, that passes three tests: it shapes more than one area, `index.md` does not already say it as a value, a non-goal, or part of the user, and it could have gone another way under the same values. A decision inside one flow or one screen is not a bet; it is a step or a sentence there. `instead of:` the alternative it rejects, in one line. `serves:` the line of the day it serves, by its bold name. `because:` why this way, in the user's situation, one or two sentences. `costs:` what the user pays for it, in one line. A bet lives in the module whose concepts it shapes most.
- `journey <Name>`: one goal of the user, from trigger to done, across screens and areas, written in the third person: the user does this, then that. `goal:` one sentence. `starts when:` the trigger. `steps:` a numbered list, one thing the user does or sees per step, each pointing at the flow that serves it by token, with branches as indented lists. `done when:` what the user can see that says the goal is met. `day:` the line it serves. `reviewed:` see below. A journey lives in the module where it starts and reaches the rest by tokens. The journeys are the product; a walk starts from one.
- `flow <Name>`: one reason the user is on one screen, written in the third person like everything else. `day:` the line it serves. `when:` the situation. `want:` what the user wants to do. `so that:` the outcome. `steps:` a numbered list, one user action per step, from arriving to done; branches as indented lists under the step they leave. `system:` what the system does without being asked. `user:` what only the user supplies. `cases:` situations worth walking beyond the defaults, optional. `reviewed:` see below.
- `concept <Name>`: one thing the user knows by name. `purpose:` one sentence of benefit to the user. `principle:` a short scenario that shows the purpose being met. `sees:` what the user can see of it, in priority order: the first items are what a list row shows, the rest need the thing open. `has:` the concepts nested in it, one per line, each marked `one` or `many`, optional. `does:` a list of actions, one per line, as `<action> <key or gesture>: what happens`; the key is optional.
- `screen <Name>`: what the user sees at once. `shows:` the concepts on it. `starts:` the flows that begin there.
- `rule <name>`: how two or more concepts act together, in one `when ... then ...` sentence. A rule is where one action in one concept has an effect in another.

Any declaration may carry `status:` right after its heading: what the built product does instead, when the product owner has agreed to a design that is not built yet.

A journey or a flow may carry `reviewed:` as `<date> · <device> · <who> · <ok | n findings>`: when it was last walked on the built product, on which device, by whom, and how it did. A missing or old `reviewed:` is the first thing to walk, and a change that touches a flow or a journey needs a new walk before its `reviewed:` is current again.

A reference to a declaration or an action is a backtick token: `` `Card` `` inside its own module, `` `deal.Card` `` from another module, `` `Card.done` `` for an action, `` `chat.Chat is the medium` `` for a bet, `` `deal.Clear what waits` `` for a flow or a journey. Tokens are the only way to name another declaration; prose that mentions a concept uses its token.

### Example

```md
# deal

The deal hands the user the one thing that wants them most.

## bet The deal, not an inbox
instead of: a list of unread things the user scans and marks read.
serves: Know what wants them.
because: the user has a minute between places and no memory of what asked; a list makes them choose, a card makes them answer.
costs: a thing the user has not answered yet is hidden behind the top card.

## journey Back from an hour elsewhere
goal: the user knows what wanted them while they were away, answers it, and is back where they were.
starts when: the user looks up from a long piece of work.
steps:
1. the user sees the lamp, or presses `tab`; Home says who wants them and how much, `home.Glance at what waits`
2. the user deals and answers each card, `Clear what waits`
3. the user goes back to the place they were, as they left it, `window.Screen.back`
done when: the deal is empty and the user's place is on screen with the cursor where it was.
day: Know what wants them.
reviewed: 2026-11-20 · laptop · reviewer · 2 findings

## concept Card
purpose: hand the user the one thing that wants them most, so they never scan a list.
principle: when something asks for the user it becomes a `Card`; `Card.deal` shows the top one; a verdict puts it away and deals the next.
sees: who wants them, why, and since when; the thing itself underneath; the deck count beside the clock.
has:
- one `chat.Source`
- one `chat.Thread`, when the card came from chat
does:
- deal `space`: show the top card
- done `d`: put the card away for good
- later `s` then a time: hide the card until the time
- never `m`: put away this card and every later one from the same `chat.Source`
- undo `u`: take back the last verdict, with the card returning as it was

## flow Clear what waits
day: Know what wants them.
when: the user has a free minute
want: see everything that asks for them and answer each
so that: nothing waits on them without their knowing
steps:
1. the user opens the product; the top `Card` is on screen
2. the user reads the card
3. `Card.done`, or `Card.later` and a time, or `Card.never`
4. the next card is on screen; repeat from 2
system: reads every source, orders the cards, drops a card whose asker has stopped waiting.
user: the verdict, and the time for later.
cases: the deck holds one card from an asker who has left
reviewed: 2026-11-20 · laptop · reviewer · ok

## screen Home
shows: `Card`, `chat.Room`
starts: `Clear what waits`, `chat.Go to a room`

## rule done settles the thread
when `Card.done` on a card that came from a `chat.Thread`, then that thread counts as `chat.Thread.settled`.
```

### What qualifies

A concept must be something the user names, or would need a word for. A journey must be a goal the user would state without naming a screen; five to eight per product is usual. A flow must be something the user comes back to do on one screen; a one-time setup is a flow only when its cost matters. A screen is a place the user recognises on arrival, not every state of one. A rule earns its place when forgetting it would make two concepts disagree. There is no target length and no completeness goal; a module with one concept and one flow is normal.

## index.md

The module about the whole product. It holds the `user`, the `day`, the numbered `value`s, and the `non-goal`s, and may hold a journey that belongs to no area. The day is what a design choice is measured against: a choice that serves the first line counts for more than one that serves the last.

## The language rule

A module names only what the user can see, do, or know. It names no function, type, module of code, table, file, crate, flag, or API. The test: a person who uses the product and has never seen its code understands every sentence and could check it against the running product. A sentence that fails the test is restated as what the user observes, or moved to code documentation.

Every declaration is written in the third person: the user, they, their. The rule also governs how you talk about the product while this skill is loaded. State a finding or a proposal in the model's vocabulary first: the journey, the flow, the step, what the user sees, what it costs them. Code references, if any, come after, in a separate part. A finding that cannot be stated without naming code is not yet a product finding.

## Using the model

Read `index.md` before work that changes what the user sees or does, and in any review of such work. Then read the modules of the areas the work touches, starting from the journeys that pass through them.

### The walk

The walk judges the product by running a journey, and the flows under it, against the built product, as the user. It is a cognitive walkthrough: at each step, does the user know what to do, do they see how, and do they understand what happened.

1. Name the journey, then the flow. If no `flow` covers what the user is doing on this screen, that is the first finding: either a declaration is missing, or the screen serves no flow. If a step of the journey has no flow to point at, that is a finding about the product, not the model.
2. Choose the situation. Walk each flow in four situations unless the flow says otherwise: first visit, routine return, return after an interruption, and the empty case. Walk each on every device the user has. Add the flow's `cases:`.
3. Walk the steps in the order of the user's actions, not in the order of the screen's parts. Fill one row per step:

```
flow Clear what waits · situation: return after interruption, phone
step | sees                   | must know or recall  | does  | then               | system could
1    | Home, 30 rows, no card | that space deals     | space | top card shows     | deal on open
2    | card text, no asker    | who asks, since when | read  |                    | show asker and age
3    | verdict menu           | d means done         | d     | row stays, no echo | drop row, echo done
```

4. Mark each row `observed` when you drove or saw it, `inferred` when you read code or reasoned.
5. Read the findings off the table. A finding is a row where the user must recall what the screen could show, where `then` is empty or unclear, where `system could` is not empty, or where the step count exceeds the steps in the module.
6. Ask each value's test from `index.md` against what you saw, and ask whether each step honours the bets of its area.
7. State each finding as the journey, the flow, the step, what the user sees, what it costs them, and which value, bet, concept, or rule it goes against. Rank findings by how often the flow runs times what the step costs.
8. When the walk is done, the owner or the lead sets `reviewed:` on the journey and each flow walked, with the date, the device, who walked, and the count of findings.

A finding that would fit any product is not a finding about this one; anchor it to a step. Findings are review output: they go in the conversation or the issue, not in a module.

### Proposing a change

Show the screen after the change as text, in the model's vocabulary, before any code. Say which journey or flow gets cheaper and by how many steps, and which value the change serves. A change that adds a noun the user will see adds or changes a `concept`. A change that adds a way to get something done changes a `flow`. A change that makes one concept affect another adds a `rule`. A change that takes a different large choice changes a `bet`, and says what the rejected alternative was. A change that adds a setting needs a reason the system cannot decide the value itself.

## Modules and the built product

A module describes the product as built. When the product owner has agreed to a design the product does not yet have, the declaration describes the agreed design and its `status:` line says what the built product does instead. Only a human product owner agrees to a design. An agent writes modules from the built product or from the owner's explicit decision, never from its own proposal; proposals stay in the conversation, the issue tracker, or the plan.

When code and a module disagree and neither is clearly right, escalate to the task requester instead of choosing. When a module blocks requested work, stop that work, describe the conflict in a few sentences, and say that resolving it needs the owner's decision. Do not turn the blockage into research or alternative designs unless asked.

## Adopting the convention

Add to the project's root `AGENTS.md`:

```md
This project uses the Product Model convention; consult the `product-model`
skill before designing, reviewing, or changing anything the user sees or does.
```

Linked Specs records may cite declarations, for example a requirement that implements `deal.Clear what waits`. Modules cite each other and nothing in the code. Code comments and tests may cite a declaration where the reference explains why the code is the way it is.
