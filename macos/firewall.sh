#!/usr/bin/env zsh
set -euo pipefail

sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf allowsignedappenabled -bool false
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true
