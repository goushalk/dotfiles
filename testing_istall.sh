#!/usr/bin/env bash
DOTFILES_REPO="https://github.com/goushalk/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

inital_setupintro() {

	echo "==> Hyprland full system bootstrap"
	echo "==> Arch-based systems only"
	echo
}

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

	# Install yay if not installed
	if ! command -v yay &>/dev/null; then
		echo "==> Installing yay"
		sudo pacman -S --noconfirm --needed git base-devel
		git clone https://aur.archlinux.org/yay.git /tmp/yay
		(cd /tmp/yay && makepkg -si --noconfirm)
		rm -rf /tmp/yay
	fi

}

backup_existing_config() {
	# Backup zhs
	mkdir -p "$BACKUP_DIR"
	echo "==> backing up existing zsh configs"
	if [ -f "$HOME/.zshrc" ]; then
		echo "  -> ~/.zshrc"
		mv "$HOME/.zshrc" "$BACKUP_DIR/"
	fi

	echo "==> Backing up existing configs"
	if [ -d "$HOME/.config/" ]; then
		echo " $HOME/.config/ -> $BACKUP_DIR"
		mv "$HOME/.config/" "$BACKUP_DIR/"
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
	yay_flags="--noconfirm --needed --answerclean All --answerdiff None --removemake"
	yay -S $yay_flags \
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

install_zsh() {

	# Check is zsh is installed
	if [ ! -d "$HOME/.oh-my-zsh" ]; then
		echo "==> Installing Oh My Zsh"
		export RUNZSH=no
		export CHSH=no
		export KEEP_ZSHRC=yes
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
}

clone_dotfiles() {
	# Variables needs to be to changed to their fucntions

	if [ ! -d "$DOTFILES_DIR" ]; then
		echo "==> Cloning dotfiles repository"
		git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
		echo "==> Stowing dotfiles"
		# This basically creates a subprocess so we don't have the current working dict to $DOTFILES_DIR
		(
			cd "$DOTFILES_DIR"
			stow */
		)
	else
		echo "==> Dotfiles repo already exists, skipping clone"
	fi

}

update_font_cache() {
	echo "==> Updating font cache"
	fc-cache -fv
}

install_done() {
	echo
	echo "==> Installation complete."
	echo "==> Backups stored in: $BACKUP_DIR"
	echo "==> Reboot recommended before starting Hyprland."
}

run_bootstrap() {
	# Stop execution if any single command fails
	set -e

	inital_setupintro
	sanity_checkes
	backup_existing_config
	install_core_packages
	install_aur_packages
	install_zsh
	clone_dotfiles
	update_font_cache
	install_done
}

run_bootstrap
