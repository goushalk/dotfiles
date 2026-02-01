# dotfiles — my Hyprland config

- Personal Hyprland configuration and related UI/utility files for a Wayland desktop setup.
- I couldnt setup hotspot if any one knows anything about it then we can talk about it in [discussion](https://github.com/goushalk/dotfiles/discussions/1#discussion-9414471)



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
- [Credits](#credits)
- [License](#license)

---

## Highlights

- Minimal, keyboard-forward Hyprland layout and keybindings
- Styles (CSS) for status bar / widgets (primary language in this repo)
- Small helper scripts for launch, reload and desktop utilities
- Optional extras (shaders, shell scripts, Lua helpers) for niceties

---

## Screenshots

Visual overview of the setup.  
Replace the placeholders below with real screenshots from your system.

### Desktop overview
![Desktop overview](screenshots/2026-02-01-101846_hyprshot.png )

### Tiled windows / workflow
![Tiling workflow](screenshots/2026-02-01-102324_hyprshot.png)

### Status bar and widgets
![Status bar](screenshots/bar.png)

### Launcher / notifications
![Launcher and notifications](screenshots/2026-02-01-130409_hyprshot.png)

---

## What's included

Typical top-level structure (may vary):

- `config/` — config files (Hyprland, waybar/waypaper, scripts, etc.)
- `Walls/` — wallpaper collection and previews
- `scripts/` — helper scripts (launchers, reload, monitor management)
- `themes/` — colors, icons, and visual assets
- `README.md` — this file

(Examine the repo for exact paths and file names.)

---

## Installation

1. Backup existing Hyprland config (if any):
` mv ~/.config/hypr ~/.config/hypr.bak`
2. run this command:
`curl -fSsl https://raw.githubusercontent.com/goushalk/dotfiles/refs/heads/main/install.sh | bash`
3. reboot
4. Enjoy my hyprland config (^_^)

---

## Contributing

This repo is my personal config but improvements are welcome. If you open an issue or PR, please:

- Describe your environment (distro, Hyprland version, compositor extras)
- Include failing logs or exact errors
- Prefer small, focused changes

---

## Credits

Thanks and credit to the following dotfile authors who inspired parts of this setup:

- lvntcnylmz — for fuzzel and swaync dotfiles (inspiration and snippets used)
- Hyprland project and community
- Waybar and the Wayland utilities community
- Icon/font/theme authors referenced in themes
- Omarchy

---

## License

Personal dotfiles — see LICENSE (if present). If no license file exists, the repository is private/personal and not recommended for reuse without permission.

---

Thanks for checking out this config.
