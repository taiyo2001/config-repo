SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# REL_DIR="${SCRIPT_DIR/#$HOME/~}"

autoload -Uz colors && colors
zstyle ":completion:*:commands" rehash 1

# Git
# Load git-prompt, git-completion
# source ~/.zsh/.git-prompt.sh
source $SCRIPT_DIR/.zsh/.git-prompt.sh
fpath=($SCRIPT_DIR/.zsh $fpath)
# zstyle ':completion:*:*:git:*' script ~/.zsh/.git-completion.bash
zstyle ':completion:*:*:git:*' script $SCRIPT_DIR/.zsh/.git-completion.bash

# fpath=($fpath ~/.zsh/completion)

# Load zsh-completions
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source $(brew --prefix)/opt/zsh-git-prompt/zshrc.sh
    source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    autoload -Uz compinit && compinit
fi

# Function to get Git branch information
git_prompt_info() {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    echo " (${ref#refs/heads/})"
}

# Git-related settings
autoload -Uz vcs_info
precmd() {
    vcs_info
}

# Custom git function
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

zstyle ':vcs_info:git:*' formats '(%b)'
setopt prompt_subst

tgz() {
    env COPYFILE_DISABLE=1 tar zcvf "$1" --exclude=".DS_Store" "${@:2}"
}

# Load asdf (a version manager)
# . /usr/local/opt/asdf/libexec/asdf.sh intel Mac
. "$HOME/.asdf/asdf.sh" # Git Install & Apple Silicon Mac

# Enable iTerm2 shell integration
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true

# Prompt configuration
export PS1='%F{green}%n@%m%f:%F{blue}%~%f%F{red}$(git_prompt_info)%f$ '

# Aliases
alias cat='bat'
# alias ll='exa --icons --git -h -g -al --group-directories-first'
alias ll='eza -aahl --icons --git'
alias tm='tmux'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

eval "$(starship init zsh)"
