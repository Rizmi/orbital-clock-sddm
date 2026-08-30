# Orbital SDDM Theme

A sleek, clock-focused **SDDM login screen theme** extracted from [Ryoku-Arch](https://github.com/neur0map/ryoku-arch) (`clockwork/orbital` QML) — featuring live dual orbital rings and windup unlock animation. Written in **Qt6**.

For the in-session **lockscreen** (`Super+L` and idle timeout), see [`orbital-clock-lockscreen`](../orbital-clock-lockscreen).

![Preview](preview.gif)

> **Tested on:** `Omarchy 4.0.1` / `SDDM 0.21.0` (Qt6) / `Qt 6.11.2` / `Arch Linux`

---

## Compatibility & Requirements

| Environment | Supported? | Setup / Notes |
| :--- | :---: | :--- |
| **Arch Linux / Omarchy / EndeavourOS** | ✅ | Native SDDM Qt6 package |
| **Fedora 40+ / openSUSE Tumbleweed** | ✅ | Fully supported on Qt6 build of SDDM |
| **Debian 13+ / Ubuntu 24.10+** | ✅ | Supported when using `sddm` with Qt6 greeter |
| **Legacy SDDM (Qt5 builds)** | ❌ | Requires modern Qt6 build of SDDM |
| **GDM / LightDM / Ly** | ❌ | SDDM only |

### Package Requirements (Arch / Omarchy)
- `sddm`
- `qt6-declarative`
- `qt6-5compat`
- `qt6-svg`

Check dependencies:
```bash
pacman -Q sddm qt6-declarative qt6-5compat qt6-svg 2>&1
```

---

## Quick Install

### Automated Install
```bash
git clone https://github.com/Rizmi/orbital-clock-sddm.git
cd orbital-clock-sddm
chmod +x install.sh
./install.sh --apply
```

What `install.sh` does:
1. Verifies that `sddm`, `qt6-declarative`, `qt6-5compat`, and `qt6-svg` are installed.
2. Copies `orbital` to `/usr/share/sddm/themes/orbital` with permissions `755`.
3. Sets `Current=orbital` under `[Theme]` in `/etc/sddm.conf.d/10-theme.conf` (when passed `--apply` or confirmed interactively).

### Manual Installation
```bash
# 1. Install dependencies
sudo pacman -S sddm qt6-declarative qt6-5compat qt6-svg

# 2. Copy theme
sudo mkdir -p /usr/share/sddm/themes
sudo cp -r orbital /usr/share/sddm/themes/
sudo chmod -R 755 /usr/share/sddm/themes/orbital

# 3. Set as default theme
sudo mkdir -p /etc/sddm.conf.d
sudo bash -c 'cat > /etc/sddm.conf.d/10-theme.conf <<EOF
[Theme]
Current=orbital
EOF'
```

---

## Testing the Theme

You can test and preview the theme in a window without logging out:

```bash
# Test installed theme:
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/orbital

# Or test directly from this repository:
sddm-greeter-qt6 --test-mode --theme ./orbital
```

---

## Autologin Note (Omarchy / Encrypted Systems)

If your system uses **autologin** (e.g. Omarchy with `/etc/sddm.conf.d/autologin.conf`), SDDM is skipped at boot and you will only see this login screen when you manually **log out** (`logout` session).

To test or lock your session while logged in (`Super+L` or 5-minute idle timeout), use the companion project: [`orbital-clock-lockscreen`](../orbital-clock-lockscreen).

---

## Configuration

You can customize the theme by editing `/usr/share/sddm/themes/orbital/theme.conf`:

```ini
[General]
type=color
color=#000000
fontSize=12
themeMode=dark   # dark | light
enableWindup=true
```

- **`themeMode`**: Set to `dark` (black background, white rings) or `light` (white background, dark rings).
- **`enableWindup`**: Set to `true` to play the windup/blast animation on login, or `false` for instant login.

---

## Uninstall

```bash
chmod +x uninstall.sh
./uninstall.sh
```

Or manually:
```bash
sudo rm -rf /usr/share/sddm/themes/orbital
sudo rm -f /etc/sddm.conf.d/10-theme.conf
```

---

## Credits & License

- Orbital design + `qylock` by [Darkkal44/qylock](https://github.com/Darkkal44/qylock), licensed under `GPL-3.0` — see [`LICENSE`](LICENSE).
- Frame blob and SDDM integration adapted from [neur0map/ryoku-arch](https://github.com/neur0map/ryoku-arch).
