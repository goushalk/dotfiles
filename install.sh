#!/usr/bin/env bash

set -e

echo "==> Hyprland prerequisites installer"
echo "==> Arch-based systems only"
echo

# ---- Sanity checks ----
if ! command -v pacman &>/dev/null; then
  echo "pacman not found. This script is for Arch-based systems only."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "sudo is required."
  exit 1
fi

# ---- Update system ----
echo "==> Updating system"
sudo pacman -Syu --noconfirm

# ---- Core Wayland / Hyprland stack ----
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
  impala \
  bluetui

# ---- Fonts ----
echo "==> Installing fonts"
sudo pacman -S --noconfirm --needed \
  ttf-0xproto-nerd

# ---- Rust toolchain ----
echo "==> Installing Rust toolchain"
sudo pacman -S --noconfirm needed \
  rust \
  cargo

# ---- AUR helper ----
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay (AUR helper)"
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

# ---- AUR packages ----
echo "==> Installing AUR packages"
yay -S --noconfirm --needed \
  matugen-bin \
  wlogout \
  waypaper \
  mpvpaper

# ---- Done ----
echo
echo "==> Installation complete."
echo "==> Reboot recommended before starting Hyprland."
