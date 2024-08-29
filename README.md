# config-repo

Qiitaの記事を参考に環境をセットアップ.
https://qiita.com/taiyo2001/items/2a5869f4f3b8b7aba081

## SetUp
### Install(Mac)
```
brew install shellcheck shfmt
```

### ENV
各環境別に以下の変数を変更

* ${UserName}
* ${Email}

### Dotfiles
インタラクティブに Dotfiles を $HOME ディレクトリに移動
```sh
sh setup.sh
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
