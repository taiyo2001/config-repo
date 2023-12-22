# Load asdf (a version manager)
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"


# Add Rust to the PATH
export PATH="$HOME/.asdf/installs/rust/1.71.0/bin/:$PATH"


# Prompt configuration
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '


# Aliases
alias cat='bat'
alias ll='exa --icons --git -h -g -al --group-directories-first'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
