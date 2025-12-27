#!/usr/bin/env bash

set -e

echo "==> Hyprland prerequisites installer"
echo "==> Arch-based systems only"
echo

# ---- Sanity checks ----
if ! command -v pacman &>/dev/null; then
  echo "pacman not found. Arch-based systems only."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "sudo is required."
  exit 1
fi

# ---- Update system ----
echo "==> Updating system"
sudo pacman -Syu --noconfirm

# ---- Core Wayland / Hyprland stack (official repos) ----
echo "==> Installing core Wayland + Hyprland stack"
sudo pacman -S --noconfirm --needed \
  hyprland \
  waybar \
  wofi \
  swaylock \
  swaybg \
  dunst \
  mpv \
  wl-clipboard \
  grim \
  slurp \
  brightnessctl \
  pamixer \
  playerctl \
  xdg-desktop-portal-hyprland \
  qt5-wayland \
  qt6-wayland \
  rust \
  cargo \
  ttf-0xproto-nerd

# ---- Install yay if missing ----
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay (AUR helper)"
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (
    cd /tmp/yay
    makepkg -si --noconfirm
  )
  rm -rf /tmp/yay
fi

# ---- yay non-interactive flags ----
YAY_FLAGS="--noconfirm --needed --answerclean All --answerdiff None --removemake"

# ---- AUR packages ----
echo "==> Installing AUR packages"
yay -S $YAY_FLAGS \
  matugen-bin \
  wlogout \
  waypaper \
  mpvpaper \
  impala \
  bluetui

# ---- Font cache ----
echo "==> Updating font cache"
fc-cache -fv

# ---- Done ----
echo
echo "==> Installation complete."
echo "==> Reboot recommended before starting Hyprland."
