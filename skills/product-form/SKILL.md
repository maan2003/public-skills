---
name: product-form
description: "The UI design layer of the Product Model: how a product looks and moves. Use when designing, reviewing, or changing the appearance of anything the user sees in a project that adopts the Product Model: layout, type, color, spacing, parts and their states, motion, storyboards, or the design language in product/design.md. Load product-model first; this skill adds the form layer under it."
---

# Product Form

The Product Model (the `product-model` skill) holds intent: who the user is, their day, values, bets, journeys, flows, concepts, screens, rules. This skill holds form: how that intent looks and moves. Intent is UX design, form is UI design. They differ in material, method, judge, and timing, so they are two skills over one model: form hangs its files off the model's declarations and adds no second vocabulary.

Form is judged after intent. A form finding on a screen whose shape fails its heaviest flow is wasted, so a review runs the model's walk first and the critique below second, and reports in that order.

## The rule of sources

A picture in `product/` is a render of a source a machine can run: the built product, or prototype code such as an HTML frame, a SwiftUI view, or, where the product is text, a text frame. Nobody hand-draws pixels. Every image has, beside it, the source it was rendered from and the command that made it, so it can be made again. A capture that cannot be made again is not evidence and not form.

## design.md

`product/design.md` is the module of the design language. Like every module it names only what the user can see and is written in the third person. It maps to code in one place, the theme or the style module, and that mapping is code documentation, not the module.

Declarations:

- `token <group>`: the named values of the language, in four groups: `color`, `type`, `space`, `time`. A token names a meaning, not an appearance: `attention` rather than `yellow`. One line per token: the name, the value, and what it means to the user, such as `attention · yellow · what wants the user now`. A value that appears in two tokens is one token with two names, which is a cut.
- `part <Name>`: a piece of screen used on more than one screen: a row, a header, the echo line, the status line, the box, a menu, a prompt, the card's words. `purpose:` one sentence. `looks:` its layout in words, naming the tokens it uses. `states:` each state it can be in and how it looks, one line each. `used on:` the screens, by token. `form:` a text frame or a captured render of its full state.
- `motion <Name>`: something that moves or changes over time. `means:` what the change tells the user. `lasts:` a `time` token. A motion with no meaning is decoration and is a cut.
- `rule <name>`: how two parts look together, as one `when ... then ...` sentence, such as when an echo shows, then the card's words give way.

## Form on a screen

A screen in its area module keeps `shows:` as the order of what the user needs. Its `mock:` is its form where the product is text. Where the product is not text, the screen carries `form:` instead: the layout in words and tokens, and the path to the prototype source and its render. One form per device when devices differ.

## Storyboards

A storyboard is one flow as frames: one frame per step, captured from the built product, with the key or gesture between frames. It lives in `product/storyboards/<flow name>.md`, one file per flow, and the flow carries `storyboard:` with the path. Each frame names the device, the size, the date, and the command that captured it. A recording replaces frames only when timing is the behaviour under review. A frame that no longer matches the built product is a finding of the critique, and the storyboard is remade when the flow changes.

## The critique

The critique is the form review. It runs on renders, after the model's walk, over the screens the walked flows land on, in every state the screen declares, on every device. Per screen:

1. The squint test. Blur the render. What stands out must be what the heaviest flow needs first, in the order of the screen's `shows:`.
2. Hierarchy. At most three levels of emphasis on one screen, and each `color` and `type` token used for one meaning.
3. Consistency. The same part looks the same on every screen it is used on. Name each deviation with its screen.
4. Rhythm. Spacing follows the `space` tokens, lines are a readable length, and like things align.
5. States. Every declared state is rendered and reads like the product, not like a failure of it.
6. Legibility. Text meets a contrast floor on its background, and the attention colors are told apart at a glance.
7. Motion. Each motion has a meaning and a `time` token. Nothing moves for decoration.
8. Words. Every label is a word the model uses.

A finding names the screen, the state, the part, what the eye does, what it should do, and which token, part, or rule it goes against. Rank by the `runs:` of the flows on the screen. Report after the UX findings, never instead of them.

## Proposing a change

Show the form after the change, as a changed mock or a prototype render, and name the tokens and parts it uses. A change that needs a new color, size, or timing adds a token or uses one that exists. A new part is added only when no existing part fits, and it says which parts it replaces. A change to a token changes every screen that uses it, and the proposal says so.

## Capturing

Use the project's own render workflow and name it in the frame: for a web UI the browser automation the repository uses, for a native UI its headless compositor. Capture every device the user has at that device's size. Inspect each capture before it goes in; a capture nobody looked at proves nothing.
