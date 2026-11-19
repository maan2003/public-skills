---
name: product-model
description: Use whenever designing, reviewing, judging, or changing anything a user sees or does in a project that adopts the Product Model convention, including when reading, citing, or questioning its modules (product/*.md with concept, job, screen, and rule declarations).
user-invocable: true
---

# Product Model

The Product Model describes a product the way its user experiences it, in Markdown modules written in the user's words. It sits between a project's values and its code: it says what the user can see and do, why, and what a visit costs them. Engineering knowledge, such as architecture, decisions, and contracts, belongs elsewhere, for example in Linked Specs.

The convention exists because agents reason from the richest text they can find. In most projects that is the code, so a question about a screen turns into a question about a function, and the answer comes back in the code's vocabulary. Modules in the user's language give agents something at the right level to reason from, and a vocabulary that findings and proposals must be stated in.

Consulting this skill does not mean a module should be created or changed. Ordinary work that changes what the user sees reads the modules; it changes one only when the product itself changed in a way the modules describe.

## Modules

The model lives in a `product/` directory inside the directory that holds the product: the project root, or a package root when a repository ships several products. `product/product.md` describes the user and the values. Every other file is a module: one area of the product, named as the user would name it, such as `deal.md`, `chat.md`, or `notes.md`. A module holds the concepts, jobs, screens, and rules of its area together, so a reader opens one file to understand one area. There is no index; `rg '^## (concept|job|screen|rule) '` lists every declaration.

A module starts with `# <module>` and a sentence or two on what the area is for. After that, each `##` heading is a declaration: `## concept Card`, `## job Clear what waits`, `## screen Home`, `## rule <short name>`. A declaration's body is labeled lines, `label: text`, and lists under a label. Lines not covered by a label are prose and are allowed anywhere.

Declarations and their labels:

- `concept <Name>`: one thing the user knows by name. `purpose:` one sentence of benefit to the user. `principle:` a short scenario that shows the purpose being met. `sees:` what the user can see of it, in priority order: the first items are what a list row shows, the rest need the thing open. `has:` the concepts nested in it, one per line, each marked `one` or `many`, optional. `does:` a list of actions, one per line, as `<action> <key or gesture>: what happens`; the key is optional.
- `job <Title>`: one reason the user comes. `when:` the situation. `want:` what they want to do. `so that:` the outcome. `flow:` a numbered list, one user action per step, from arriving to done; branches as indented lists under the step they leave. `system:` what the system does without being asked. `user:` what only the user supplies. `cases:` situations worth walking beyond the defaults, optional.
- `screen <Name>`: what the user sees at once. `shows:` the concepts on it. `starts:` the jobs that begin there.
- `rule <name>`: how two or more concepts act together, in one `when ... then ...` sentence. A rule is where one action in one concept has an effect in another.

Any declaration may carry `status:` right after its heading: what the built product does instead, when the product owner has agreed to a design that is not built yet.

A reference to a declaration or an action is a backtick token: `` `Card` `` inside its own module, `` `deal.Card` `` from another module, `` `Card.done` `` for an action. Tokens are the only way to name another declaration; prose that mentions a concept uses its token.

### Example

```md
# deal

The deal hands the user the one thing that wants them most.

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

## job Clear what waits
when: I have a free minute
want: see everything that asks for me and answer each
so that: nothing waits on me without my knowing
flow:
1. open the product; the top `Card` is on screen
2. read the card
3. `Card.done`, or `Card.later` and a time, or `Card.never`
4. the next card is on screen; repeat from 2
system: reads every source, orders the cards, drops a card whose asker has stopped waiting.
user: the verdict, and the time for later.
cases: the deck holds one card from an asker who has left

## screen Home
shows: `Card`, `chat.Room`
starts: `Clear what waits`, `chat.Go to a room`

## rule done settles the thread
when `Card.done` on a card that came from a `chat.Thread`, then that thread counts as `chat.Thread.settled`.
```

### What qualifies

A concept must be something the user names, or would need a word for. A job must be something the user comes back to do; a one-time setup is a job only when its cost matters. A screen is a place the user recognises on arrival, not every state of one. A rule earns its place when forgetting it would make two concepts disagree. There is no target length and no completeness goal; a module with one concept and one job is normal.

## product.md

One file per product, with three sections.

- `## User`: who they are, their situation, the devices, how often and for how long they visit, and what they remember between visits.
- `## Values`: a numbered list. Each value is a bold name, one or two sentences in the user's situation, and `Test:` a question to ask of a change, answerable yes or no. When two values conflict, the earlier one wins.
- `## Non-goals`: things a reasonable designer would add and this product does not want.

A value must decide between designs; a value no design would violate is a cut.

## The language rule

A module names only what the user can see, do, or know. It names no function, type, module of code, table, file, crate, flag, or API. The test: a person who uses the product and has never seen its code understands every sentence and could check it against the running product. A sentence that fails the test is restated as what the user observes, or moved to code documentation.

The rule also governs how you talk about the product while this skill is loaded. State a finding or a proposal in the model's vocabulary first: the job, the step, what the user sees, what it costs them. Code references, if any, come after, in a separate part. A finding that cannot be stated without naming code is not yet a product finding.

## Using the model

Read `product.md` before work that changes what the user sees or does, and in any review of such work. Then read the modules of the areas the work touches.

### The walk

The walk judges a screen or a flow by running a job's flow against the built product, as the user. It is a cognitive walkthrough: at each step, does the user know what to do, do they see how, and do they understand what happened.

1. Name the job. If no `job` covers what the user is doing on this screen, that is the first finding: either a declaration is missing, or the screen serves no job.
2. Choose the situation. Walk each job in four situations unless the job says otherwise: first visit, routine return, return after an interruption, and the empty case. Walk each on every device the user has. Add the job's `cases:`.
3. Walk the flow in the order of the user's actions, not in the order of the screen's parts. Fill one row per step:

```
job Clear what waits · situation: return after interruption, phone
step | sees                   | must know or recall  | does  | then               | system could
1    | Home, 30 rows, no card | that space deals     | space | top card shows     | deal on open
2    | card text, no asker    | who asks, since when | read  |                    | show asker and age
3    | verdict menu           | d means done         | d     | row stays, no echo | drop row, echo done
```

4. Mark each row `observed` when you drove or saw it, `inferred` when you read code or reasoned.
5. Read the findings off the table. A finding is a row where the user must recall what the screen could show, where `then` is empty or unclear, where `system could` is not empty, or where the step count exceeds the flow in the module.
6. Ask each value's test from `product.md` against what you saw.
7. State each finding as the job, the step, what the user sees, what it costs them, and which value, concept, or rule it goes against. Rank findings by how often the job runs times what the step costs.

A finding that would fit any product is not a finding about this one; anchor it to a step. Findings are review output: they go in the conversation or the issue, not in a module.

### Proposing a change

Show the screen after the change as text, in the model's vocabulary, before any code. Say which job gets cheaper and by how many steps, and which value the change serves. A change that adds a noun the user will see adds or changes a `concept`. A change that adds a way to get something done changes a `job` flow. A change that makes one concept affect another adds a `rule`. A change that adds a setting needs a reason the system cannot decide the value itself.

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
