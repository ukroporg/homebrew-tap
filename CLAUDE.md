# Homebrew Tap for ukroporg projects

## Project Structure

- `Formula/` — Homebrew formula files (Ruby, `.rb`)
- Each formula corresponds to a project at https://github.com/ukroporg/

## Conventions

- Formula files use 2-space indentation (Ruby standard)
- Follow Homebrew formula best practices: https://docs.brew.sh/Formula-Cookbook
- When adding a new formula, compute SHA256 from the release tarball
- Use `license` field matching the upstream project's license (default to MIT if none specified)

## Adding a New Formula

1. Find the latest tag/release of the upstream project
2. Download the tarball and compute SHA256: `curl -sL <url> | shasum -a 256`
3. Create `Formula/<name>.rb` following existing formulas as reference
4. Update `README.md` with the new formula
