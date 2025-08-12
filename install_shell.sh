#!/bin/bash
# Zsh + Plugins Installer Script (No custom prompt)

set -e

echo "[*] Installing Zsh..."
sudo apt update -y
sudo apt install zsh git -y

echo "[*] Creating plugin directories..."
mkdir -p ~/.zsh

echo "[*] Installing zsh-autosuggestions..."
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
    echo "    -> zsh-autosuggestions already exists, skipping."
fi

echo "[*] Installing zsh-syntax-highlighting..."
if [ ! -d "$HOME/.zsh/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/zsh-syntax-highlighting
else
    echo "    -> zsh-syntax-highlighting already exists, skipping."
fi

echo "[*] Backing up existing .zshrc if present..."
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.backup

echo "[*] Creating new .zshrc with colors and plugins..."
cat << 'EOF' > ~/.zshrc
# Enable colors
autoload -Uz colors && colors

# Autosuggestions plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'

# Syntax highlighting plugin
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Options
setopt autocd
setopt correct
autoload -Uz compinit && compinit
EOF

echo "[*] Changing default shell to Zsh..."
chsh -s "$(which zsh)"

echo "[*] Done! Restart your terminal or run 'exec zsh' now."
