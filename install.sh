#!/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y $(cat necessary.txt)

FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
fi
if ! ls "$FONT_DIR" | grep -qi "JetBrain"; then
    wget -P ~/Downloads/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip ~/Downloads/JetBrainsMono.zip -d "$FONT_DIR"
    fc-cache -fv
fi

if [ ! -d "$HOME/Downloads/kali-themes" ]; then
    cd ~/Downloads/
    git clone https://gitlab.com/kalilinux/packages/kali-themes/
    cd kali-themes/share/
    sudo mv icons/Flat-Remix-Blue-Light/ /usr/share/icons/
    sudo mv qt5ct/colors/Kali-Light.conf /usr/share/qt5ct/colors/
    sudo mv themes/Kali-Light /usr/share/themes
fi

if [ ! -d "$HOME/Downloads/nvimDownload" ]; then
    cd ~/Downloads
    mkdir nvimDownload
    cd nvimDownload
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage 
    chmod u+x nvim.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim.appimage /opt/nvim/nvim
fi

if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

	

