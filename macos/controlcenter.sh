#!/usr/bin/env zsh
set -euo pipefail

defaults write controlcenter BatteryShowPercentage -bool true
defaults write controlcenter Bluetooth -bool false
defaults write controlcenter Display -bool false
defaults write controlcenter FocusModes -bool false
defaults write controlcenter NowPlaying -bool false
defaults write controlcenter Sound -bool false
defaults write controlcenter AirDrop -bool false
