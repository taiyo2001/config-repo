#!/bin/bash
# Re-runs on `chezmoi apply` whenever this file changes.
# rev を更新すると再ビルドされる (chezmoi がこのファイルのハッシュ変化で検知)
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

if ! command -v make >/dev/null 2>&1 || ! command -v ghq >/dev/null 2>&1; then
  echo "make / ghq が無いため aerospace-swipe のインストールをスキップしました。"
  exit 0
fi

rev="ca0711a"
repo="taiyo2001/aerospace-swipe"
src="$(ghq root)/github.com/${repo}"

if [[ ! -d "$src" ]]; then
  ghq get "$repo"
fi
# レビュー済みリビジョンに固定して再現性を担保する
git -C "$src" fetch --quiet origin
git -C "$src" checkout --quiet "$rev"

# ad-hoc 署名のため再ビルドのたびに署名が変わり、launchctl load が
# 二重登録エラーになる。先に unload してから make install で登録し直す
launchctl unload "$HOME/Library/LaunchAgents/com.acsandmann.swipe.plist" 2>/dev/null || true
(cd "$src" && make install)

echo "aerospace-swipe をインストールしました。"
echo "初回は System Settings > Privacy & Security > Accessibility で AerospaceSwipe を有効化してください。"
