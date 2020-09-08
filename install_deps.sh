#!/bin/bash

if [ "$(uname)" != "Darwin" ]; then
    echo "Running install for MacOS environment"
    # install config deps
    brew install fish
    brew install exa
    brew install pyenv
    brew install node
    brew install neovim --HEAD
    brew install ripgrep
    brew install fzf
    brew install fd
    brew install dust
    brew install prettyping
    brew install llvm
    # install useful key bindings and fuzzy completion for fzf
    $(brew --prefix)/opt/fzf/install
    # set fish as default shell
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
    # for setup
    brew install stow
elif [ "$(uname)" == "Linux" ]; then
    echo "Running install for Ubuntu environment"
    # install main deps
    sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip
    # install config deps
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    sudo apt install fish
    cargo install exa
    cargo install du-dust
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y nodejs neovim ripgrep fzf fd-find prettyping clangd
    # set fish as default shell
    # echo /usr/bin/fish | sudo tee -a /etc/shells - unnecessary on ubuntu
    chsh -s /usr/bin/fish
    # for setup
    sudo apt install -y stow
else
    echo "This script has not been tested on your operating system/environment. Exiting."
    exit 1
fi

# for neovim, optional
npm install -g neovim
pip3 install --upgrade pynvim

