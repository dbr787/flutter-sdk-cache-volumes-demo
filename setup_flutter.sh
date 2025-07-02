#!/bin/bash
set -euo pipefail

: "${FLUTTER_VERSION:?❌ FLUTTER_VERSION is not set}"

FLUTTER_ZIP_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_${FLUTTER_VERSION}-stable.zip"
FLUTTER_CACHE_DIR="simple-flutter"
FLUTTER_SDK_PATH="$PWD/$FLUTTER_CACHE_DIR/flutter"
VERSION_FILE="$FLUTTER_SDK_PATH/VERSION"
TMP_DIR="$(mktemp -d)"

export PATH="$FLUTTER_SDK_PATH/bin:$PATH"

if [ -x "$FLUTTER_SDK_PATH/bin/flutter" ] && grep -q "$FLUTTER_VERSION" "$VERSION_FILE"; then
  echo "✅ Flutter $FLUTTER_VERSION found in cache"
else
  echo "⬇️ Installing Flutter $FLUTTER_VERSION..."
  curl -sSL "$FLUTTER_ZIP_URL" -o "$TMP_DIR/flutter_sdk.zip"
  unzip -q "$TMP_DIR/flutter_sdk.zip" -d "$TMP_DIR"
  rm -rf "$FLUTTER_CACHE_DIR/flutter"
  mv "$TMP_DIR/flutter" "$FLUTTER_CACHE_DIR/"
fi

flutter --version
