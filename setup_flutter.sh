#!/bin/bash
set -euo pipefail

if [[ -z "${FLUTTER_VERSION:-}" ]]; then
  echo "❌ FLUTTER_VERSION is not set"
  exit 1
fi

FLUTTER_ZIP_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_${FLUTTER_VERSION}-stable.zip"
FLUTTER_CACHE_DIR="flutter-take-four"
FLUTTER_SDK_PATH="$PWD/$FLUTTER_CACHE_DIR/flutter"
VERSION_FILE="$FLUTTER_SDK_PATH/VERSION"
TMP_DIR="$(mktemp -d)"

export PATH="$FLUTTER_SDK_PATH/bin:$PATH"

if [ -x "$FLUTTER_SDK_PATH/bin/flutter" ] && grep -q "$FLUTTER_VERSION" "$VERSION_FILE"; then
  echo "✅ Flutter $FLUTTER_VERSION is already available in cache"
else
  echo "⬇️ Installing Flutter $FLUTTER_VERSION..."

  echo "📥 Downloading..."
  start=$(date +%s)
  curl -sSL "$FLUTTER_ZIP_URL" -o "$TMP_DIR/flutter_sdk.zip"
  end=$(date +%s)
  echo "⏱ Download took $((end - start)) seconds"

  echo "📦 Unzipping..."
  start=$(date +%s)
  unzip -q "$TMP_DIR/flutter_sdk.zip" -d "$TMP_DIR"
  end=$(date +%s)
  echo "⏱ Unzip took $((end - start)) seconds"

  echo "🧹 Removing old SDK..."
  start=$(date +%s)
  rm -rf "$FLUTTER_CACHE_DIR/flutter"
  end=$(date +%s)
  echo "⏱ Remove took $((end - start)) seconds"

  echo "🚚 Moving SDK to cache directory..."
  start=$(date +%s)
  mv "$TMP_DIR/flutter" "$FLUTTER_CACHE_DIR/"
  end=$(date +%s)
  echo "⏱ Move took $((end - start)) seconds"
fi

flutter --version
