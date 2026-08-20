# Orbital SDDM Theme

A sleek, beautiful, clock-focused SDDM login theme extracted from the [Ryoku-Arch](https://github.com/neur0map/ryoku-arch) operating system.

This theme features a stunning live orbital clock and a clean, minimalist design for your display manager.

> **Note:** This theme was originally written in Qt6 for Ryoku's lockscreen. This repository contains the patched version that is fully compatible with standard Qt5 SDDM installations (which most distributions use).

## Preview
![Preview](screenshot.png)*

## Requirements
Any Linux distribution (Ubuntu, Arch, Fedora, etc.) can use this theme, as long as you use **SDDM** as your login manager. You will need the following packages installed on your system (names may vary slightly by distribution):
- `sddm`
- `qt5-declarative` (or `qtdeclarative5-dev` on Debian/Ubuntu)
- `qt5-graphicaleffects` (or `qml-module-qtgraphicaleffects` on Debian/Ubuntu)

## Installation

### Quick Installation (One-Command)
Clone the repository and run the included install script:
```bash
git clone https://github.com/Rizmi/orbital-clock-sddm.git
cd orbital-clock-sddm
sudo ./install.sh
```

### Manual Installation
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/Rizmi/orbital-clock-sddm.git
   ```
2. Copy the `orbital` folder into your system's SDDM themes directory:
   ```bash
   sudo cp -r orbital-clock-sddm/orbital /usr/share/sddm/themes/
   ```
3. Set the theme as your default in your SDDM configuration. Open your SDDM config file (usually `/etc/sddm.conf` or a file in `/etc/sddm.conf.d/`) and ensure the `[Theme]` section looks like this:
   ```ini
   [Theme]
   Current=orbital
   ```

### Arch Linux (AUR)
*(You can add AUR instructions here if you decide to package it for the AUR later!)*

## Testing the Theme
You can preview the theme without logging out by running:
```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/orbital
```

## Credits
All credit for the original design and QML code goes to the creators of the [Ryoku-Arch project](https://github.com/neur0map/ryoku-arch) and their [qylock](https://github.com/Darkkal44/qylock) lockscreen implementation.
