#!/bin/bash
# Zsh + Oh My Zsh + Plugins Auto Installer

set -e

echo "[*] Updating packages..."
apt update -y

echo "[*] Installing Zsh..."
apt install -y zsh git curl

echo "[*] Changing default shell to Zsh..."
chsh -s "$(which zsh)"

echo "[*] Installing Oh My Zsh..."
RUNZSH=no KEEP_ZSHRC=yes \
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.zsh}"

echo "[*] Installing Zsh plugins..."
# Autosuggestions
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
fi
# Syntax highlighting
if [ ! -d "$ZSH_CUSTOM/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/zsh-syntax-highlighting"
fi

echo "[*] Configuring ~/.zshrc..."
{
    echo ""
    echo "# Enable colors"
    echo "autoload -Uz colors && colors"
    echo ""
    echo "# Zsh Autosuggestions"
    echo "source $ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh"
    echo "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'"
    echo ""
    echo "# Syntax Highlighting"
    echo "source $ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    echo ""
    echo "# Fix insecure completion directories"
    echo "compaudit | xargs chmod g-w,o-w 2>/dev/null || true"
} >> ~/.zshrc

echo "[*] Installation complete! Start Zsh with:"
echo "unset zle_bracketed_paste" >> ~/.zshrc
source ~/.zshrc
echo "    Now Execute 'zsh' and you're good to go."
