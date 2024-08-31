#!/bin/bash

TEMP_DIR="config-repo"
TARGET_DIR="$HOME"

# exec source colors.sh script
FILE_PATH="$HOME/$TEMP_DIR/utils/colors.sh"
source $FILE_PATH

# dotfiles/home ディレクトリ内のファイルを取得 XXX: ディレクトリは未対応
find "dotfiles/home" -type f | while read file; do
  filename=$(basename "$file")

  if [ -e "$TARGET_DIR/$filename" ]; then
    while true; do
      read -p "ファイル $filename が $TARGET_DIR に既に存在します。上書きしますか？ (y/n/v[内容を表示]): " choice < /dev/tty

      case "$choice" in
        y | Y)
          echo -e "\n${CYAN}[exec] cp $file $TARGET_DIR/$filename${RESET}\n"
          cp "$file" "$TARGET_DIR/$filename"
          break
          ;;
        n | N)
          echo "$filename をスキップしました。"
          break
          ;;
        v | V)
          echo "$filename の内容を表示します\n(exec cat "$TARGET_DIR/$filename"):\n"
          cat "$TARGET_DIR/$filename"
          echo "\n内容の表示が終了しました。再度選択してください。"
          ;;
        *)
          echo "無効な選択肢です。y, n, または v を入力してください。"
          ;;
      esac
    done
  else
    echo -e "\n${CYAN}[exec] cp $file $TARGET_DIR/$filename${RESET}\n"
    cp $file $TARGET_DIR/$filename
  fi
done

echo "ファイルが $TARGET_DIR に複製されました。\n"
