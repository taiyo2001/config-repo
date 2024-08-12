#!/bin/bash

# REPO_URL="git@github.com:taiyo2001/config-repo.git"

TEMP_DIR="config-repo"
TARGET_DIR="$HOME"

# git clone "$REPO_URL" "$TEMP_DIR"

if [ -d "$TEMP_DIR" ]; then
  # dotfiles ディレクトリ内のファイルを取得 XXX: ディレクトリは未対応
  find "$TEMP_DIR/dotfiles" -type f | while read file; do
    filename=$(basename "$file")

    if [ -e "$TARGET_DIR/$filename" ]; then
      while true; do
        read -p "ファイル $filename が $TARGET_DIR に既に存在します。上書きしますか？ (y/n/v[内容を表示]): " choice < /dev/tty

        case "$choice" in
          y|Y )
            mv -f "$file" "$TARGET_DIR"
            echo "$filename を上書きしました。"
            break
            ;;
          n|N )
            echo "$filename をスキップしました。"
            break
            ;;
          v|V )
            echo "$filename の内容を表示します\n(exec cat "$TARGET_DIR/$filename"):\n"
            cat "$TARGET_DIR/$filename"
            echo "\n内容の表示が終了しました。再度選択してください。"
            ;;
          * )
            echo "無効な選択肢です。y, n, または v を入力してください。"
            ;;
        esac
      done
    else
      mv "$file" "$TARGET_DIR"
      echo "$filename に移動しました。"
    fi
  done

  echo "ファイルが $TARGET_DIR に移動されました。\n"
  echo "クローンを削除するには以下の実行してください。\n$ rm -r "$TEMP_DIR"\n"
else
  echo "クローンに失敗しました。\n"
fi
