#!/usr/bin/env bash

echo ">>>>> deploy.sh >>>>>"

DOTPATH="$HOME/dotfiles"

if [ ! -e "$DOTPATH" ]; then
  echo "Error: Directory $DOTPATH does not exist."
  exit 1
fi

cd "$DOTPATH" || exit 1

for dotfile in .??*; do
  # skip files
  [[ "$dotfile" == ".git" ]] && continue
  [[ "$dotfile" == ".gitignore" ]] && continue
  [[ "$dotfile" == ".DS_Store" ]] && continue
  [[ "$dotfile" == ".config" ]] && continue
  # Create a symbolic link
  ln -fvns "$DOTPATH/$dotfile" "$HOME/$dotfile"
done

echo "<<<<< deploy.sh <<<<<"
