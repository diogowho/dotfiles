#!/bin/sh
set -eu

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! command -v chezmoi >/dev/null 2>&1; then
  brew install chezmoi
fi

chezmoi apply

brew bundle --global install \
  --force \
  --upgrade \
  --force-cleanup \
  --zap
