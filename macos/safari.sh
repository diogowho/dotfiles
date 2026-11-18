#!/usr/bin/env zsh
set -euo pipefail

defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.Safari DownloadsClearingPolicy -int 1
defaults write com.apple.Safari EnableEnhancedPrivacyInRegularBrowsing -bool true
defaults write com.apple.Safari PreloadTopHit -bool false
defaults write com.apple.Safari PrivateSearchEngineUsesNormalSearchEngineToggle -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari SearchProviderShortName -string "DuckDuckGo"
defaults write com.apple.Safari UseHTTPSOnly -bool true
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false
defaults write com.apple.Safari ShowStandaloneTabBar -bool false
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "WebKitPreferences.developerExtrasEnabled" -bool true
defaults write com.apple.Safari DeveloperMenuVisibility -bool true
