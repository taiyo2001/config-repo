#!/bin/bash
set -euo pipefail

# 'on-window-detected if.workspace=F' only fires on window *detection*, not when
# a window is moved into F from another workspace. Re-floating every window each
# time F becomes focused covers those manually-moved windows too.
[[ "${AEROSPACE_FOCUSED_WORKSPACE:-}" == "F" ]] || exit 0

AS=/opt/homebrew/bin/aerospace
while IFS= read -r wid; do
  [[ -n "$wid" ]] || continue
  "$AS" layout floating --window-id "$wid" 2> /dev/null || true
done < <("$AS" list-windows --workspace F --format '%{window-id}')
