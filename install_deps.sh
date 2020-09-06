#!/bin/bash

if [ "$(uname)" != "Darwin" ]; then
    echo "This script has not been tested on non-Darwin environments. Exiting."
    exit 1
fi

# assuming MacOS
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
# install useful key bindings and fuzzy completion for fzf
$(brew --prefix)/opt/fzf/install
# set fish as default shell
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# for neovim, optional
npm install -g neovim
pip3 install --upgrade pynvim

# for setup
brew install stow