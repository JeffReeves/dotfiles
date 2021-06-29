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

