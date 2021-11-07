" Fish doesn't play all that well with others
set shell=/bin/bash

let mapleader = "\<Space>"
let g:maplxeader ="\<Space>"

" General config
syntax on
set laststatus=2
set number
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set nocindent
set nowrap
set nojoinspaces
set history=1000

" GUI
set mouse=a
set ttyfast
set nofoldenable

" Show annoying hidden characters
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Sane splits
set splitright
set splitbelow

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Permanent undo
set undodir=~/.vimdid
set undofile

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Disable useless help keybinding
map <F1> <Esc>
imap <F1> <Esc>

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Very magic by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" Quick-save
nmap <leader>w :w<CR>

" Buffer management
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>
" Show all open buffers and their status
nmap <leader>bl :ls<CR>
nnoremap <leader>. :GFiles<CR>
nnoremap <leader>, :Buffers<CR>

" fzf 
" paths to accomodate Homebrew
set rtp+=/usr/local/opt/fzf
set rtp+=/opt/homebrew/opt/fzf
set rtp+=/usr/bin/fzf

" ripgrep
set grepprg=rg\ --no-heading\ --vimgrep
set grepformat=%f:%l:%c:%m

" <leader>s for Rg search
noremap <leader>s :Rg 
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)

" Lightline
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
        \   'filename': 'LightlineFilename',
    \ },
    \ 'colorscheme': 'dracula',
    \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Theme
packadd! dracula
syntax enable
filetype plugin indent on
set termguicolors
colorscheme dracula

" Nerdtree
" show hidden files by default
let g:NERDTreeShowHidden=1
" open and close file tree
map <C-n> :NERDTreeToggle<CR>
" open current buffer in file tree
nmap <leader>n :NERDTreeFind<CR>

