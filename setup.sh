#!/bin/bash

TEMP_DIR="config-repo"
TARGET_DIR="$HOME"

# dotfiles ディレクトリ内のファイルを取得 XXX: ディレクトリは未対応
find "dotfiles" -type f | while read file; do
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
echo "クローンを削除するには以下の実行してください。\n"
echo "$ cd .."
echo "$ rm -r "$TEMP_DIR"\n"
