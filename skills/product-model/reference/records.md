# Product Model records

Each record is one file in `product/`, named `<TYPE>-<slug>.md`, beginning with `# <TYPE>-<slug>: Title`. Slugs are short lowercase kebab-case. Every sentence passes the language rule: a user who has never seen the code understands it and could check it against the running product.

Links between records use the target ID as link text: `[CONCEPT-card](CONCEPT-card.md)`.

An optional `## Status` section, placed right after the heading, names where the built product differs from the record. Add it only for a change the product owner has agreed to; remove it when the product catches up.

The examples below describe one made-up product, a triage inbox for one person. They show the shape; they are not a template to fill in. Omit a section that would hold nothing.

## PRODUCT

One per product. It holds the facts about the user that decide between designs.

```md
# PRODUCT-triage: Triage

## User

One person who gets more messages, review requests, and alerts than they can read. They open Triage many times a day for a minute or two, on a laptop with a keyboard and on a phone with one thumb. They arrive mid-task with no memory of the last visit.

## Values

In order. When two values conflict, the earlier one wins.

1. **The user decides, the system prepares.** The system reads, sorts, and drafts. Only the user says done, later, or never. Test: does this change let anything act on the user's behalf without a verdict?
2. **Nothing on screen that waits for nobody.** A visit must answer where am I and what wants me at a glance. Test: does this add a row, a badge, or a button that no job needs on this visit?
3. **One way to do a thing, learned once.** A key or a gesture means the same thing on every screen. Learning time is accepted once, not per screen. Test: does this introduce a second way to do something that already has one?
4. **The system fills in what it can measure.** It asks the user only for what only the user knows. Test: does this ask the user to type or remember something the system could derive?

## Non-goals

Feature parity with the services it reads from. Settings for taste. Use by a second person.
```

## CONCEPT

One thing the user knows by name. The purpose is one sentence of benefit. The principle is a short scenario that shows the purpose being met. The rest is what the user sees and does, nothing more.

```md
# CONCEPT-card: Card

Purpose: hand the user the one thing that wants them most, so they never scan a list to find it.

## Principle

When something asks for the user, it becomes a card. Pressing `space` deals the top card. A verdict on the card puts it away and deals the next. When the deck is empty, the screen says so and nothing else wants the user.

## What the user sees

A card shows who wants them, why, and since when, with the thing itself underneath. The deck's size shows as a count beside the clock. A card from someone who has stopped waiting is dropped without a verdict.

## What the user can do

- deal (`space`): show the top card
- done (`d`): put the card away for good
- later (`s`, then a time): hide the card until the time
- never (`m`): put away this card and every later one from the same source
- undo (`u`): take back the last verdict, with the card returning as it was

## Relations

A verdict is given through the [CONCEPT-verdict](CONCEPT-verdict.md) menu. A card comes from a [CONCEPT-source](CONCEPT-source.md).
```

## JOB

One reason the user comes. The first line is the job statement in the user's situation. The flow is numbered, one user action per step, from arriving to done; the cost is the number of steps on the main path. Branches are indented under the step they leave. Examples are optional and use Given, When, Then in record vocabulary; write one for each behaviour worth checking, not one per step.

```md
# JOB-clear-what-waits: Clear what waits for me

When I have a free minute, I want to see everything that asks for me and give each a verdict, so that nothing waits on me without my knowing.

## Flow

1. Open Triage. The top card is on screen. (If the deck is empty, the screen says `nothing waits` and the job is done in one step.)
2. Read the card.
3. Give a verdict with one key: done, later, never.
   - For later, choose a time from the three offered, or type one.
4. The next card is on screen. Repeat from step 2.

Cost: 2 steps per card, plus 1 for the time when choosing later.

## The system's part

The system reads every source, decides what asks for the user, orders the cards, and drops a card whose asker has stopped waiting. The user supplies only the verdict and, for later, the time.

## Examples

Given two cards, one from a reviewer and one from an alert that has since cleared
When I open Triage
Then I see the reviewer's card, and the deck count says 1

Given a card on screen
When I press `d` and then `u`
Then the same card is on screen again, and the deck count is unchanged
```
