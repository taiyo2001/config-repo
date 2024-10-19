SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# REL_DIR="${SCRIPT_DIR/#$HOME/~}"

autoload -Uz colors && colors
zstyle ":completion:*:commands" rehash 1

# Git
# Load git-prompt, git-completion
# source ~/.zsh/.git-prompt.sh
# source $SCRIPT_DIR/.zsh/.git-prompt.sh
# fpath=($SCRIPT_DIR/.zsh $fpath)
# zstyle ':completion:*:*:git:*' script ~/.zsh/.git-completion.bash
# zstyle ':completion:*:*:git:*' script $SCRIPT_DIR/.zsh/.git-completion.bash

# fpath=($fpath ~/.zsh/completion)


# Load Zsh Completions
# ================================================================
source <(kubectl completion zsh)

# Load zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    autoload -Uz compinit && compinit
fi

# Git-related settings
autoload -Uz vcs_info
precmd() {
    vcs_info
}

zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst


# Load Tools
# ================================================================
# Load asdf (a version manager)
# . /usr/local/opt/asdf/libexec/asdf.sh intel Mac
. "$HOME/.asdf/asdf.sh" # Git Install & Apple Silicon Mac

# Enable iTerm2 shell integration
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true

# Load z.sh
. `brew --prefix`/etc/profile.d/z.sh


# Changing directories
# ================================================================
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-max 500
zstyle ':completion:*' recent-dirs-insert always


# Export variables
# ================================================================
# Prompt configuration
export PS1='%F{green}%n@%m%f:%F{blue}%~%f%F{red}$(git_prompt_info)%f$ '

export SAVEHIST=100000
export BAT_CONFIG_PATH="$HOME/bat.conf"

export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border \
--preview-window 'right:50%' \
--bind 'ctrl-/:change-preview-window(80%|hidden|)' \
--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"


# Aliases
# ================================================================
alias cat='bat'
# alias ll='exa --icons --git -h -g -al --group-directories-first'
alias ll='eza -aahl --icons --git'
alias tm='tmux'
alias finder='open -a Finder ./'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias awsume=". awsume"


# Functions
# ================================================================
# function to get Git branch information
git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo " (${ref#refs/heads/})"
}

# custom git function
function git() {
    # Handle custom subcommands
    if [ "$1" = "auto" ]; then
        # ex: git auto develop

        shift # Remove 'auto' from the argument list
        $SCRIPT_DIR/.zsh/git-taiyo2001-script.sh git_auto_update "$@"
    else
        # Call the regular git command with all original arguments
        command git "$@"
    fi
}

tgz() {
    env COPYFILE_DISABLE=1 tar zcvf "$1" --exclude=".DS_Store" "${@:2}"
}

# search history with fzf
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

# seach directory with fzf
function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf)
    if [ -n "$selected_dir" ]; then
        LBUFFER="cd $selected_dir"
        zle reset-prompt
        zle accept-line
    fi
}
zle -N fzf-cdr
bindkey 'cdr' fzf-cdr

# fzf and ghq
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

# Cat and pbcopy
copy() {
  if [ -f "$1" ]; then
    cat "$1" && cat "$1" | pbcopy
  else
    echo "File not found: $1"
  fi
}
# ================================================================


eval "$(starship init zsh)"
