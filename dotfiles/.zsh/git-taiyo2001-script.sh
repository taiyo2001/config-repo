#!/bin/zsh

# exec source colors.sh script
FILE_PATH="$HOME/config-repo/utils/colors.sh"
source $FILE_PATH

# Git auto update default branch
function git_auto_update() {
  local current_dir=$(pwd)

  if [ -d ".git" ]; then
    local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')

    local current_branch=$(git branch --show-current)
    echo -e "\n[$current_branch] ${CYAN}[exec] git checkout $default_branch${RESET}\n"
    git checkout "$default_branch"

    local current_branch=$(git branch --show-current)
    echo -e "\n[$current_branch] ${CYAN}[exec] git fetch -p${RESET}\n"
    git fetch -p

    local current_branch=$(git branch --show-current)
    echo -e "\n[$current_branch] ${CYAN}[exec] git pull${RESET}\n"
    git pull
  else
    echo -e "\n${RED}This directory is not a git repository.${RESET}\n"
  fi
}

# Execute the function name passed as a command-line argument
if [ -n "$1" ]; then
  $1
else
  echo -e "\n${RED}Please specify a function to run.${RESET}\n"
fi
