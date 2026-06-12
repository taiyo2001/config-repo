## インフラ管理

### 前提条件

1Password の `Private/dotfiles` アイテムに以下のフィールドを追加してください：

| フィールド名 | 内容 |
|---|---|
| `TF_TOKEN_app_terraform_io` | HCP Terraform API トークン（無期限） |
| `GITHUB_APP_ID` | GitHub App ID |
| `GITHUB_APP_INSTALLATION_ID` | GitHub App Installation ID |
| `GITHUB_APP_PEM_FILE` | GitHub App 秘密鍵（PEM 形式） |

### 操作

```sh
make tf/init   # 初回のみ
make tf/plan   # 差分確認
make tf/apply  # 適用
```
