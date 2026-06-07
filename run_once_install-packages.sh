#!/bin/bash
set -e

# Homebrew がなければインストール
if ! command -v brew &> /dev/null; then
  read -rp "Homebrew がインストールされていません。インストールしますか？ [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "Homebrew をインストールしています..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Apple Silicon の場合はパスを通す
    if [[ "$(uname -m)" == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  else
    echo "Homebrew のインストールをスキップしました。"
    exit 0
  fi
fi

echo ""
echo "以下の Brewfile からパッケージをインストールします: ~/.Brewfile"
echo ""
brew bundle list --global
echo ""
read -rp "インストールを実行しますか？ [y/N]: " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  brew bundle --global
  echo "インストールが完了しました。"
else
  echo "インストールをスキップしました。"
fi
