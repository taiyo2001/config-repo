# dotfiles

[![CI](https://github.com/taiyo2001/dotfiles/actions/workflows/push_ci.yml/badge.svg)](https://github.com/taiyo2001/dotfiles/actions/workflows/push_ci.yml)
[![managed by chezmoi](https://img.shields.io/badge/managed%20by-chezmoi-blue)](https://www.chezmoi.io/)
[![Zsh Startup Benchmark](https://img.shields.io/badge/zsh%20benchmark-view-green)](https://taiyo2001.github.io/dotfiles/)

macOS 向け dotfiles。[chezmoi](https://www.chezmoi.io/) + [1Password CLI](https://developer.1password.com/docs/cli/) で機密情報を安全に管理し、[mise](https://mise.jdx.dev/) でランタイムバージョンを統一。個人 / 仕事マシンの分岐にも対応。

> **Note:** これらの設定は自分の環境に合わせたものです。盲目的に使わず、内容を確認してから適用してください。

## 技術スタック

| カテゴリ | ツール |
|---|---|
| dotfiles 管理 | [chezmoi](https://www.chezmoi.io/) |
| シークレット管理 | [1Password CLI](https://developer.1password.com/docs/cli/) |
| バージョン管理 | [mise](https://mise.jdx.dev/) |
| パッケージ管理 | [Homebrew](https://brew.sh/) |
| シェル | zsh + [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) + [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) |
| プロンプト | [Starship](https://starship.rs/) |
| エディタ | [Neovim](https://neovim.io/) |
| ターミナルマルチプレクサ | [tmux](https://github.com/tmux/tmux) |
| Git フック | [lefthook](https://github.com/evilmartians/lefthook) |

## 構成

| ディレクトリ | 内容 |
|---|---|
| `home/` | chezmoi 管理の dotfiles（`dot_*` / `run_*`） |
| `home/dot_zsh/` | zsh モジュール（exports / aliases / functions / completions） |
| `app/` | アプリケーション別セットアップ手順 |
| `tests/` | Bats スモークテスト |

## セットアップ（新規マシン）

### 1. 依存ツールのインストール

```sh
brew install chezmoi 1password-cli shellcheck shfmt bats-core lefthook make gcc
```

### 2. 1Password CLIにサインイン

1Passwordアプリ → **設定** → **開発者** → **「1Password CLIと統合」をオン** にしてから：

```sh
eval $(op signin)
```

### 3. dotfilesリポジトリをクローン

```sh
chezmoi init taiyo2001
```

リポジトリが `~/.local/share/chezmoi/` にクローンされます（この時点ではまだ適用しません）。

### 4. 1Passwordアイテムをセットアップ

`Private` vault に `dotfiles` アイテムを作成します：

```sh
make -C ~/.local/share/chezmoi op/setup
```

以下のフィールドへの入力を求められます：

| フィールド名 | 内容 |
|---|---|
| `git config email` | git のメールアドレス |
| `git config signingkey` | git 署名キー（GPG key ID）|
| `claude code org_uuid` | Claude Code org UUID |

### 5. dotfilesを適用

```sh
make setup/apply
```

`chezmoi apply` の実行後、`lefthook install` で Git フックも自動セットアップされます。

### 6. Brewfileからアプリをインストール

```sh
brew bundle --global
```

### アプリケーションごとのセットアップ

[こちら](./app/README.md)を参照

---

## dotfilesの編集フロー

```sh
# ソースディレクトリに移動して編集
chezmoi cd

# ホームのファイルを編集した後、ソースに反映
chezmoi re-add ~/.hammerspoon/init.lua

# 差分確認
chezmoi diff

# 適用
chezmoi apply
```

---

## 動作確認用のDocker環境

```sh
make docker/setup
make docker/exec-zsh
```

## CI / 品質チェック

### ローカルで全チェックを実行

```sh
make ci/local
```

shfmt・shellcheck・テンプレート変数チェック・Bats スモークテストを一括実行します。

### pre-push フック

`git push` 時に自動で `make ci/local` と同等のチェックが実行されます（lefthook）。
初回セットアップ後に一度だけ以下を実行してください：

```sh
lefthook install
```

### フォーマット

```sh
make format/fix    # 自動修正
make format/check  # 確認のみ
```
