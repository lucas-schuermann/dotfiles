# dotfiles
My personal environment configuration files

## Usage
Pull the repository, optionally install package dependencies `./install_deps.sh`, then create the symbolic links using GNU stow.
```
$ git clone git@github.com:cerrno/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ stow coc fish git kitty neovim
```

## Remote hosts and `sudo`
In order to preserve terminal for `ssh` remote hosts, the `ssh` command has been mapped to use the `kitty` executable to set environment variables with the proper `.terminfo`. For `sudo su`, etc., use `sudo visudo` to add `Defaults env_keep += "TERM TERMINFO"` to the `sudoers` configuration.

## License
[MIT](https://lucasschuermann.com/license.txt)
