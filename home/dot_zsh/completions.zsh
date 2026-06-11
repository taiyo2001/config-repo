autoload -Uz colors && colors
zstyle ":completion:*:commands" rehash 1
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':completion:*' recent-dirs-insert always

FPATH="$BREW_PREFIX/share/zsh/site-functions:$FPATH"
FPATH="$BREW_PREFIX/share/zsh-completions:$FPATH"

# compinit: rebuild only if .zcompdump is missing or older than 24h
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f "$_zcompdump" ]] || [[ -n $(find "$_zcompdump" -mmin +1440 2> /dev/null) ]]; then
  compinit
else
  compinit -C
fi

# kubectl completion: cache to file and refresh weekly
_kubectl_comp="${XDG_CACHE_HOME:-$HOME/.cache}/kubectl_completion.zsh"
if [[ ! -f "$_kubectl_comp" ]] || [[ -n $(find "$_kubectl_comp" -mtime +7 2> /dev/null) ]]; then
  mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"
  kubectl completion zsh > "$_kubectl_comp" 2> /dev/null
fi
source "$_kubectl_comp" 2> /dev/null

eval "$(git gtr completion zsh)"

# terraform autocomplete
autoload -U +X bashcompinit && bashcompinit
terraform_path=$(mise which terraform 2> /dev/null)
if [[ -n "$terraform_path" ]]; then
  complete -o nospace -C "$terraform_path" terraform
fi
