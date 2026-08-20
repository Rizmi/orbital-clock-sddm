#!/bin/bash

# Simple install script for the Orbital SDDM theme

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

THEME_DIR="/usr/share/sddm/themes/orbital"
SOURCE_DIR="$(dirname "$0")/orbital"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: Could not find the 'orbital' theme folder in the current directory."
  exit 1
fi

echo "Copying orbital theme to $THEME_DIR..."
mkdir -p /usr/share/sddm/themes/
cp -r "$SOURCE_DIR" /usr/share/sddm/themes/
chmod -R 755 "$THEME_DIR"

echo "Theme successfully installed!"
echo "To activate it, edit your SDDM configuration (usually /etc/sddm.conf or /etc/sddm.conf.d/) and set Current=orbital under the [Theme] section."
