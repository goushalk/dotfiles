#!/usr/bin/env bash

set -e

echo "==> Hyprland full system bootstrap"
echo "==> Arch-based systems only"
echo

# -------------------- Sanity checks --------------------
if ! command -v pacman &>/dev/null; then
  echo "[✗] pacman not found. Arch-based systems only."
  exit 1
fi

if ! command -v sudo &>/dev/null; then
  echo "[✗] sudo is required."
  exit 1
fi

# -------------------- Variables --------------------
DOTFILES_REPO="https://github.com/goushalk/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

# If you prefer to append a .bak suffix to files/folders instead of moving them
# to a separate backup directory, export BACKUP_METHOD=suffix before running.
# Allowed values:
#   dir    - move files to $BACKUP_DIR (default)
#   suffix - rename files in-place by adding a .bak suffix (avoid overwriting existing .bak)
BACKUP_METHOD="${BACKUP_METHOD:-dir}"  # "dir" or "suffix"

CONFIG_DIRS=(
  hypr
  waybar
  wofi
  wlogout
  dunst
  swaylock
  waypaper
  mpvpaper
)

# Top-level dotfiles to consider for backup (will only be processed if they exist)
TOP_LEVEL_DOTFILES=(
  ".zshrc"
  ".bashrc"
  ".profile"
  ".xprofile"
  ".xinitrc"
)

# -------------------- System update --------------------
echo "==> Updating system"
sudo pacman -Syu --noconfirm

# -------------------- Core packages --------------------
echo "==> Installing core packages"
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
  ttf-0xproto-nerd \
  eza \
  libnotify \
  zsh \
  neovim \
  unzip \
  git \
  curl \
  wget \
  stow \
  hyprpicker \
  gum \
  wiremix \
  btop \
  socat

# -------------------- Install yay --------------------
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay"
  sudo pacman -S --noconfirm --needed git base-devel
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

YAY_FLAGS="--noconfirm --needed --answerclean All --answerdiff None --removemake"

# -------------------- AUR packages --------------------
echo "==> Installing AUR packages"
yay -S $YAY_FLAGS \
  matugen-bin \
  wlogout \
  waypaper \
  mpvpaper \
  impala \
  bluetui \
  python-pywalfox

# -------------------- Backup existing configs --------------------
echo "==> Backing up existing configs (method: $BACKUP_METHOD)"
# Ensure BACKUP_DIR exists for "dir" method (created lazily below if needed)
# Build a list of items to back up:
BACKUP_ITEMS=()

# Add everything inside ~/.config
if [ -d "$HOME/.config" ]; then
  # shellcheck disable=SC2086
  for p in "$HOME/.config"/*; do
    [ -e "$p" ] || continue
    BACKUP_ITEMS+=("$p")
  done
fi

# Add explicitly-requested config directories (in case some are not direct children in .config)
for dir in "${CONFIG_DIRS[@]}"; do
  # prefer ~/.config/<dir>
  path="$HOME/.config/$dir"
  if [ -e "$path" ]; then
    # avoid duplicate entries
    skip=false
    for existing in "${BACKUP_ITEMS[@]}"; do
      [ "$existing" = "$path" ] && skip=true && break
    done
    $skip || BACKUP_ITEMS+=("$path")
  fi
done

# Add common top-level dotfiles (like ~/.zshrc)
for f in "${TOP_LEVEL_DOTFILES[@]}"; do
  path="$HOME/$f"
  if [ -e "$path" ]; then
    BACKUP_ITEMS+=("$path")
  fi
done

# If nothing to backup, print and continue
if [ "${#BACKUP_ITEMS[@]}" -eq 0 ]; then
  echo "  -> No existing configs found to back up."
else
  # Backup function: either rename with .bak suffix or move to BACKUP_DIR preserving basename
  backup_item() {
    local src="$1"
    if [ "$BACKUP_METHOD" = "suffix" ]; then
      # create a .bak suffix in-place, avoiding overwrite
      local dst="${src}.bak"
      if [ -e "$dst" ]; then
        dst="${src}.bak.$(date +%s)"
      fi
      echo "  -> Renaming $src -> $dst"
      mv "$src" "$dst"
    else
      # default: move into BACKUP_DIR
      mkdir -p "$BACKUP_DIR"
      local name
      name="$(basename "$src")"
      local dst="$BACKUP_DIR/$name"
      if [ -e "$dst" ]; then
        dst="$BACKUP_DIR/${name}.$(date +%s)"
      fi
      echo "  -> Moving $src -> $dst"
      mv "$src" "$dst"
    fi
  }

  for item in "${BACKUP_ITEMS[@]}"; do
    backup_item "$item"
  done
fi

# -------------------- Oh My Zsh --------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh"
  export RUNZSH=no
  export CHSH=no
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# -------------------- Clone dotfiles --------------------
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "==> Cloning dotfiles repository"
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
else
  echo "==> Dotfiles repo already exists, skipping clone"
fi

# -------------------- Stow dotfiles --------------------
echo "==> Stowing dotfiles"
cd "$DOTFILES_DIR"
stow .

# -------------------- Enable Oh My Posh (non-destructive) --------------------
ZSHRC="$HOME/.zshrc"

if ! grep -q "oh-my-posh init zsh" "$ZSHRC" 2>/dev/null; then
  echo "==> Enabling Oh My Posh"
  cat <<'EOF' >>"$ZSHRC"

# ---- Oh My Posh ----
eval "$(oh-my-posh init zsh)"
EOF
fi

# -------------------- Font cache --------------------
echo "==> Updating font cache"
fc-cache -fv

# -------------------- Done --------------------
echo
echo "==> Installation complete."
if [ "$BACKUP_METHOD" = "dir" ]; then
  echo "==> Backups stored in: $BACKUP_DIR"
else
  echo "==> Backups stored alongside originals with a .bak suffix (or .bak.<timestamp> if name conflict)."
fi
echo "==> Reboot recommended before starting Hyprland."