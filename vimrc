set nocompatible
set hidden
set wildmenu
set wildmode=list:full
set showcmd
set cmdheight=2
set mouse=a
set ruler
set confirm
set visualbell
set t_vb=
set autoread

filetype indent plugin on
syntax on

set number
set relativenumber
set cursorline
set showmatch

" Cursor movement
set nostartofline
set autoindent
set smartindent
set backspace=indent,eol,start

set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set title

set pastetoggle=<F12>

set clipboard=unnamed

set path+=**


set scrolloff=5 

set shiftwidth=2
set softtabstop=2
set expandtab

" set t_Co=256

" Display extra whitespace
set list 
set listchars=tab:»·,trail:·,precedes:>,extends:<


set wildignore+=*/tmp/*
set wildignore+=*/target/*
set wildignore+=*/build/*
set wildignore+=*.so
set wildignore+=*.o
set wildignore+=*.class
set wildignore+=*.swp
set wildignore+=*.zip
set wildignore+=*.pdf
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/dist/*

set noswapfile
set nobackup
set nowritebackup

set splitbelow
set splitright

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'valloric/youcompleteme'

Plug 'tpope/vim-rails'
Plug 'posva/vim-vue'
Plug 'slim-template/vim-slim'
Plug 'glench/vim-jinja2-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'pangloss/vim-javascript'

call plug#end()

set background=dark
colorscheme molokai

" Airline
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='badwolf'

set noshowmode

" CtrlP 
" Use The Silver Searcher instead of grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"nnoremap <M-Right> :bnext <CR>
"nnoremap <M-Left>  :bprevious <CR>
"nnoremap <M-w>     :bdelete <CR>

nnoremap <C-l> :bnext <CR>
nnoremap <C-h> :bprevious <CR>


" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
