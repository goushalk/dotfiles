# dotfiles — my Hyprland config

Personal Hyprland configuration and related UI/utility files for a Wayland desktop setup.

This repository contains my Hyprland configuration, status bar styles, scripts and small utilities I use to run a polished, keyboard-driven Wayland environment.

---

## Table of contents

- [Highlights](#highlights)
- [What's included](#whats-included)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)
- [Credits](#credits)

---

## Highlights

- Minimal, keyboard-forward Hyprland layout and keybindings
- Styles (CSS) for status bar / widgets (primary language in this repo)
- Small helper scripts for launch, reload and desktop utilities
- Optional extras (shaders, shell scripts, Lua helpers) for niceties

---

## What's included

Typical top-level structure (may vary):

- `hypr/` — main Hyprland config files (layouts, keybindings, rules)
- `waybar/` or `bar/` — bar configuration and CSS styling
- `scripts/` — helper scripts (launchers, reload, monitor management)
- `themes/` — colors, icons, and visual assets
- `README.md` — this file

(Examine the repo for exact paths and file names.)

---

## Requirements

This configuration is written for a Hyprland-based Wayland environment. Install the following (package names vary by distro):

- Hyprland (hyprland or hyprland-git)
- swaybg / hyprpaper (for wallpaper)
- waybar (or alternate status bar)
- wofi / rofi (launcher)
- mako (notifications)
- grim + slurp (screenshots)
- wl-clipboard (clipboard support)
- a terminal (foot, alacritty, kitty, etc.)
- Optional: gammastep or redshift, wlogout, swaylock, foot

Make sure you have the compositor and tools appropriate for your distro and setup.

---

## Installation

1. Backup existing Hyprland config (if any):
   - mv ~/.config/hypr ~/.config/hypr.bak

2. runthis command:
   `curl -fSsl https://raw.githubusercontent.com/goushalk/dotfiles/refs/heads/main/install.sh | bash`

4. reboot:


---

## Usage

- Reload Hyprland: use the configured keybinding (often something like Super+Alt+R) or run the included reload script.
- Edit configuration: open the relevant file in `~/.config/hypr/` (e.g., `hyprland.conf`) and adjust keybindings, rules, and monitor layouts.
- Update styles: modify CSS files under the bar folder (Waybar) and refresh the bar (often `pkill waybar` will restart it).
- Wallpapers: point hyprpaper / swaybg to images in `themes/` or configure your preferred wallpaper manager.

## Troubleshooting

- Blank screen or missing bar: check for errors from Hyprland and Waybar (`journalctl --user -b` and run waybar from terminal to see logs).
- Keybindings not working: ensure your keycodes match the terminal/shell and that the compositor recognizes the modifier keys.
- Monitor layout issues: inspect `monitor` lines in Hyprland config and ensure they match connected outputs (use `wlr-randr` or `hyprctl monitors` to list outputs).
- Fonts/icons missing: install nerd-fonts or required icon packs referenced by the bar CSS.

---

## Contributing

This repo is my personal config but improvements are welcome. If you open an issue or PR, please:

- Describe your environment (distro, Hyprland version, compositor extras)
- Include failing logs or exact errors
- Prefer small, focused changes

---

## License

Personal dotfiles — see LICENSE (if present). If no license file exists, the repository is private/personal and not recommended for reuse without permission.

---

## Credits

- Hyprland project and community
- Waybar and many small utilities in the Wayland ecosystem
- Icons, fonts, and theme authors (see credits in theme files when applicable)

---

Thanks for checking out this config. If you'd like, I can:

- generate example screenshots and badges,
- or tailor the README to list exact files present in the repository.
