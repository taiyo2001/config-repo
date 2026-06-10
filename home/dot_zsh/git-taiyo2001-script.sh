#!/bin/zsh

source "$HOME/.zsh/colors.sh"

function git_auto_update() {
  local current_dir=$(pwd)

  if [ -d ".git" ]; then
    if [ -n "$1" ]; then
      local default_branch="$1"
    else
      default_branch=$(git remote show origin | awk '/HEAD branch/ {print $NF}')
    fi

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

if [ -n "$1" ]; then
  function_name=$1
  shift
  echo -e "\n${CYAN}[exec] $function_name $@${RESET}\n"
  $function_name $@
else
  echo -e "\n${RED}Please specify a function to run.${RESET}\n"
fi
