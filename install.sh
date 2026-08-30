#!/usr/bin/env bash
# install.sh - Installs Orbital SDDM (Qt6) login theme
# Usage: ./install.sh [--apply]

set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$REPO_DIR/orbital"
THEME_DIR="/usr/share/sddm/themes/orbital"
CONF_DIR="/etc/sddm.conf.d"

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

echo "=== Orbital SDDM Theme Install ==="

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Error: Could not find 'orbital' theme directory at $SOURCE_DIR" >&2
  exit 1
fi

# Check deps if pacman is available (Arch / Omarchy)
if command -v pacman >/dev/null 2>&1; then
  echo "Checking dependencies..."
  MISSING=()
  for pkg in sddm qt6-declarative qt6-5compat qt6-svg; do
    pacman -Q "$pkg" >/dev/null 2>&1 || MISSING+=("$pkg")
  done
  if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo "Installing missing: ${MISSING[*]}"
    run_root pacman -S --needed --noconfirm "${MISSING[@]}"
  else
    echo "All dependencies present."
  fi
fi

echo "Copying orbital theme to $THEME_DIR..."
run_root mkdir -p /usr/share/sddm/themes
run_root rm -rf "$THEME_DIR"
run_root cp -r "$SOURCE_DIR" "$THEME_DIR"
run_root chmod -R 755 "$THEME_DIR"

# Check if SDDM configuration should be updated
APPLY=false
if [[ "${1:-}" == "--apply" || "${1:-}" == "-a" ]]; then
  APPLY=true
elif [[ -t 0 ]]; then
  read -r -p "Set Orbital as default SDDM theme in /etc/sddm.conf.d/10-theme.conf? (y/N) " ans
  [[ "$ans" =~ ^[Yy](es)?$ ]] && APPLY=true
fi

if [[ "$APPLY" == "true" ]]; then
  run_root mkdir -p "$CONF_DIR"
  echo "Writing /etc/sddm.conf.d/10-theme.conf..."
  run_root bash -c 'cat > /etc/sddm.conf.d/10-theme.conf <<EOF
[Theme]
Current=orbital
EOF'
  echo "Orbital set as current SDDM theme."
fi

echo "Theme successfully installed to $THEME_DIR"
echo "Test preview: sddm-greeter-qt6 --test-mode --theme $THEME_DIR"
