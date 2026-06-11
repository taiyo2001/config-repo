export SAVEHIST=100000
export BAT_CONFIG_PATH="$HOME/bat.conf"

export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border \
--preview-window 'right:50%' \
--bind 'ctrl-/:change-preview-window(80%|hidden|)' \
--bind 'ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down'"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export AWS_DEFAULT_PROFILE=terraform
