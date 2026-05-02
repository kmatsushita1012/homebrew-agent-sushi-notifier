#!/usr/bin/env bash
set -euo pipefail

OWNER="${1:-kmatsushita1012}"
TAP_REPO_SUFFIX="agent-sushi-notifier"

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install from https://brew.sh" >&2
  exit 1
fi

brew tap "${OWNER}/${TAP_REPO_SUFFIX}"
brew install --cask agent-sushi

echo "Installed agent-sushi"
echo "Next: agent-sushi activate"
