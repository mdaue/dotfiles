" Pathogen
filetype off " Pathogen needs to run before plugin indent on
call pathogen#runtime_append_all_bundles()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'
filetype plugin indent on

" youcompleteme
let g:ycm_global_ycm_extra_conf = '/home/ddos/.vim/bundle/youcompleteme/cpp/ycm/.ycm_extra_conf.py'

" TagBar
nmap <F4> :TagbarToggle<CR>

" Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<F5>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
set runtimepath+=~/.vim/bundle/vim-snippets/UltiSnips

" Airline
let g:airline#extensions#tabline#enabled = 1

" Multicursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_next_key='<F7>'
let g:multi_cursor_prev_key='<F8>'
let g:multi_cursor_skip_key='<F9>'
let g:multi_cursor_quit_key='<Esc>'

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" Easy Align hooks
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" Vim
set hidden
set backspace=indent,eol,start
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup
set noswapfile
set pastetoggle=<F2>

" Airline specific tweaks
set laststatus=2
set ttimeoutlen=50

" clang helper settings
let g:clang_user_options = "-I/usr/include/c++/4.6"
let g:clang_library_path = "/usr/lib64/llvm"
let g:clang_complete_auto = 1

" syntastic
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_c_checkers = ['gcc', 'oclint']

" Sparkup
let g:sparkupExecuteMapping = '<f3>'
let g:sparkupNextMapping = '<f4>'

" CTRLP
let g:ctrlp_extensions = ['ssh']
let g:ctrlp_ssh_runner = 'tmux'

" Map CTRLPBuffer
noremap <C-P> :CtrlP<CR>
noremap <C-L> :CtrlPBuffer<CR>
nnoremap <C-S> :CtrlPSSH<CR>


" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Open my VIMRC
nnoremap <leader>ev :vsplit ${MYVIMRC}<cr>
nnoremap <leader>sv :source ${MYVIMRC}<cr>
inoremap jk <esc>
onoremap h j
onoremap j k
onoremap k l
onoremap l ;
"inoremap <esc> <nop>
nnoremap <leader>gs :Git status<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gfm :Git pull origin master<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>stm :SyntasticToggleMode<cr>
inoremap <C-v> <esc>l"+gPa
nnoremap <C-v> "+gPa
vnoremap <C-c> "+y
inoremap <C-c> <esc>bve"+y
nnoremap <C-c> bve"+y
nnoremap <A-q> :bd<cr>
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
nnoremap <silent> <A-Space> @=(foldlevel('.')?'zA':"\<Space>")<CR>
vnoremap <Space> zf
nnoremap <leader>w :bd<cr>

set mouse=a
"set term=xterm
set tabstop=4
set softtabstop=4
set smartcase
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
colorscheme wombat256mod
map     <F12>   :nohlsearch<CR>
imap    <F12>   <ESC>:nohlsearch<CR>i
vmap    <F12>   <ESC>:nohlsearch<CR>gv
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
autocmd BufRead,BufNewFile *.py inoremap # X#

set foldmethod=marker

map <C-s> :w<CR>
map <C-x> :wq!<CR>
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>
map <C-}> <ESC><C-x><C-u>

set guifont=Andale\ Mono:h14

"if $COLORTERM == 'gnome-terminal'
set t_Co=256
"endif

set shell=bash
