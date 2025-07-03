#!/bin/bash

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Usage: $0 <package-list-file>"
    exit 1
fi

PACKAGE_LIST="$1"

sudo apt update && sudo apt upgrade -y
sudo apt install -y $(cat "$PACKAGE_LIST")

FONT_DIR="$HOME/.local/share/fonts"
if [ ! -d "$FONT_DIR" ]; then
    mkdir -p "$FONT_DIR"
fi
if ! ls "$FONT_DIR" | grep -qi "JetBrain"; then
    wget -P ~/Downloads/ https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip ~/Downloads/JetBrainsMono.zip -d "$FONT_DIR"
    fc-cache -fv
fi

if [ ! -d "$HOME/Downloads/nvimDownload" ]; then
    cd ~/Downloads
    mkdir nvimDownload
    cd nvimDownload
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage  
    chmod u+x nvim-linux-x86_64.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
 else
    cd ~/Downloads/nvimDownload
    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage  
    chmod u+x nvim-linux-x86_64.appimage
    sudo mkdir -p /opt/nvim
    sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim
fi

if [ ! -d "$HOME/.zplug" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
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

#!/bin/bash

# Check if /usr/bin/magick symlink exists
if [ ! -L /usr/bin/magick ]; then
    echo "Creating symlink for magick..."
    sudo ln -s /usr/bin/convert /usr/bin/magick
else
    echo "Symlink /usr/bin/magick already exists, skipping."
fi

# Check if ~/.docker/desktop/docker.sock symlink exists
if [ ! -L "$HOME/.docker/desktop/docker.sock" ]; then
    echo "Creating symlink for Docker socket..."
    mkdir -p "$HOME/.docker/desktop"
    sudo ln -s /var/run/docker.sock "$HOME/.docker/desktop/docker.sock"
fi

# Install zoxide if not already installed
if ! command -v zoxide >/dev/null 2>&1; then
    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# Clone fzf repo if ~/.fzf doesn't exist
if [ ! -d "$HOME/.fzf" ]; then
    echo "Cloning fzf..."
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi
