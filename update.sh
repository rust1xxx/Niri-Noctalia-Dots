#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
CONFIG_DIR="$HOME/.config"
FOLDERS=("kitty" "niri" "noctalia")

cd "$DOTFILES_DIR" || exit

for folder in "${FOLDERS[@]}"; do
    if [ -d "$CONFIG_DIR/$folder" ]; then
        rm -rf "$DOTFILES_DIR/$folder"
        cp -r "$CONFIG_DIR/$folder" "$DOTFILES_DIR/"
    fi
done

git add .

if ! git diff-index --quiet HEAD --; then
    git commit -m "Update configs: ${FOLDERS[*]} ($(date +'%Y-%m-%d %H:%M'))"
    git push origin main
fi
