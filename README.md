`dotfiles` contains my personal environment configuration files.

## Usage
Pull the repository, optionally install package dependencies `./install_deps.sh`, then create the symbolic links using GNU stow.
```bash
git clone https://github.com/cerrno/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install_deps.sh
stow cargo curl fish git neovim
```

Periodically update dependencies with `./update_deps.sh`.

## VSCode
All non-essential `@builtin` extensions are disabled to improve startup time.
```bash
$ code --list-extensions
4ops.terraform
dracula-theme.theme-dracula
golang.go
James-Yu.latex-workshop
ms-azuretools.vscode-docker
ms-python.isort
ms-python.python
ms-python.vscode-pylance
ms-toolsai.jupyter
ms-toolsai.jupyter-keymap
ms-toolsai.jupyter-renderers
ms-toolsai.vscode-jupyter-cell-tags
ms-toolsai.vscode-jupyter-slideshow
ms-vscode.cpptools
ms-vscode.sublime-keybindings
rust-lang.rust-analyzer
serayuzgur.crates
streetsidesoftware.code-spell-checker
svelte.svelte-vscode
tamasfe.even-better-toml
vadimcn.vscode-lldb
```
