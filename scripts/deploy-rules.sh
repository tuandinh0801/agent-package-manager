#!/bin/bash
# Deploy hookify security rules to Claude Code config directory
# Usage:
#   apm run deploy-rules              # project-level (.claude/)
#   apm run deploy-rules --global     # global (~/.claude/)

set -e
RULES_DIR="$(cd "$(dirname "$0")/../rules" && pwd)"

if [ "$1" = "--global" ] || [ "$1" = "-g" ]; then
  TARGET_DIR="$HOME/.claude"
else
  TARGET_DIR=".claude"
fi

mkdir -p "$TARGET_DIR"

count=0
for rule in "$RULES_DIR"/hookify.*.local.md; do
  [ -f "$rule" ] || continue
  cp "$rule" "$TARGET_DIR/$(basename "$rule")"
  count=$((count + 1))
done

echo "[+] Deployed $count hookify security rules to $TARGET_DIR/"
