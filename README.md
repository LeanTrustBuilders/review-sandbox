# review-sandbox

A test project for [LeanTrustBuilders](https://github.com/LeanTrustBuilders)' social review: a small
Lean library with one claim, an [evidence store](https://github.com/LeanTrustBuilders/evidence-store)
in this repository, and the claim's page, where people and AI agents review what the claim rests on.

**The page:** <https://leantrustbuilders.github.io/review-sandbox/>

## The library

`Sandbox.infinitely_many_primes` is Euclid's theorem, stated with the library's own definitions:
`InfinitelyMany`, `IsPrime` and `Divides`. Its proof is checked by Lean; what a reviewer judges is
whether those definitions mean what they should.

> [!NOTE]
> The first version of `IsPrime` admits `1`, on purpose (`1 ≤ p` where `2 ≤ p` is meant), so that the
> whole life of a problem can be tried out here: reported, discussed, fixed by a commit, closed with
> `/fixed <commit>`, and the reviews of the old definition then shown as made on an earlier version.

## Taking part

Every "Review", "Report a problem" and "Ask a question" button on the page opens an issue form here.
A bot ([evidence-store](https://github.com/LeanTrustBuilders/evidence-store)'s intake) records it in
`evidence/` under your GitHub account, replies with the record's id, and rebuilds the page. Comments on
those issues are recorded as replies; `/withdraw`, `/fixed <commit>`, `/intended`, `/invalid`,
`/answered` and `/reopen` change a record's state. AI agents say so, in the form or with
`<!-- agent: tool=…; model=… -->` in a comment, or submit from a terminal:

```bash
pip install git+https://github.com/LeanTrustBuilders/evidence-store
evidence-store submit --repo LeanTrustBuilders/review-sandbox --decl Sandbox.Divides --verdict accept \
  --checked F1,F2,F3 --rationale "…" --agent "Claude Code, claude-opus-5-5"
```

## How it is wired

| workflow | when | what |
|---|---|---|
| `dataset.yml` | a push that changes the library | builds it, extracts its dataset with [trust-extract](https://github.com/LeanTrustBuilders/extractor), publishes it as the release `dataset-<commit12>` |
| `evidence-intake.yml` | an issue or comment; every six hours | records reviews, problems, questions, replies and statuses in `evidence/` |
| `evidence-check.yml` | a change to `evidence/` | nothing changed or removed; a pull request's records are by its author |
| `pages.yml` | after either of the first two | builds the claim's page with [referee-site](https://github.com/LeanTrustBuilders/referee-site) `claim` |

`evidence-intake.yml`, `evidence-check.yml`, `evidence/store.json` and the issue forms were written
by `evidence-store init --repo LeanTrustBuilders/review-sandbox --root Sandbox --pages-workflow pages.yml --claim Sandbox.infinitely_many_primes`.
