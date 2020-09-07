" Fish doesn't play all that well with others
set shell=/bin/bash
let mapleader = "\<Space>"

" General config
syntax on
set laststatus=2
set number
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set nocindent
set mouse=a
set history=1000
" Permanent undo
set undodir=~/.vimdid
set undofile

" Theme
packadd! dracula
syntax enable
filetype plugin indent on
set termguicolors
colorscheme dracula
let g:lightline = {
    \ 'colorscheme': 'dracula',
    \ }


" Package: fzf
set rtp+=/usr/local/opt/fzf

" ripgrep
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m

