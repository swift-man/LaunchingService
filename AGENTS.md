# AGENTS.md

## Repository Guidelines

- This repository is a Swift Package for `LaunchingService`.
- Keep changes small, focused, and consistent with the existing package layout under `Sources/LaunchingService` and `Tests/LaunchingServiceTests`.
- Preserve the public API unless the task explicitly asks for a breaking change.
- Follow SOLID design principles. Prefer single-purpose types, explicit dependencies, and behavior that can be tested without Firebase network calls.

## Build, Test, and Documentation

- Run `swift build` after code changes.
- Run `swift test` for verification.
- After a successful build, verify DocC generation by running:

```bash
./GeneratingDocumentationSite
```

- Do not commit generated DocC output. `GeneratingDocumentationSite` writes the static site to `.build/docc-site/LaunchingService` and removes local `docs/` and `.doccarchive` outputs.
- The `Deploy DocC` GitHub Action publishes the generated site to `swift-man/docs` under the `LaunchingService/` directory.
- `swift-man/docs` uses the `docs.gorani.me` custom domain, so DocC static hosting base path should remain `LaunchingService`, not `docs/LaunchingService`.
- The workflow requires a `DOCS_DEPLOY_KEY` repository secret. Register the matching public key as a writable deploy key in `swift-man/docs`.

## Pull Request Review Handling

- Inspect PR review comments and review threads before finalizing a PR.
- For each review item, identify whether it is fixed, intentionally left unchanged, obsolete, or a hallucination.
- Reply to the relevant review thread when one exists.
- If there are no inline review threads, add a top-level PR comment summarizing the review state and the changes made.
- Do not mark a review item as resolved unless the code, tests, or documentation clearly support that conclusion.
