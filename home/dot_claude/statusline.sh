#!/usr/bin/env bash
input=$(cat)

_git_dir=$(echo "$input" | jq -r '.cwd // empty')
repo=$(git -C "$_git_dir" config --get remote.origin.url 2> /dev/null |
  sed 's|.*[/:]||; s|\.git$||')
if [ -z "$repo" ]; then
  _common_dir=$(git -C "$_git_dir" rev-parse --git-common-dir 2> /dev/null)
  if [ -n "$_common_dir" ]; then
    repo=$(dirname "$_common_dir" | xargs basename 2> /dev/null)
  fi
fi
if [ -z "$repo" ]; then
  repo=$(git -C "$_git_dir" rev-parse --show-toplevel 2> /dev/null | xargs basename 2> /dev/null)
fi
[ -z "$repo" ] && repo="-"

branch=$(git -C "$(echo "$input" | jq -r '.cwd // empty')" symbolic-ref --short HEAD 2> /dev/null)
if [ -z "$branch" ]; then
  branch=$(git -C "$(echo "$input" | jq -r '.cwd // empty')" rev-parse --short HEAD 2> /dev/null)
fi
[ -z "$branch" ] && branch="-"

model=$(echo "$input" | jq -r '.model.display_name // "-"')
effort=$(echo "$input" | jq -r '.effort.level // empty')
max_tokens=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
if [ -n "$max_tokens" ] && [ "$max_tokens" -ge 1000000 ] 2> /dev/null; then
  ctx_size="[$((max_tokens / 1000000))M]"
elif [ -n "$max_tokens" ] && [ "$max_tokens" -ge 1000 ] 2> /dev/null; then
  ctx_size="[$((max_tokens / 1000))k]"
else
  ctx_size=""
fi
model_display="$model${ctx_size:+ $ctx_size}${effort:+ [$effort]}"

used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

if [ -n "$used" ] && [ -n "$remaining" ]; then
  ctx=$(printf "%.0f%% used / %.0f%% left" "$used" "$remaining")
else
  ctx="-"
fi

printf "\033[36m%s\033[0m | \033[33m%s\033[0m | \033[35m%s\033[0m | \033[32m%s\033[0m" \
  "$repo" "$branch" "$model_display" "$ctx"
