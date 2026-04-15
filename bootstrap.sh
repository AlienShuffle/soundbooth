#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install a ubuntu packages required by my environment.
if [ ! -f "$REPO_ROOT"/config/apt-packages.txt ]; then
    echo "Package list not found: $REPO_ROOT/config/apt-packages.txt"
    exit 1
fi
echo -e "\n=== updating apt packages ==="
sudo apt-get update -y
echo -e "\n=== installing/verifying required packages ==="
xargs -a "$REPO_ROOT"/config/apt-packages.txt sudo apt-get install -qq -y

echo -e "\n=== Cleaning up cruft ==="
sudo apt-get autoremove -y

# install all bash scripts in ~/bin
echo -e "\n=== Installing ~/bin scripts ==="
SRC_DIR="$REPO_ROOT/bin"
if [ -d "$SRC_DIR" ]; then
    DEST_DIR="$HOME/bin"
    mkdir -p "$DEST_DIR"
    find "$DEST_DIR" -xtype l -delete
    for src in "$SRC_DIR"/*; do
        [ -x "$src" ] || continue
        name=$(basename "$src")
        ln -sf "$src" "$DEST_DIR/$name"
    done
fi

# install dot files in home directory
echo -e "\n=== Installing ~ dot files ==="
SRC_DIR="$REPO_ROOT/dotfiles"
if [ -d "$SRC_DIR" ]; then
    DEST_DIR="$HOME"
    find "$DEST_DIR" -xtype l -print -delete
    for src in "$SRC_DIR"/.*; do
        name=$(basename "$src")
        ln -sf "$src" "$DEST_DIR/$name"
    done
fi

# git setup.
echo -e "\n=== git configuration ==="
git config --global user.email "readngtndude@gmail.com"
git config --global user.name "AlienShuffle ($USER@$(hostname))"
# probably need some login credentials process next.

echo -e "\n=== $0: completed! ==="
