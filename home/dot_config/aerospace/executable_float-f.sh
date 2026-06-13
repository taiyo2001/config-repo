#!/bin/bash
set -euo pipefail

# On workspace F: Dock appears on hover (delay=0).
# Elsewhere: delay set to a large value so Dock never auto-shows.
# autohide stays true always so no layout shift occurs on Dock restart.
# killall runs in background immediately on switch to maximize warm-up time.
if [[ "${AEROSPACE_FOCUSED_WORKSPACE:-}" == "F" ]]; then
  desired_delay=0
else
  desired_delay=1000000
fi
current_delay=$(defaults read com.apple.dock autohide-delay 2> /dev/null || echo "-1")
if [[ "$current_delay" != "$desired_delay" ]]; then
  defaults write com.apple.dock autohide-delay -float "$desired_delay"
  killall Dock &
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
