#!/bin/bash
set -e

TPM_DIR="$HOME/.tmux/plugins/tpm"

if [[ ! -d "$TPM_DIR" ]]; then
  echo "tpm をインストールしています..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "tpm プラグインをインストールしています..."
"$TPM_DIR/bin/install_plugins"
echo "tpm プラグインのインストールが完了しました。"
