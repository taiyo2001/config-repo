#!/bin/zsh

# clor code
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
RESET="\e[0m"

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
