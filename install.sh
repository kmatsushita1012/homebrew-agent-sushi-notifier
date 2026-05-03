#!/usr/bin/env bash
set -euo pipefail

OWNER="${1:-kmatsushita1012}"
TAP_REPO_SUFFIX="agent-sushi"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install from https://brew.sh" >&2
  exit 1
fi

brew tap "${OWNER}/${TAP_REPO_SUFFIX}"
brew install --cask agent-sushi

# Unsigned local cask build workaround
if [ -d "/Applications/SushiArrived.app" ]; then
  xattr -dr com.apple.quarantine "/Applications/SushiArrived.app" 2>/dev/null || true
fi

echo "Installed agent-sushi"
echo "Next: agent-sushi activate"
