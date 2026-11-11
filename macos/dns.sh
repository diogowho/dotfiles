#!/usr/bin/env zsh
set -euo pipefail

if [[ "$(hostname -s)" == "violet" ]]; then
  iface="Wi-Fi"
else
  iface="Ethernet"
fi

sudo networksetup -setdnsservers "$iface" 1.1.1.2 1.0.0.2 2606:4700:4700::1112 2606:4700:4700::1002
sudo networksetup -setsearchdomains "$iface" home.arpa

sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
