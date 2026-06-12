## アプリ設定のインポート

### アプリケーションの設定ファイルをインポート

`/app`にあるファイルをそれぞれのアプリケーションでインポート.

[reference: raycast](https://phys-edu.net/wp/?p=42570)

[reference: iTerm2](https://qiita.com/reoring/items/a0f3d6186efd11c87f1b)

> **Note:** 現在はメインターミナルとして [cmux](https://www.cmux.dev/) を使用。iTerm2 設定は参考として保持。

[reference: BetterTouchTool](https://webrandum.net/bettertouchtool-export-import/)

### AeroSpace + aerospace-swipe (3本指スワイプでワークスペース切替)

3本指スワイプによるワークスペース切替は [aerospace-swipe](https://github.com/taiyo2001/aerospace-swipe)（acsandmann/aerospace-swipe のフォーク）で行う。`MultitouchSupport` で生のトラックパッドタッチを読むため Homebrew では入らず、`make install` でビルドして launchd 常駐させる。`make setup/apply` 時に `run_onchange_after_install-aerospace-swipe.sh` が自動でビルド・常駐登録する。

1. ビルドは自動（`ghq get taiyo2001/aerospace-swipe` → `make install`）。フォークを更新したらスクリプト内の `revision` 行を変えると再ビルドされる
2. 初回のみ System Settings > Privacy & Security > Accessibility で **AerospaceSwipe** を有効化（ad-hoc 署名のため再ビルドのたびに再付与が必要）
