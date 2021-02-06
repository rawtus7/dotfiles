#!/usr/bin/env bash

set -eu

DOTPATH=$HOME/dotfiles

BRANCH="${1:-master}"
echo "Bootstrap with 'dotfiles' branch '${BRANCH}'"

if [ ! -e "$DOTPATH" ]; then
  git clone -b "$BRANCH" https://github.com/rawtus7/dotfiles.git "$DOTPATH"
else
  # echo "$DOTPATH already downloaded. Updating..."
  # cd "$DOTPATH"
  # git stash
  # git checkout "$BRANCH"
  # git pull origin "$BRANCH"
  # echo
  echo "Error: $DOTPATH already exists."
  exit 1
fi

cd "$DOTPATH"

./bootstrap/main.sh
