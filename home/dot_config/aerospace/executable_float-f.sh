#!/bin/bash
set -euo pipefail

# Toggle Dock visibility: show on workspace F, hide elsewhere.
# Only restart Dock when the autohide state actually needs to change.
if [[ "${AEROSPACE_FOCUSED_WORKSPACE:-}" == "F" ]]; then
  desired_autohide=false
else
  desired_autohide=true
fi
current_autohide=$(defaults read com.apple.dock autohide 2> /dev/null || echo "0")
[[ "$current_autohide" == "1" ]] && current_autohide=true || current_autohide=false
if [[ "$current_autohide" != "$desired_autohide" ]]; then
  defaults write com.apple.dock autohide -bool "$desired_autohide"
  killall Dock
fi

# 'on-window-detected if.workspace=F' only fires on window *detection*, not when
# a window is moved into F from another workspace. Re-floating every window each
# time F becomes focused covers those manually-moved windows too.
[[ "${AEROSPACE_FOCUSED_WORKSPACE:-}" == "F" ]] || exit 0

AS=/opt/homebrew/bin/aerospace
while IFS= read -r wid; do
  [[ -n "$wid" ]] || continue
  "$AS" layout floating --window-id "$wid" 2> /dev/null || true
done < <("$AS" list-windows --workspace F --format '%{window-id}')
