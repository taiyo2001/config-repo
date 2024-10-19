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
各環境別に$${xxx}の変数を変更

ex. \$${UserName}、\$${Email}, etc.

> [!TIP]
> 変数が存在するかの確認
> ```sh
> make setup/ready
> ```

## SetUp
### Dotfiles
<!-- インタラクティブに Dotfiles を $HOME ディレクトリに移動 -->

```sh
make setup/exec
source $file_name
```
ex. source .zshrc

### 手動セットアップ項目
`/app`のファイルを使用してimport.

手動セットアップ項目は[こちらのREADME](./manual_setup/README.md)を参照


## 動作確認用のDocker環境
```
make docker/setup
make docker/exec-zsh
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
