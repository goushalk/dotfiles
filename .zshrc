# ================================
# Oh My Zsh
# ================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  sudo
)

source "$ZSH/oh-my-zsh.sh"

# ================================
# PATH (portable, no username leak)
# ================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"

# ================================
# NVM (single clean load)
# ================================
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ================================
# Aliases
# ================================
alias c='clear'
alias v='nvim'

alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'

alias ls='eza --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'

alias shutdown='systemctl poweroff'

# Optional app alias (portable)
alias TL='java -jar "$HOME/software/TLauncher.jar"'

# tmux / sesh helper
alias tsm='sesh connect $(sesh list -i | gum choose)'

# ================================
# Prompt (oh-my-posh)
# ================================
eval "$(oh-my-posh init zsh --config "$HOME/.poshthemes/arch.omp.json")"

# ================================
# Git helper function
# ================================
gcap() {
    blue=$(tput setaf 4)
    red=$(tput setaf 1)
    reset=$(tput sgr0)

    if [[ -z "$1" ]]; then
        echo ""
        echo "${red}[+] Provide the commit message${reset}"
        echo ""
        return 1
    fi

    echo ""
    echo "${blue}[+] Staging changes...${reset}"
    git add .

    echo ""
    echo "${blue}[+] Committing...${reset}"
    git commit -m "$1 — $(date '+%Y-%m-%d %H:%M:%S')"

    echo ""
    echo "${blue}[+] Pushing...${reset}"
    git push
}

# ================================
# Zinit (plugin manager)
# ================================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# Zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

autoload -U compinit && compinit

# ================================
# Local overrides (NOT tracked)
# ================================
# Create ~/.zshrc.local for private stuff
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
