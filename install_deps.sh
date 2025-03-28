#!/bin/bash

set -eux

if [ "$(uname)" == "Darwin" ]; then
    echo "Running install for MacOS environment"
    CPU=$(uname -p)
    if [ "$CPU" == "arm" ]; then
        echo "Configuring for Apple Silicon platform"
    else
        echo "Configuring for x84_64 platform"
    fi
    # to avoid icloud sync issues
    mkdir -p "$HOME/.cache.nosync/homebrew"
    mv "$HOME/Library/Caches/Homebrew" "$HOME/.cache.nosync/homebrew"
    ln -s "$HOME/.cache.nosync/homebrew" "$HOME/Library/Caches/Homebrew"
    # install config deps
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    brew install gnupg
    brew install fish
    brew install eza
    brew install neovim --HEAD
    brew install ripgrep
    brew install fzf
    brew install fd
    brew install dust
    brew install prettyping
    brew install llvm
    brew install jq
    brew install tealdeer
    brew install zoxide
    brew install procs
    brew install xh
    # set fish as default shell
    if [ "$CPU" == "arm" ]; then
        echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
        chsh -s /opt/homebrew/bin/fish
    else
        echo /usr/local/bin/fish | sudo tee -a /etc/shells
        chsh -s /usr/local/bin/fish
    fi
    # for setup
    brew install stow
elif [ "$(uname)" == "Linux" ]; then
    echo "Running install for Ubuntu environment"
    # install main deps
    sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip pkg-config curl
    # install config deps
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
    sudo apt install -y fish
    cargo install eza
    cargo install du-dust
    cargo install tealdeer
    cargo install procs
    cargo install xh
    sudo apt install -y neovim ripgrep fzf fd-find prettyping clangd jq zoxide
    sudo apt install -y clang
    # set fish as default shell
    # echo /usr/bin/fish | sudo tee -a /etc/shells - unnecessary on ubuntu
    chsh -s /usr/bin/fish
    # for setup
    sudo apt install -y stow
else
    echo "This script has not been tested on your operating system/environment. Exiting."
    exit 1
fi

cargo install cargo-binutils
cargo install cargo-generate
cargo install cargo-nextest
cargo install cargo-update
cargo install cargo-edit
cargo install flamegraph
cargo install mdbook
