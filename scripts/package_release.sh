#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DIST_DIR="$ROOT_DIR/dist"
BUILD_DIR="$ROOT_DIR/.build-release"
APP_PATH="$BUILD_DIR/SushiArrived.app"
PKG_DIR="$BUILD_DIR/agent-sushi"
TARBALL="$DIST_DIR/agent-sushi-${VERSION}.tar.gz"

rm -rf "$BUILD_DIR" "$DIST_DIR"
mkdir -p "$BUILD_DIR" "$DIST_DIR" "$PKG_DIR"

xcodebuild \
  -project "$ROOT_DIR/AgentSushi.xcodeproj" \
  -scheme AgentSushi \
  -configuration Release \
  -derivedDataPath "$ROOT_DIR/.DerivedDataRelease" \
  CODE_SIGNING_ALLOWED=NO \
  build

FOUND_APP=$(find "$ROOT_DIR/.DerivedDataRelease" -name "AgentSushi.app" -type d | head -n 1)
if [ -z "$FOUND_APP" ]; then
  echo "Built app not found"
  exit 1
fi

cp -R "$FOUND_APP" "$PKG_DIR/SushiArrived.app"
cp "$ROOT_DIR/bin/agent-sushi" "$PKG_DIR/agent-sushi"
chmod +x "$PKG_DIR/agent-sushi"

tar -C "$PKG_DIR" -czf "$TARBALL" .
shasum -a 256 "$TARBALL" > "$TARBALL.sha256"

echo "Created: $TARBALL"
cat "$TARBALL.sha256"
