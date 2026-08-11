#!/usr/bin/env zsh
set -euo pipefail

sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.2 1.0.0.2 2606:4700:4700::1112 2606:4700:4700::1002
sudo networksetup -setsearchdomains Wi-Fi home.arpa

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
