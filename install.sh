#!/bin/bash
set -e

TAP="OleksandrGeronime/serp"
PACKAGE="${1:-serp-dev}"  # default: serp-dev; pass "serp" for runtime-only

abort() { echo "Error: $1" >&2; exit 1; }

[[ "$(uname)" == "Darwin" ]] || abort "This installer is for macOS only."
command -v brew >/dev/null || abort "Homebrew is not installed. Visit https://brew.sh"

echo "==> Tapping ${TAP}..."
brew tap "$TAP"

echo "==> Trusting ${TAP}..."
brew trust "$TAP"

if brew list --versions "${TAP}/${PACKAGE}" >/dev/null 2>&1; then
    echo "==> Upgrading ${PACKAGE}..."
    brew upgrade "${TAP}/${PACKAGE}"
else
    echo "==> Installing ${PACKAGE}..."
    brew install "${TAP}/${PACKAGE}"
fi

echo ""
echo "SERP installed/updated successfully."
if [[ "$PACKAGE" == "serp-dev" ]]; then
    echo "Run: serpgen --version"
fi
