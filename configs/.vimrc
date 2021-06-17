"==[ GENERAL SETTINGS ]====================================================================================================================

" vi compatibility
set nocompatible            " disable compatibility with vi

" history
set history=1000            " set history limit

" encoding
set encoding=UTF-8          " UTF-8 for character support

" drawing
set lazyredraw              " only redraw the screen when necessary

" color support
set term=xterm-256color     " basic 256 color support
"set term=screen-256color   " alternative, if xterm unavailable
if has('termguicolors')     
    set termguicolors       " needed for full color support of most themes
endif

" syntax highlighting
syntax on                   " syntax highlighting

" mouse
if has('mouse')             " enable mouse, if supported
    set mouse=a             " enable in all modes
endif

" cursor
set cursorline              " horizontal cursor
"set cursorcolumn           " vertical cursor

" line numbers
"set rnu relativenumber     " relative line number

" tabs
set expandtab               " expand tabs to spaces
set tabstop=4               " number of spaces in tabs
set softtabstop=4           " 
set shiftwidth=4            " 

" indentation
set smartindent             " try to indent intelligently

" word wrap
set nowrap                  " disable word wrap

" formatting
set formatoptions-=cro      " disable automatic comments on newline

" pasting
set pastetoggle=<F2>        " prevents issues when pasting

" sound
set noerrorbells            " disable sound effects
set visualbell              " use a visual bell instead

" filetype association
filetype on                 " enable filetype detection 
filetype plugin on          " load plugins based on filetype
filetype indent on          " load indent files based on filetype

" search
set hlsearch                " use highlighting
set incsearch               " highlight characters as they are typed
set showmatch               " highlight matching parenthesis/brackets
set smartcase               " searching with capitals is case sensitive
"set showcmd                " show commands being ran in bottom right

" tab completion
set wildmenu                " tab completion in vim
set wildmode=list:longest   " make it similar to bash    
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " ignore these files for tab completion

" files
set noswapfile              " no swap file (vim creates them by default) 
set nobackup                " no backup file
set undofile                " 
set undodir=~/.nvim/undodir " 

" themes
set background=dark         " use if terminal has a dark background
"set background=light       " use if terminal has a light background


"==[ PLUGINS ]=============================================================================================================================

call plug#begin("~/.vim/plugged")           " vim-plug for plugins 

    Plug 'scrooloose/nerdtree'              " file explorer
    Plug 'ryanoasis/vim-devicons'           " icons for file explore (requires UTF-8 and nerdfont)

    Plug 'vim-airline/vim-airline'          " bottom bar with easy to read info
    Plug 'vim-airline/vim-airline-themes'   " theme support for airline

    Plug 'sheerun/vim-polyglot'             " language/syntax support
    Plug 'luochen1990/rainbow'              " color match parenthesis/brackets

    Plug 'JeffReeves/vim-synthwave84'       " synthwave84 theme from VSCode (requires +termguicolors)
    "Plug 'artanikin/vim-synthwave84'       " original porter of synthwave84
    Plug 'sainnhe/edge'                     " dark theme - similar to synthwave84
    Plug 'morhetz/gruvbox'                  " dark greenish theme

call plug#end()                             " end vim-plug plugins


"--[ NERD TREE ]-----------------------------------------------------------------------------------

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 0
let g:NERDTreeIgnore = ['node_modules']
let NERDTreeStatusline='NERDTree'


"--[ AIRLINE ]-------------------------------------------------------------------------------------

let g:airline_theme = 'edge'


"--[ EDGE THEME ]----------------------------------------------------------------------------------

let g:edge_style = 'neon'
"let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1
"let g:edge_transparent_background = 0
"let g:edge_menu_selection_background = 'purple'    " 'blue', 'green', 'purple'
"let g:edge_sign_column_background = 'none'         " 'default', 'none'
"let g:edge_better_performance = 1


"--[ RAINBOW ]-------------------------------------------------------------------------------------

let g:rainbow_active = 1    " enabled


"==[ THEME ]===============================================================================================================================

colorscheme synthwave84


"==[ KEY MAPPINGS ]========================================================================================================================

map <F3> :NERDTreeToggle<CR>    " toggle open/close NerdTree Menu