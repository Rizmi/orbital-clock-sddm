#!/usr/bin/env bash
# uninstall.sh - Removes Orbital SDDM theme
set -euo pipefail

THEME_DIR="/usr/share/sddm/themes/orbital"
CONF_FILE="/etc/sddm.conf.d/10-theme.conf"

run_root() {
  if [[ $EUID -eq 0 ]]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  elif command -v pkexec >/dev/null 2>&1; then
    pkexec "$@"
  else
    echo "Error: root privileges required, but neither sudo nor pkexec was found." >&2
    exit 1
  fi
}

echo "=== Orbital SDDM Theme Uninstall ==="

if [[ -d "$THEME_DIR" ]]; then
  echo "Removing $THEME_DIR..."
  run_root rm -rf "$THEME_DIR"
else
  echo "$THEME_DIR does not exist."
fi

if [[ -f "$CONF_FILE" ]] && grep -q 'Current=orbital' "$CONF_FILE" 2>/dev/null; then
  echo "Resetting theme in $CONF_FILE..."
  read -r -p "Remove $CONF_FILE? (y/N) " ans
  if [[ "$ans" =~ ^[Yy](es)?$ ]]; then
    run_root rm -f "$CONF_FILE"
    echo "Removed $CONF_FILE."
  fi
fi

echo "Orbital SDDM theme uninstalled."
