#!/bin/bash
# Applies macOS system preferences via defaults write.
# Re-runs on `chezmoi apply` whenever this file changes.

if [[ "$(uname)" != "Darwin" ]]; then
  exit 0
fi

echo "Applying macOS defaults..."

###############################################################################
# Finder
###############################################################################
defaults write com.apple.finder AppleShowAllFiles -bool true               # show hidden files
defaults write com.apple.finder ShowPathbar -bool true                     # show path bar
defaults write com.apple.finder ShowStatusBar -bool true                   # show status bar
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"        # default list view
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true         # full path in title bar
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"        # search current folder by default
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false # no extension change warning

###############################################################################
# Global / Quality of life
###############################################################################
defaults write NSGlobalDomain AppleShowAllExtensions -bool true             # show all file extensions
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true # expanded save dialog
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true    # expanded print dialog

###############################################################################
# Keyboard
###############################################################################
defaults write NSGlobalDomain KeyRepeat -int 2                     # key repeat rate (fast)
defaults write NSGlobalDomain InitialKeyRepeat -int 15             # initial key repeat delay (short)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # disable press-and-hold (enable key repeat)

###############################################################################
# Dock
###############################################################################
defaults write com.apple.dock autohide -bool false     # don't auto-hide
defaults write com.apple.dock show-recents -bool false # hide recent apps section

###############################################################################
# Screenshots
###############################################################################
mkdir -p ~/Desktop/screenshot
defaults write com.apple.screencapture location -string "~/Desktop/screenshot"
defaults write com.apple.screencapture disable-shadow -bool true # no drop shadow
defaults write com.apple.screencapture type -string "png"

###############################################################################
# Trackpad
###############################################################################
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true    # tap to click
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true # natural scroll

###############################################################################
# TextEdit
###############################################################################
defaults write com.apple.TextEdit RichText -bool false # open in plain text mode

###############################################################################
# Restart affected apps to apply changes
###############################################################################
killall Finder 2> /dev/null || true
killall Dock 2> /dev/null || true
killall SystemUIServer 2> /dev/null || true

echo "macOS defaults applied. Some changes may require logout or restart."
