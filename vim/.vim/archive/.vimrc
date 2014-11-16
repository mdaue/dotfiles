set tabstop=4
set softtabstop=4
set shiftwidth=4
syntax on
filetype plugin indent on
set nocompatible
set wildmenu
set showcmd
set background=dark
set number
set smarttab
set expandtab
set autoindent
colorscheme desert
map     <F12>   :nohlsearch<CR>
imap    <F12>   <ESC>:nohlsearch<CR>i
vmap    <F12>   <ESC>:nohlsearch<CR>gv
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
autocmd BufRead,BufNewFile *.py inoremap # X#
