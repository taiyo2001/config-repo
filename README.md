# config-repo

Qiitaの記事を参考に環境をセットアップ.
https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081

## SetUp
> [!IMPORTANT]
> ホーム直下でクローンすること

### Install(Mac)
```
brew install shellcheck shfmt make gcc
```

### ENV
各環境別に以下の変数を変更

* ${UserName}
* ${Email}

### Dotfiles
<!-- インタラクティブに Dotfiles を $HOME ディレクトリに移動 -->

```sh
make setup
source $file_name
```

### 手動セットアップ項目
手動セットアップ項目は[こちらのREADME](./manual_setup/README.md)を参照


## 動作確認用のDocker環境
```
make docker/setup
make docker/zsh
```

## Format
### Fix
```
make format/fix
```

### Check
```
make format/check
```
