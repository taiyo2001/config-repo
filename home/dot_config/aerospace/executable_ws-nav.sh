#!/bin/bash
# Usage: ws-nav.sh next | prev

set -euo pipefail
DIR="${1:-next}"
AS=/opt/homebrew/bin/aerospace

# Anchor on the focused MONITOR and its visible workspace.
# Reason: 'workspace --focused' returns the workspace of the focused window,
# which can stay on the previous monitor if you opt+<key> into an empty WS.
MON_ID=$("$AS" list-monitors --focused --format '%{monitor-id}')
CUR=$("$AS" list-workspaces --monitor "$MON_ID" --visible --format '%{workspace}')

WS=()
while IFS= read -r line; do
  WS+=("$line")
done < <("$AS" list-workspaces --monitor "$MON_ID" --empty no --format '%{workspace}')

CNT=${#WS[@]}
[[ $CNT -eq 0 ]] && exit 0

IDX=-1
for i in "${!WS[@]}"; do
  if [[ "${WS[$i]}" == "$CUR" ]]; then
    IDX=$i
    break
  fi
done

if [[ $IDX -eq -1 ]]; then
  if [[ "$DIR" == "prev" ]]; then TARGET="${WS[$((CNT - 1))]}"; else TARGET="${WS[0]}"; fi
else
  if [[ "$DIR" == "prev" ]]; then
    NEXT=$(((IDX - 1 + CNT) % CNT))
  else
    NEXT=$(((IDX + 1) % CNT))
  fi
  TARGET="${WS[$NEXT]}"
fi

"$AS" workspace "$TARGET"
# Force focus back to our anchor monitor. macOS app activation (e.g., Chrome)
# can otherwise pull focus to a same-app window on another monitor.
"$AS" focus-monitor "$MON_ID" 2> /dev/null || true
