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
    sudo mv icons/Flat-Remix-Blue-Light /usr/share/icons/
    sudo mv qt5ct/colors/Kali-Light.conf /usr/share/qt5ct/colors/
    sudo mv themes/Kali-Light /usr/share/themes
fi

if [ ! -d "$HOME/Downloads/nvimDownload" ]; then
    cd ~/Downloads
    mkdir nvimDownload
    cd nvimDownload
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage  
    chmod u+x nvim-linux-x86_64.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
fi

if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [  ! -d "$HOME/.tmux/plugins/tpm" ]; then
	mkdir -p "$HOME/.tmux/plugins/tpm"
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d "$HOME/.tmuxifier" ]; then
	git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier
fi

if [ ! -d "$HOME/.local/bin/fd" ]; then
	mkdir -p "$HOME/.local/bin/fd"
	ln -s $(which fdfind) ~/.local/bin/fd
fi

if [ ! -d "$HOME/Downloads/lazygitDown" ]; then
	cd ~/Downloads
	mkdir lazygitDown
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit -D -t /usr/local/bin/
fi

sudo ln -s /usr/bin/convert /usr/bin/magick

