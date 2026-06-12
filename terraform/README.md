## インフラ管理

### セットアップ

#### 1. HCP Terraform API トークンを取得

`https://app.terraform.io/app/settings/tokens` にアクセスし、**Create an API token**でトークンを生成します。

#### 2. GitHub App を作成

`https://github.com/settings/apps/new` にアクセスし以下を設定します：

- GitHub App name: `terraform-dotfiles`
- Webhook: **Active のチェックを外す**
- Permissions → Repository → **Administration: Read & Write**

**Create GitHub App** 後、以下の値を取得します：

- **App ID**: 設定ページ上部に表示される数字
- **Private key**: ページ下部 **Generate a private key** → PEM ファイルをダウンロード
- **Installation ID**: **Install App** → `taiyo2001/dotfiles` のみ選択後、`https://github.com/settings/installations` でアプリをクリックした際の URL 末尾の数字

#### 3. 1Password アイテムに保存

```sh
op item edit dotfiles \
  --vault Private \
  "TF_TOKEN_app_terraform_io[password]=<HCP Terraform API トークン>" \
  "GITHUB_APP_ID[text]=<App ID>" \
  "GITHUB_APP_INSTALLATION_ID[text]=<Installation ID>" \
  "GITHUB_APP_PEM_FILE[concealed]=<PEM ファイルの中身をそのままペースト>"
```

### 操作

```sh
make tf/init   # 初回のみ
make tf/plan   # 差分確認
make tf/apply  # 適用
```
