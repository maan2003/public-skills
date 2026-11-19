---
name: product-model
description: Use whenever designing, reviewing, judging, or changing anything a user sees or does in a project that adopts the Product Model convention, including when reading, citing, or questioning its records (product/PRODUCT-*, CONCEPT-*, JOB-*).
user-invocable: true
---

# Product Model

The Product Model keeps what a product is, for its user, in small Markdown records written in the user's words. It sits between a project's values and its code: it says what the user can see and do, why, and what a visit costs them. Engineering knowledge, such as architecture, decisions, and contracts, belongs elsewhere, for example in Linked Specs.

The convention exists because agents reason from the richest text they can find. In most projects that is the code, so a question about a screen turns into a question about a function, and the answer comes back in the code's vocabulary. Records in the user's language give agents something at the right level to reason from, and a vocabulary that findings and proposals must be stated in.

Consulting this skill does not mean a record should be created or changed. Ordinary work that changes what the user sees reads the records; it changes one only when the product itself changed in a way the records describe.

## Records

Records live in a `product/` directory inside the directory that holds the product: the project root, or a package root when a repository ships several products. Each record is one file named `<TYPE>-<slug>.md` that begins with `# <TYPE>-<slug>: Title`. There is no index; `rg` over `product/` finds records and their references.

- `PRODUCT-<name>`, one per product: who the user is, the values with a test for each, the order in which values win, and the non-goals.
- `CONCEPT-<slug>`: one thing the user knows by name. Its purpose, how it works from the user's side, what the user sees of it, and what the user can do with it.
- `JOB-<slug>`: one reason the user comes to the product. The situation, the outcome they want, the flow step by step, and what the system does for them versus what only they can supply.

The shape of each record, with an example, is in [reference/records.md](reference/records.md).

A record qualifies only when it carries weight. A concept must be something the user names, or would need a word for. A job must be something the user comes back to do; a one-time setup is a job only when its cost matters. A value must decide between designs; a value no design would violate is a cut. There is no target length and no completeness goal. An empty type is normal.

## The language rule

A record names only what the user can see, do, or know. It names no function, type, module, table, file, crate, flag, or API. The test: a person who uses the product and has never seen its code understands every sentence and could check it against the running product. A sentence that fails the test is restated as what the user observes, or moved to code documentation.

The rule also governs how you talk about the product while this skill is loaded. State a finding or a proposal in record vocabulary first: the job, the step, what the user sees, what it costs them. Code references, if any, come after, in a separate part. A finding that cannot be stated without naming code is not yet a product finding.

## Using the model

Read the records before work that changes what the user sees or does, and in any review of such work: `PRODUCT-*` always, then the jobs the work touches and the concepts those jobs use.

### Judging a screen or a flow

1. Name the job. If no `JOB-*` covers what the user is doing on this screen, that is the first finding: either a record is missing, or the screen serves no job.
2. Walk the job as the user, in the order of the user's actions, not in the order of the screen's parts. At each step write down what the user sees, what they must know or remember, what they must type or choose, and what the system could have done instead.
3. Count the steps. One step is one user action: a key, a tap, a word typed, a choice made. The count is the cost of the job. Compare it with the flow in the `JOB-*` record.
4. Ask each value's test from `PRODUCT-*` against what you saw.
5. State each finding as the job, the step, what the user sees, what it costs them, and which value or concept it goes against. Mark each finding `observed` when you drove or saw it, `inferred` when you read code or reasoned.

Walk the empty state, the first visit, and the return after an interruption as well as the main path. A finding that would fit any product is not a finding about this one; anchor it to a step.

### Proposing a change

Show the screen after the change as text, in record vocabulary, before any code. Say which job gets cheaper and by how many steps, and which value the change serves. A change that adds a noun the user will see adds or changes a `CONCEPT-*`. A change that adds a way to get something done changes a `JOB-*` flow. A change that adds a setting needs a reason the system cannot decide the value itself.

## Records and the built product

A record describes the product as built. When the product owner has agreed to a design the product does not yet have, the record describes the agreed design and a `## Status` section, placed right after the heading, says what the built product does instead. Only a human product owner agrees to a design. An agent writes records from the built product or from the owner's explicit decision, never from its own proposal; proposals stay in the conversation, the issue tracker, or the plan.

When code and a record disagree and neither is clearly right, escalate to the task requester instead of choosing. When a record blocks requested work, stop that work, describe the conflict in a few sentences, and say that resolving it needs the owner's decision. Do not turn the blockage into research or alternative designs unless asked.

## Adopting the convention

Add to the project's root `AGENTS.md`:

```md
This project uses the Product Model convention; consult the `product-model`
skill before designing, reviewing, or changing anything the user sees or does.
```

Linked Specs records may cite product records by ID, for example a requirement that implements a job. Product records cite each other and nothing in the code. Code comments and tests may cite `JOB-*` and `CONCEPT-*` IDs where the reference explains why the code is the way it is.
