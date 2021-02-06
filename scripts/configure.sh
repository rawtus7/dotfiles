#!/usr/bin/env bash

set -e

echo "configure.sh >>>>>"

function condkillall() {
  local -r process="$1"
  if pgrep "^${process}$" &> /dev/null; then
    killall "${process}"
  fi
}

if ! command -v defaults &> /dev/null; then
  echo "\`defaults\` not found. Nothing to do."
  exit 0
fi

echo "Configuring..."
defaults write -g AppleLanguages '( "en-JP", "ja-JP")'
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Disable shortcuts (cuz these may conflict with alfred)
# Input Sources > Select the previous input source
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 "{ enabled = 0; }"
# Input Sources > Select next source in Input menu
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 61 "{ enabled = 0; }"
# Spotlight > Show Spotlight search
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; }"

echo "Configuring Trackpad..."
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

echo "Configuring Keyboard..."
defaults write -g com.apple.keyboard.fnState -bool true

# echo "Configuring SystemUIServer..."
# defaults write com.apple.systemuiserver menuExtras -array \
#   "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#   "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
#   "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
#   "/System/Library/CoreServices/Menu Extras/Clock.menu" \
#   "/System/Library/CoreServices/Menu Extras/AirPort.menu"
# condkillall SystemUIServer

echo "Configuring Dock..."
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock mru-spaces -bool false # Disable automatically rearrange Spaces based on most recent use
condkillall Dock

echo "Configuring Finder..."
# defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
condkillall Finder

# echo "Configuring iMovie..."
# defaults write -app iMovie allowNV -bool true

echo ""
echo "Configuration Complete!"
echo "Please restart Mac to make sure settings are reflected."

echo "<<<<< configure.sh"
