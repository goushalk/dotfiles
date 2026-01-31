#!/usr/bin/env bash
set -euo pipefail

echo "==> Hyprland full system bootstrap"
echo "==> Arch-based systems only"
echo

# -------------------- Sanity checks --------------------
if ! command -v pacman &>/dev/null; then
  echo "[✗] pacman not found. Arch-based systems only."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "[✗] sudo not found."
  exit 1
fi

# -------------------- Vars --------------------
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%F-%H%M%S)"
ZSHRC="$HOME/.zshrc"

# -------------------- Backup existing configs --------------------
echo "==> Backing up existing configs"
mkdir -p "$BACKUP_DIR"

for dir in hypr waybar wofi kitty nvim; do
  if [ -d "$HOME/.config/$dir" ]; then
    mv "$HOME/.config/$dir" "$BACKUP_DIR/"
  fi
done

if [ -f "$ZSHRC" ]; then
  mv "$ZSHRC" "$BACKUP_DIR/"
fi

# -------------------- System update --------------------
echo "==> Updating system"
sudo pacman -Syu --noconfirm

# -------------------- Base packages --------------------
echo "==> Installing base packages"
sudo pacman -S --noconfirm --needed \
  git \
  base-devel \
  zsh \
  stow \
  hyprland \
  waybar \
  wofi \
  kitty \
  grim \
  slurp \
  wl-clipboard \
  polkit-kde-agent \
  pipewire \
  wireplumber \
  pavucontrol \
  networkmanager \
  brightnessctl \
  noto-fonts \
  noto-fonts-emoji \
  ttf-jetbrains-mono \
  nautilus

# -------------------- Enable services --------------------
echo "==> Enabling services"
sudo systemctl enable NetworkManager.service

# -------------------- AUR helper --------------------
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay"
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

# -------------------- AUR packages --------------------
echo "==> Installing AUR packages"
yay -S --noconfirm --needed \
  hyprpaper \
  grimblast \
  swayidle \
  swaylock-effects \
  waybar-module-pacman-updates \
  wlogout

# -------------------- Fonts cache --------------------
echo "==> Refreshing font cache"
fc-cache -fv

# -------------------- Oh My Zsh --------------------
echo "==> Installing Oh My Zsh"
export RUNZSH=no
export CHSH=no
export KEEP_ZSHRC=yes

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# -------------------- Zsh config --------------------
echo "==> Writing .zshrc"
cat >"$ZSHRC" <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git sudo)

source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export TERMINAL=kitty
EOF

chsh -s /bin/zsh

# -------------------- Stow dotfiles --------------------
echo "==> Stowing dotfiles"
stow hypr
stow waybar
stow wofi
stow kitty
stow nvim

# -------------------- Done --------------------
echo
echo "==> Install complete"
echo "==> Backup saved at: $BACKUP_DIR"
echo "==> Reboot recommended before starting Hyprland"
