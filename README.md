# config-repo

[reference: setup](https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081)

## 構成

| ディレクトリ | 内容 |
|---|---|
| `dot_*` | chezmoi 管理の dotfiles |
| `app/` | アプリケーション別セットアップ手順 |
| `dotfiles/` | レガシー設定ファイル（zsh等） |

## セットアップ（新規マシン）

### 1. 依存ツールのインストール

```sh
brew install chezmoi 1password-cli shellcheck shfmt make gcc
```

### 2. 1Password CLIにサインイン

```sh
op signin
```

> [!IMPORTANT]
> 1Password に以下のアイテムを作成しておくこと
>
> | Vault | Item名 | フィールド |
> |---|---|---|
> | Personal | `Git Config` | `email` |
> | Personal | `Git Config` | `signingkey` |

### 3. このリポジトリをホーム直下にクローン

```sh
git clone git@github.com:taiyo2001/config-repo.git ~/config-repo
```

### 4. chezmoiを適用

```sh
chezmoi apply
```

dotfiles が `~/.config/chezmoi/chezmoi.toml` の `sourceDir` 設定に従って `~/config-repo` から展開されます。

### 5. Brewfileからアプリをインストール

```sh
brew bundle --global
```

### アプリケーションごとのセットアップ

[こちら](./app/README.md)を参照

---

## dotfilesの編集フロー

```sh
# ホームのファイルを編集した後、chezmoiのソースに反映
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
