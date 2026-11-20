---
name: product-model-bootstrapping
description: Use when introducing the Product Model convention to an existing product and writing its first product/ directory (index.md and the modules) from the built product and its code, or when continuing a bootstrap that left areas thin.
user-invocable: true
---

# Bootstrapping the Product Model

This skill extends `product-model` with the procedure for writing a product's first `product/` directory. Load `product-model` first; it defines the modules, the declarations, the labels, the tokens, and the language rule. Bootstrapping establishes a true description of the product as built, not a complete one, and not a better one.

## Read everything, write user

Survey from every source you can reach, in this order of trust:

1. The built product, driven. Open every screen, every menu, every prompt, on every device or layout the user has. What you drove is what you know.
2. The code. Read it as closely as you need to: the keymaps, the screens, the rules that join one area to another, and the parts you could not drive. Code is a source, never a vocabulary.
3. Existing design documents and records. They say what was meant; the product says what is. Where they disagree, the product wins in the module, and the disagreement goes in the report.
4. The owner's own words about the user and the values, when given.

The language rule applies to what you write, not to what you read. A sentence written from code still names only what the user sees, does, or knows.

Survey without side effects on anything shared. Run the product with a fresh, private state directory. Send no message, start no session on a shared machine, and change nothing another person or agent can see. An area you cannot drive for that reason is read from code and listed in the report as read, not driven.

## index.md

Write the `user` declaration from what the product shows about its user and from the owner's words. Write the `day` from the owner's words only, in the owner's order; when the owner has not given it, list what the built product's jobs serve, unordered, and ask the owner for the order in the report. Put the owner's values in the skill's form, as `value` declarations, one test each, and keep their meaning; rephrase, do not reinterpret. Add a value only when the built product clearly embodies it, place it after the owner's values, and name each added value in the report so the owner can veto it. Write non-goals only for things the product visibly refuses, such as a feature it has no place for.

## Modules

Cut the product into areas as the user would name them, usually five to ten. Each area becomes one module. Write its concepts, flows, screens, and rules from what you observed, and the journeys from the owner's goals, each in the module where it starts. Apply the qualification tests from `product-model`: a concept the user names or would need a word for, a journey the user would state without naming a screen, a flow the user comes back to do on one screen, a screen the user recognises on arrival, a rule without which two concepts would disagree.

The product has things the user never named: a dot in the corner, a bar of buttons, a menu that appears at the bottom. Invent a plain name, use it consistently, and list every invented name in the report for the owner to keep or change. Prefer a name from the product's own echo or help text when it has one.

Describe the product as built, with no `status:` lines, because no design has been agreed beyond what is built. Where the product contradicts itself, or contradicts its design documents, write what it does and put the question in the report, not in the module. Where you are unsure what it does, drive it again or read the code; write nothing you did not establish.

Before you commit, search the modules for the code's vocabulary: every crate, package, module, type, and protocol name, and the project's internal words for its mechanisms. Each hit is a leak. Restate it as what the user observes. Then read every module once as the user, and cut any sentence they could not check against the product.

## Delegation

When delegation is available, give each area to one agent with the same brief, and keep `index.md`, the journeys, and the cross-module tokens with one coordinator. The coordinator reconciles names used in more than one module, the rules that join areas, and duplicated concepts. Area agents report observations and questions; they do not decide names that cross modules.

## Adoption and delivery

Add the adoption line from `product-model` to the project's root `AGENTS.md`. Commit the directory on a branch for the owner to review; do not push or merge unless asked.

Report, in this order:

- The modules, one line each: the module's declarations by kind and name.
- The coverage: which areas were driven, which were read from code only, and which were left out.
- The values you added, if any.
- The invented names.
- The open questions: every contradiction between the product and itself, its documents, or its owner's words, each in one sentence, as a question.
- The sentences where the language rule was hardest, each with the sentence you chose.
- What surprised you once the product was written in the user's words.

The owner's review resolves the questions. An answer that agrees to a change the product does not have becomes a `status:` line on the declaration; an answer that the product is right as built changes nothing. A thin area gets a second pass from code with the same rules, continuing on the same branch.
