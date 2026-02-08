#!/usr/bin/env bash

sanity_checkes() {
	# Needs to be sudo
	if ! command -v sudo &>/dev/null; then
		echo "[✗] sudo is required."
		exit 1
	fi
	
	# Check if pacman is installed
	if ! command -v pacman &>/dev/null; then
		echo "[✗] pacman not found. Arch-based systems only."
		exit 1
	fi

	# Check is zsh is installed
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "==> Installing Oh My Zsh"
		export RUNZSH=no
		export CHSH=no
		export KEEP_ZSHRC=yes
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi

	# Install yay if not installed
	if ! command -v yay &>/dev/null; then
		echo "==> Installing yay"
		sudo pacman -S --noconfirm --needed git base-devel
		git clone https://aur.archlinux.org/yay.git /tmp/yay
		(cd /tmp/yay && makepkg -si --noconfirm)
		rm -rf /tmp/yay
	fi

	# Variables needs to be to changed to their fucntions
	DOTFILES_REPO="https://github.com/goushalk/dotfiles.git"
	DOTFILES_DIR="$HOME/dotfiles"

}

backup_existing_config() {
	backup_dir="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
	# Backup zhs
	echo "==> backing up existing zsh configs"
	if [ -f "$HOME/.zshrc" ]; then
		echo "  -> ~/.zshrc"
		mv "$HOME/.zshrc" "$backup_dir/"
	fi

	echo "==> Backing up existing configs"
	mkdir -p "$backup_dir"
	if [ -d "$HOME/.config/" ]; then
		echo " $HOME/.config/ -> $backup_dir"
		mv "$HOME/.config/" "$backup_dir/"
	fi
}

install_core_packages() {

	# Update the packs
	echo "==> Updating system"
	sudo pacman -Syu --noconfirm

	# Install corehyprland packs
	echo "==> Installing core packages"
	sudo pacman -S --noconfirm --needed \
		hyprland \
		waybar \
		swaybg \
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
		socat \
		tmux \
		xdg-desktop-portal-hyprland \
		hyprpolkitagent \
		hyprshot \
		swaync \
		power-profiles-daemon \
		nwg-displays \
		ripgrep
}

install_aur_packages() {
	echo "==> Installing AUR packages"
	yay -S $YAY_FLAGS \
		matugen-bin \
		wlogout \
		waypaper \
		mpvpaper \
		impala \
		bluetui \
		python-pywalfox \
		swaylock-effects \
		wl-clipboard \
		qt5-graphicaleffects \
		fuzzel \
		swayosd
}
