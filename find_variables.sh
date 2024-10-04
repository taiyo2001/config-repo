#!/bin/zsh

FILE_PATH="$HOME/config-repo/utils/colors.sh"
source $FILE_PATH

TARGET_DIR=${1:-.}

is_found=true
max_file_length=0
max_line_length=0

temp_file="./grep_results_$(date +%s).tmp"
grep -nR --exclude="README.md" "\$\${\w\+}" $TARGET_DIR > $temp_file

# calc max length
while IFS=: read -r file line content; do
  if [ ${#file} -gt $max_file_length ]; then
    max_file_length=${#file}
  fi
  if [ ${#line} -gt $max_line_length ]; then
    max_line_length=${#line}
  fi
done < $temp_file

# print result
while IFS=: read -r file line match; do
  content=$(echo "$match" | grep -o "\$\${\w\+}")
  printf "file: %-*s line: %-*s  ${RED}%s${RESET}\n" \
    "$max_file_length" "$file" "$max_line_length" "$line" "$content"
  is_found=false
done < "$temp_file"

rm -f $temp_file

if [ "$is_found" = true ]; then
  echo "OK - No variables found."
else
  echo "NG - Variables found."
  exit 1
fi
