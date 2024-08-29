#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# REL_DIR="${SCRIPT_DIR/#$HOME/~}"
FILES=(.zshrc .bashrc)

for FILE in "${FILES[@]}"; do
    GIT_RC="$SCRIPT_DIR/dotfiles/$FILE"
    HOME_RC="$HOME/$FILE"

    echo -e "\n# Load aliases from $GIT_RC" >> "$HOME_RC"
    echo "source $GIT_RC" >> "$HOME_RC"

    echo "Added 'source $GIT_RC' to $HOME_RC."
done
