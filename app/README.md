## アプリケーションごとのセットアップ項目

### アプリケーションの設定ファイルをインポート

`/app`にあるファイルをそれぞれのアプリケーションでインポート.

[reference: raycast](https://phys-edu.net/wp/?p=42570)

[reference: iTerm2](https://qiita.com/reoring/items/a0f3d6186efd11c87f1b)

> **Note:** 現在はメインターミナルとして [cmux](https://www.cmux.dev/) を使用。iTerm2 設定は参考として保持。

[reference: BetterTouchTool](https://webrandum.net/bettertouchtool-export-import/)

### tpm (Tmux Plugin Manager)

`chezmoi apply` 実行時に `run_once_install-tpm.sh` が自動でインストールします。手動操作は不要です。

> **Note:** tmux のプレフィックスキーはデフォルトの `Ctrl+b` から `Ctrl+q` に変更しています。

参考：[document](https://github.com/tmux-plugins/tpm)
