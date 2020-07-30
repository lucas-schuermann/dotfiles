#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p ~/.config

ln -s ${BASEDIR}/kitty ~/.config/kitty
ln -s ${BASEDIR}/fish ~/.config/fish
ln -s ${BASEDIR}/nvim ~/.config/nvim

# git
ln -s ${BASEDIR}/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/gitignore_global ~/gitignore_global