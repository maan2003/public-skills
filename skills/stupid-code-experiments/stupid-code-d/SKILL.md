---
name: stupid-code-d
description: Find stupid code in one module by convening a hostile review board — operator, on-call engineer, new hire — whose complaints must then survive a judge.
---

# Stupid code detector — review board

One reader misses stupidity because each kind of stupidity hurts a different
person. So you will read the module three times as three different people,
each of whom pays a different bill, and let each file complaints. Then you
will sit as the judge and throw out every complaint that has an honest
defense. What survives is stupid code.

Run the personas separately and in order — a combined read collapses back
into one perspective. Each persona reads the whole module and files
complaints with `file:line`. No specs at any point before the verdict; the
code and common sense are the only inputs.

## Reader 1 — the operator who pays the bills

You run this in production and pay for every byte and cycle. You care about
nothing else. Complaints look like:

- Work done repeatedly that could be done once, or on demand, or never —
  polling, periodic re-fetching, recomputation of stable values.
- Every constant, read as a cost at scale: what does this interval, limit, or
  retry count cost across a fleet, and would anyone pick this number twice?
- Chatty protocols, redundant round trips, data fetched and discarded.

## Reader 2 — the on-call engineer at 3am

You get paged when this misbehaves, and you debug it with logs only.
Complaints look like:

- Errors swallowed, logged-and-continued, or flattened to strings — failures
  you cannot see or distinguish at 3am.
- Retries and timeouts that hide the actual failure instead of surfacing it.
- State with no invalidation story: caches, flags, duplicated truths that go
  stale silently and produce unexplainable behavior.
- Inconsistent failure policy — the same class of error panics here and is
  ignored there, so you cannot predict what the system does when it breaks.

## Reader 3 — the new hire reading cold

You joined yesterday, you're smart, and you have to modify this module next
week. Complaints look like:

- Abstractions you must understand that buy nothing: traits with one
  implementor, config nobody sets, generality with one caller.
- Mechanisms hand-rolled beside a dependency or sibling module that already
  provides them.
- Layered patches whose accumulated shape no one would ever design — code
  where you can see each author fixing the symptom in front of them.
- Anything where you'd have to find the original author to learn *why* — and
  suspect there is no why.

## The judge

Consolidate the three complaint lists, merge duplicates, then try to **acquit
every complaint**: construct the strongest defense of the code as written,
appealing only to the problem — a real constraint, a real tradeoff, a real
cost of the alternative. "The spec says so", "a comment explains it", "tests
cover it" are inadmissible; that is provenance, not merit.

Convict only where both hold: an obviously better alternative exists at
similar or lower effort, and the gap has real cost. Bugs are out of this
court's jurisdiction; so are style and taste — dismiss such complaints
without prejudice. Costless suboptimality is acquitted.

## Verdict

Report the convictions, ranked by cost, hard cap 5. "All complaints
acquitted" is a valid, complete outcome — do not convict to seem useful.

Each conviction:

- **Where**: `file:line`
- **Complaint**: one sentence, and which reader(s) filed it
- **Failed defense**: the best defense you attempted, in one line
- **The sensible version**: what a competent engineer would do instead
- **Real cost**: concretely
- **Level**: *code* (mechanism) or *policy* (the decision itself, however
  well implemented). Specs may be opened only now, solely to classify: a
  spec mandating the behavior makes it policy — it never acquits.
