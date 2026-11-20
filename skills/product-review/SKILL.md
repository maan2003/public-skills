---
name: product-review
description: "The review tool of the Product Model: judges a product by comparison, part by part, against the product that does each part's job best, and by doing its flows with hands. Use when asked to review, judge, critique, or audit a product, a screen, a part, or a design change in a project that adopts the Product Model, before a design lands or after it is built. Load product-model and product-form first; this skill adds the review method over them."
---

# Product Review

A model states its parts as facts. A reader of the model sees the facts and not what they cost, and a reader of the pictures sees a whole that looks like what the claim says. So a review of the model alone passes the parts that most betray the claim. This skill makes the reviewer do two things a reader does not: put each part beside the product that does its job best, and do the flows with hands, in the product and in the reference, and count.

The reviewer judges by comparison, never from taste. A finding is a difference between the product and its reference that no bet names on purpose, with a cost per visit and the runs it lands on. The reviewer is not the author of the model.

## Evidence

The model under `product/`, `index.md` first, then every module and `design.md`; the captures and storyboards the model points at, looked at one by one; and the references, run for real. Source code is not evidence: the review judges what the record claims and what the renders show. The built product is opened only when the model marks a flow built and no storyboard exists for it. Nothing in `product/` changes during a review.

## The method, in order

### 1. The claim

From `index.md`, write in one line what the product says it is and what it says it is not. Every later step holds a part to this line, not the product as a whole: a whole can look like its claim while its parts belong to another kind of product.

### 2. References, per part

A reference is the product that does one part's job best, not the product that is most like the whole. Take every `part` in `design.md` and every `shows:` line of every screen, singly or as a set of parts that work together (a list and its filter, a body and the place one writes into it, a prompt and its answers). For each:

- Name the job in one line, without naming the part.
- Name the product of the claimed kind that does that job best. When no product of the claimed kind does the job, name the best product of any kind and say so; the claim then asks how that job would look done in the claimed kind.
- Get a picture of the reference in the same state, as an image, never as a text dump: run it (native programs in the project's headless compositor, terminal programs in a terminal inside that compositor, web products in the browser automation the project uses) and take a screenshot, or fetch a screenshot when the reference cannot be run. The rule of sources from `product-form` applies to references too. Save it under the review's own directory, named by the part, never under `product/`.
- The best product for a job is often not a terminal program. A reviewer who only runs what the shell can run has picked references by convenience, and says so if it cannot be helped.

The list of parts and their references goes in the report, so the next review starts from it and a reference changes only with a reason.

### 3. Side by side

For every part, with the product's capture and the reference's picture both in view, record the same facts of each: where the text lives; what is drawn around it; the modes available there; the keys; what the cursor and a selection can do there; how one enters and leaves; what undo covers. Every difference from the reference is a finding unless a `bet` or `rule` in the model names that difference on purpose, and then the record cites the bet. A part not compared is a miss and is listed as one.

### 4. The flows, with hands

Take every flow with `runs:` of ten a day or more, most runs first. Do each in the product in your head, with only the keys, gestures, and modes the model gives, and do the same job in its reference for real. Count keys. Name the mode at each step. Say what escape and undo do at each step, in both. Every job where the user writes gets the full treatment: write several lines, go back and change something in the middle, then finish. Each gap between product and reference is a cost per visit, multiplied by `runs:`.

### 5. Borrowed genre

List every part and every word in the model and the captures that belongs to another kind of product than the claimed one: inputs, placeholders, buttons, toolbars, badges, counters, toasts, tabs, or whatever the claimed kind does without. For each, say what the claimed kind has there instead.

### 6. The values, per part

Ask each value's `test:` question from `index.md` of each part in `design.md`, one part at a time, and record each no. A product passes its values as a whole long after its parts have failed them.

### 7. Shape, then surface

Run the walk from `product-model` over the flows of step 4, and the critique from `product-form` over the screens they land on. Findings from those steps rank with the rest.

## The report

In this order:

1. The single worst thing, in three sentences, with the reference comparison that shows it and why a reader of the model alone would not see it.
2. The ten worst problems, ranked by `runs:` of the flow times the cost per visit. Each names: the part or screen; the flow; the reference and its capture path; what the product does instead; what it costs; what it should be; the value, bet, token, or rule it goes against.
3. The parts compared, each with its reference and capture path, and the parts not compared, with why.
4. Three things the product does better than its references.

A report that names no part, or ranks by surprise instead of runs times cost, is not a review.

## Reviewing a change

A change is reviewed the same way, over the parts and flows it touches, with the form before and after both in view, and the reference beside them. A change that moves a part closer to its reference needs no bet; a change that moves it away needs one, written in the model in the same change.
