#!/bin/zsh

# exec source colors.sh script
FILE_PATH="$HOME/config-repo/utils/colors.sh"
source $FILE_PATH

# Git auto update default branch
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

# Execute the function name passed as a command-line argument
if [ -n "$1" ]; then
  function_name=$1
  shift # Remove function name from the argument list
  echo -e "\n${CYAN}[exec] $function_name $@${RESET}\n"

  $function_name $@
else
  echo -e "\n${RED}Please specify a function to run.${RESET}\n"
fi
