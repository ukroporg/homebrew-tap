#!/usr/bin/env bash
# Update Formula/ukrop.rb to the latest tag of ukroporg/ukrop on GitHub.
#
# Picks the highest semver-style tag (v<MAJOR>[.MINOR[.PATCH]]) via `sort -V`,
# computes the tarball SHA256, and rewrites the `url` and `sha256` lines.
# No-op if the formula already points at the latest tag.

set -euo pipefail

REPO="ukroporg/ukrop"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA="${SCRIPT_DIR}/../Formula/ukrop.rb"

if [[ ! -f "$FORMULA" ]]; then
  echo "error: formula not found at $FORMULA" >&2
  exit 1
fi

echo "==> Fetching tags from $REPO"
LATEST_TAG=$(
  git ls-remote --tags --refs "https://github.com/${REPO}.git" \
    | awk '{print $2}' \
    | sed 's|refs/tags/||' \
    | grep -E '^v[0-9]+(\.[0-9]+){0,2}$' \
    | sort -V \
    | tail -1
)

if [[ -z "$LATEST_TAG" ]]; then
  echo "error: no semver-style tags found for $REPO" >&2
  exit 1
fi

URL="https://github.com/${REPO}/archive/refs/tags/${LATEST_TAG}.tar.gz"

if grep -qF "\"$URL\"" "$FORMULA"; then
  echo "==> Already at $LATEST_TAG, nothing to do"
  exit 0
fi

echo "==> Latest tag: $LATEST_TAG"
echo "==> Computing SHA256 of $URL"
SHA=$(curl -fsSL "$URL" | shasum -a 256 | awk '{print $1}')

echo "==> Updating $FORMULA"
TMP=$(mktemp)
awk -v url="$URL" -v sha="$SHA" '
  /^[[:space:]]*url[[:space:]]+"/    { sub(/"[^"]*"/, "\"" url "\""); print; next }
  /^[[:space:]]*sha256[[:space:]]+"/ { sub(/"[^"]*"/, "\"" sha "\""); print; next }
  { print }
' "$FORMULA" > "$TMP"
mv "$TMP" "$FORMULA"

echo
echo "Updated to $LATEST_TAG"
echo "  url:    $URL"
echo "  sha256: $SHA"
