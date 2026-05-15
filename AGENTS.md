# AGENTS.md

## Repository Guidelines

- This repository is a Swift Package for `LaunchingService`.
- Keep changes small, focused, and consistent with the existing package layout under `Sources/LaunchingService` and `Tests/LaunchingServiceTests`.
- Preserve the public API unless the task explicitly asks for a breaking change.
- Follow SOLID design principles. Prefer single-purpose types, explicit dependencies, and behavior that can be tested without Firebase network calls.

## Build, Test, and Documentation

- Run `swift build` after code changes.
- Run `swift test` for verification.
- After a successful build, update the DocC static site by running:

```bash
./GeneratingDocumentationSite
```

- Commit generated DocC changes under `docs/` when the command changes the site output.

## Pull Request Review Handling

- Inspect PR review comments and review threads before finalizing a PR.
- For each review item, identify whether it is fixed, intentionally left unchanged, obsolete, or a hallucination.
- Reply to the relevant review thread when one exists.
- If there are no inline review threads, add a top-level PR comment summarizing the review state and the changes made.
- Do not mark a review item as resolved unless the code, tests, or documentation clearly support that conclusion.
