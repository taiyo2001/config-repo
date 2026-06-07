# dotfiles

[reference: setup](https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081)

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

> [!IMPORTANT]
> 1Password に以下のアイテムを作成しておくこと
>
> | Vault | Item名 | フィールド |
> |---|---|---|
> | Personal | `Git Config` | `email` |
> | Personal | `Git Config` | `signingkey` |
> | Personal | `Claude Code` | `org_uuid` |

### 3. chezmoiでセットアップ（クローン＋適用を一括）

```sh
chezmoi init --apply taiyo2001
```

リポジトリは `~/.local/share/chezmoi/` に自動でクローンされます。

### 4. Brewfileからアプリをインストール

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
