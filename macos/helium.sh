#!/usr/bin/env zsh
set -euo pipefail

defaults write net.imput.helium DefaultCookiesSetting -int 4
defaults write net.imput.helium CookiesAllowedForUrls -array \
  -string '[*.]ifog.ch' \
  -string '[*.]lagrange.cloud' \
  -string '[*.]amazon.com' \
  -string '[*.]apple.com' \
  -string '[*.]chatgpt.com' \
  -string '[*.]github.com' \
  -string '[*.]google.com' \
  -string '[*.]instagram.com' \
  -string '[*.]openai.com' \
  -string '[*.]reddit.com' \
  -string '[*.]slack.com' \
  -string '[*.]steamcommunity.com' \
  -string '[*.]steampowered.com' \
  -string '[*.]youtube.com' \
  -string '[*.]amazon.es' \
  -string '[*.]last.fm' \
  -string '[*.]phare.io' \
  -string 'localhost' \
  -string '[*.]bunny.net' \
  -string '[*.]diogocastro.net' \
  -string '[*.]gandi.net' \
  -string '[*.]ripe.net' \
  -string '[*.]xenyth.net' \
  -string '[*.]bgp.tools' \
  -string '[*.]twitch.tv'
