# config-repo

Qiitaの記事を参考に環境をセットアップ.
https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081

## SetUp
### Install(Mac)
```
brew install shellcheck shfmt
```

> [!IMPORTANT]
> ホーム直下でクローンすること

sh link

### ENV
各環境別に以下の変数を変更

* ${UserName}
* ${Email}

### Dotfiles
<!-- インタラクティブに Dotfiles を $HOME ディレクトリに移動 -->
<!-- sh cp_files.sh -->

```sh
sh link_dotfiles.sh
```

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
