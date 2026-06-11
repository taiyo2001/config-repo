git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " (${ref#refs/heads/})"
}

function git() {
  if [ "$1" = "auto" ]; then
    shift
    ~/.zsh/git-taiyo2001-script.sh git_auto_update "$@"
  else
    command git "$@"
  fi
}

tgz() {
  env COPYFILE_DISABLE=1 tar zcvf "$1" --exclude=".DS_Store" "${@:2}"
}

copy() {
  if [ -f "$1" ]; then
    cat "$1" && cat "$1" | pbcopy
  else
    echo "File not found: $1"
  fi
}

fzf-select-history() {
  local cmd
  cmd=$(history -n -r 1 | awk '!seen[$0]++' | fzf --query "$LBUFFER")
  if [[ -n $cmd ]]; then
    LBUFFER=$cmd
    zle reset-prompt
    zle accept-line
  fi
}
zle -N fzf-select-history
bindkey '^R' fzf-select-history

fzf-cdr() {
  local selected_dir
  selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
  if [[ -n $selected_dir ]]; then
    LBUFFER="cd $selected_dir"
    zle reset-prompt
    zle accept-line
  fi
}
zle -N fzf-cdr
bindkey 'cdr' fzf-cdr

fzf_ghq() {
  local dir
  dir=$(ghq list --full-path | fzf)
  if [[ -n "$dir" ]]; then
    zle accept-line
    cd "$dir"
    echo "cd $dir"
  fi
}
zle -N fzf_ghq
bindkey '^g' fzf_ghq
