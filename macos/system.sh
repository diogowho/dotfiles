#!/usr/bin/env zsh
set -euo pipefail

defaults write NSGlobalDomain NSQuitAlwaysKeepsWindow -bool false
defaults write NSGlobalDomain AppleIconAppearanceTheme -string "RegularAutomatic"
defaults write com.apple.ActivityMonitor UpdatePeriod -int 2
defaults write com.apple.AdLib allowApplePersonalizedAdvertising -bool false
defaults write com.apple.Spotlight EnabledPreferenceRules -array "com.apple.tips" "System.files" "System.folders" "Custom.relatedContents"
defaults write com.apple.Spotlight PasteboardHistoryEnabled -bool true
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool true
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool true
defaults write WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.spaces spans-displays -bool true
defaults write screensaver askForPassword -bool true
defaults write screensaver askForPasswordDelay -int 0
defaults write screencapture target -string "clipboard"
defaults write screencapture type -string "png"
defaults write loginwindow GuestEnabled -bool false
defaults write loginwindow SHOWFULLNAME -bool false
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false
