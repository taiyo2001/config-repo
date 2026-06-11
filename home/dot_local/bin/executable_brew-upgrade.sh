#!/bin/bash
set -e

BREW="/opt/homebrew/bin/brew"
NOTIFIER="/opt/homebrew/bin/terminal-notifier"
LOG="$HOME/Library/Logs/brew-upgrade.log"

mkdir -p "$HOME/Library/Logs"
exec >> "$LOG" 2>&1
echo "=== $(date '+%Y-%m-%d %H:%M:%S') ==="

"$BREW" update

count=$("$BREW" outdated --formula | wc -l | tr -d ' ')
"$BREW" upgrade

sheldon lock --update 2>> "$LOG"

if [[ "$count" -gt 0 ]]; then
  "$NOTIFIER" -title "Homebrew" -message "${count} 個のパッケージを更新しました" -sound default
else
  "$NOTIFIER" -title "Homebrew" -message "すべて最新です" -sound default
fi
