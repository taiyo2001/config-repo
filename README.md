# dotfiles

[reference: setup](https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081) | [Zsh Startup Benchmark](https://taiyo2001.github.io/dotfiles/)

## 構成

| ディレクトリ | 内容 |
|---|---|
| `dot_*` | chezmoi 管理の dotfiles |
| `app/` | アプリケーション別セットアップ手順 |

## セットアップ（新規マシン）

### 1. 依存ツールのインストール

```sh
brew install chezmoi 1password-cli shellcheck shfmt make gcc
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
chezmoi apply
```

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

## Format

### Fix
```sh
make format/fix
```

### Check
```sh
make format/check
```
