#!/bin/bash

set -e

TMP_DIR=$(mktemp -d)
INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
SYMLINK_DIR="$HOME/.local/bin"

trap 'rm -rf "$TMP_DIR"' EXIT

echo -e "\e[94mFetching the URL of the latest version...\e[39m"
ARCHIVE_URL=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' \
  | grep -Po '"linux":.*?[^\\]",' | awk -F ':' '{print $3,":"$4}' | sed 's/[", ]//g')
ARCHIVE_FILENAME=$(basename "$ARCHIVE_URL")

echo -e "\e[94mDownloading $ARCHIVE_FILENAME...\e[39m"
wget -q --show-progress -cO "$TMP_DIR/$ARCHIVE_FILENAME" "$ARCHIVE_URL"

echo -e "\e[94mExtracting to $INSTALL_DIR...\e[39m"
mkdir -p "$INSTALL_DIR"
rm -f "$INSTALL_DIR/jetbrains-toolbox"
tar -xzf "$TMP_DIR/$ARCHIVE_FILENAME" -C "$INSTALL_DIR" --strip-components=1
chmod +x "$INSTALL_DIR/jetbrains-toolbox"

echo -e "\e[94mSymlinking to $SYMLINK_DIR/jetbrains-toolbox...\e[39m"
mkdir -p "$SYMLINK_DIR"
rm -f "$SYMLINK_DIR/jetbrains-toolbox"
ln -s "$INSTALL_DIR/jetbrains-toolbox" "$SYMLINK_DIR/jetbrains-toolbox"

if [ -z "$CI" ]; then
  echo -e "\e[94mRunning for the first time to setup...\e[39m"
  ( "$INSTALL_DIR/jetbrains-toolbox" & )
  echo -e "\n\e[32mDone! JetBrains Toolbox should now be running, in your application list, and you can run it in terminal as jetbrains-toolbox (ensure that $SYMLINK_DIR is on your PATH)\e[39m\n"
else
  echo -e "\n\e[32mDone! Running in a CI -- skipped launching the AppImage.\e[39m\n"
fi
