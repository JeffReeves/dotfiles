syntax on                   " syntax highlighting
set term=xterm-256color     " ensures HOME and END keys work as expected, and basic colors are supported
"set term=screen-256color
if has('termguicolors')     " if `vim --version` shows: +termguicolors
    set termguicolors       " needed for full color support of most themes
endif
set pastetoggle=<F2>        " prevents issues when pasting
set noerrorbells            " disable sound effects
set tabstop=4 softtabstop=4 " number of spaces in tabs
set shiftwidth=4            " 
set expandtab               " expand tabs to spaces
set wildmenu                " 
set smartindent             " try to indent intelligently
"set rnu relativenumber      " relative line number
set nowrap                  " disable word-wrap
set smartcase               " 
set noswapfile              " no swap file (vim creates them by default) 
set nobackup                " no backup file
set undodir=~/.nvim/undodir " 
set undofile                " 
set cursorline              " 
set incsearch               " 
set formatoptions-=cro      " 
set background=dark         " 
set nocompatible            "

call plug#begin("~/.vim/plugged") " using plugged for vim plugins  

    " File explorer
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " Airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " Intellisense and code completion with syntax highlighting
    Plug 'sheerun/vim-polyglot'

    " improved bracket/parenthesis highlighting
    Plug 'luochen1990/rainbow'

    " color schemes
    Plug 'sainnhe/edge'
    Plug 'morhetz/gruvbox'
    Plug 'artanikin/vim-synthwave84'
    "Plug 'brandenbyers/vim-synthwave84'
call plug#end()                   " end plugged

" The configuration options should be placed before `colorscheme edge`.
let g:edge_style = 'neon'
"let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
"let g:edge_transparent_background = 0
"let g:edge_menu_selection_background = 'purple' " 'blue', 'green', 'purple'
"let g:edge_sign_column_background = 'none' " 'default', 'none'
"let g:edge_better_performance = 1

" enable theme
"colorscheme edge
colorscheme synthwave84

let g:airline_theme = 'edge'

" enable rainbow syntax highlighting on brackets and parenthesis 
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" NERD TREE AND ICONS
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusline='NERDTree'

" File explorer plugin
map <C-b> :NERDTreeToggle<CR>

" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" mapping escape to ctrl c
map <Esc><C-c> <CR>
inoremap jk <Esc>
inoremap kj <Esc>

" alternater way to save
nnoremap <silent> <C-s>     :w<CR>
nnoremap <silent> <C-Down>  :resize -2<CR>
nnoremap <silent> <C-Up>    :resize +2<CR>
nnoremap <silent> <C-Left>  :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>
