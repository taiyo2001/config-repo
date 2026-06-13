#!/bin/bash
if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

read -rp "brew-upgrade LaunchAgent を再読み込みしますか？ [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "brew-upgrade LaunchAgent の再読み込みをスキップしました。"
  exit 0
fi

PLIST="$HOME/Library/LaunchAgents/local.brew-upgrade.plist"

launchctl unload "$PLIST" 2> /dev/null || true
launchctl load "$PLIST"
echo "brew-upgrade LaunchAgent loaded."
