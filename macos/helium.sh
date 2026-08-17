#!/usr/bin/env zsh
set -euo pipefail

defaults write net.imput.helium DefaultCookiesSetting -int 4
defaults write net.imput.helium CookiesAllowedForUrls -array \
  -string '[*.]amazon.com' \
  -string '[*.]amazon.es' \
  -string '[*.]apple.com' \
  -string '[*.]bgp.tools' \
  -string '[*.]bunny.net' \
  -string '[*.]chatgpt.com' \
  -string '[*.]cloudflare.com' \
  -string '[*.]diogocastro.net' \
  -string '[*.]gandi.net' \
  -string '[*.]github.com' \
  -string '[*.]google.com' \
  -string '[*.]ifog.ch' \
  -string '[*.]instagram.com' \
  -string '[*.]lagrange.cloud' \
  -string '[*.]last.fm' \
  -string '[*.]linkedin.com' \
  -string '[*.]localhost' \
  -string '[*.]openai.com' \
  -string '[*.]peeringdb.com' \
  -string '[*.]phare.io' \
  -string '[*.]reddit.com' \
  -string '[*.]ripe.net' \
  -string '[*.]slack.com' \
  -string '[*.]steamcommunity.com' \
  -string '[*.]steampowered.com' \
  -string '[*.]twitch.tv' \
  -string '[*.]xenyth.net' \
  -string '[*.]youtube.com'
