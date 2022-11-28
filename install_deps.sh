#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    echo "Running install for MacOS environment"
    CPU=$(uname -p)
    if [ "$CPU" == "arm" ]; then
        echo "Configuring for Apple Silicon platform"
    else
        echo "Configuring for x84_64 platform"
    fi
    # install config deps
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    brew install fish
    brew install exa
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
    # rust globally configured to use better linker
    brew install michaeleisel/zld/zld
    # install useful key bindings and fuzzy completion for fzf
    $(brew --prefix)/opt/fzf/install
    if [ "$CPU" != "arm" ]; then
        echo "\"~/.config/fish/functions/fzf_key_bindings.fish\" symlink might be broken for non Apple Silicon platforms. Please refer to fzf docs to replace."
    fi
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
    sudo apt install -y build-essential libssl-dev libffi-dev python3-dev python3-pip pkg-config
    # install config deps
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
    sudo apt install fish
    cargo install exa
    cargo install du-dust
    cargo install tealdeer
    cargo install procs
    cargo install xh
    sudo apt install -y neovim ripgrep fzf fd-find prettyping clangd jq zoxide
    # rust globally configured to use better linker
    sudo apt install -y mold
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
cargo install sccache
