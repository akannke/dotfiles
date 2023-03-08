#!/usr/bin/bash

# ========== Snippets ==========
DIR="$HOME/dotfiles/.config/coc/ultisnips"

TARGET="$HOME/.config/coc/ultisnips"

if [[ ! -d "$TARGET" ]]; then
	mkdir "$TARGET"
fi
for i in "$DIR"/*; do
	ln -s "$i" "$TARGET" 
done
