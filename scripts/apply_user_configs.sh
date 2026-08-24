#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.config/ryoku-backup-$STAMP"

mkdir -p "$BACKUP"

backup_dir() {
    local path="$1"
    if [ -e "$path" ]; then
        mkdir -p "$BACKUP/$(dirname "${path#$HOME/}")"
        cp -a "$path" "$BACKUP/${path#$HOME/}"
    fi
}

backup_dir "$HOME/.config/kitty"
backup_dir "$HOME/.config/nvim"
backup_dir "$HOME/.config/lazygit"
backup_dir "$HOME/.config/btop"
backup_dir "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/kitty"
cp "$SRC_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
cp "$SRC_DIR/kitty/ryoku.conf" "$HOME/.config/kitty/ryoku.conf"

mkdir -p "$HOME/.config/nvim"
cp -a "$SRC_DIR/nvim/." "$HOME/.config/nvim/"

mkdir -p "$HOME/.config/lazygit"
cp "$SRC_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

mkdir -p "$HOME/.config/btop/themes"
cp "$SRC_DIR/btop/themes/ryoku.theme" "$HOME/.config/btop/themes/ryoku.theme"

cp "$SRC_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

mkdir -p "$HOME/.config/ranger/colorschemes"
cp "$SRC_DIR/ranger/colorschemes/ryoku.py" \
   "$HOME/.config/ranger/colorschemes/ryoku.py"

echo
echo "Configs copied."
echo "Backup: $BACKUP"
echo
echo "Append manually:"
echo "  $SRC_DIR/bash/bashrc.additions -> ~/.bashrc"
echo "  $SRC_DIR/ranger/rc.conf.additions -> ~/.config/ranger/rc.conf"
echo "  $SRC_DIR/ranger/rifle.conf.additions -> ~/.config/ranger/rifle.conf"
