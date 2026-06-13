#!/bin/bash
# Applies macOS system preferences via defaults write.
# Re-runs on `chezmoi apply` whenever this file changes.

if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

echo "Finder・Dock などの macOS システム設定を変更します。"
read -rp "適用しますか？ [y/N]: " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "macOS 設定の適用をスキップしました。"
  exit 0
fi

echo "Applying macOS defaults..."

###############################################################################
# Finder
###############################################################################
defaults write com.apple.finder AppleShowAllFiles -bool true        # show hidden files
defaults write com.apple.finder ShowPathbar -bool true              # show path bar
defaults write com.apple.finder ShowStatusBar -bool true            # show status bar
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv" # default list view
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true  # full path in title bar
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # search current folder by default
###############################################################################
# Global / Quality of life
###############################################################################
defaults write NSGlobalDomain AppleShowAllExtensions -bool true # show all file extensions

###############################################################################
# Dock
###############################################################################
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 1000000
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Mission Control / Displays
###############################################################################
defaults write com.apple.spaces spans-displays -bool false

###############################################################################
# Screenshots
###############################################################################
mkdir -p "$HOME/Desktop/screenshot"
defaults write com.apple.screencapture location -string "$HOME/Desktop/screenshot"
defaults write com.apple.screencapture disable-shadow -bool true # no drop shadow
defaults write com.apple.screencapture type -string "png"

###############################################################################
# Trackpad
###############################################################################
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true        # tap to click
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true     # natural scroll
defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true # disable Force Touch (押し込み)

###############################################################################
# Restart affected apps to apply changes
###############################################################################
killall Finder 2> /dev/null || true
killall Dock 2> /dev/null || true
killall SystemUIServer 2> /dev/null || true

echo "macOS defaults applied. Some changes may require logout or restart."
