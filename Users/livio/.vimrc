set nocompatible
set shell=/bin/bash

" Vim Plug (https://github.com/junegunn/vim-plug)
if empty(glob("~/.vim/autoload/plug.vim"))
  execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Order is important
" vim-fugitive before vim-airline!
call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'godlygeek/tabular'
Plug 'Keithbsmiley/swift.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils' "required by garbas/vim-snipmate
Plug 'tomtom/tlib_vim' "required by garbas/vim-snipmate
Plug 'honza/vim-snippets' "required by garbas/vim-snipmate
call plug#end()

" Setup vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_z="%L Lines : %P"
let g:airline_section_y="Line\ %l\ : Column\ %c%)"
let g:airline_section_x="[%{&ff} : %{strlen(&fenc)?&fenc:'none'}]"
let g:airline#extensions#tabline#fnamemod = ':t'
" Setup Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Setup Ctrl + P
let g:ctrlp_show_hidden = 1
" Setup SnipMate (<tab> used by ycm use <ss>)
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" General settings
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256
set background=dark
colorscheme base16-ocean
set backspace=indent,eol,start
set mouse=a " use mouse :)
set langmenu=en_US.UTF-8
set number
set history=1000
set undolevels=1000
set cmdheight=8
set scrolloff=4
set nowrap
syntax on

" no need for it ~
set nobackup
set noswapfile

" show command completion
set wildmenu
set wildignore+=*/node_modules/*

" netrw show tree view
let g:netrw_liststyle=3

" disable all bells
set noerrorbells " no beep on error
set t_vb=        " no beep on <ESC>
set novisualbell " no flashing screen on error

" set leader key to comma
let mapleader = ","

" indentation settings
set autoindent
filetype plugin indent on

" tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" status line settings
set laststatus=2 " always show the statusline

" searching settings
set ignorecase  " ignore case in search
set incsearch   " incremental search
nnoremap <cr> :nohlsearch<cr> " clear search on when hitting return

" buffer settings
nnoremap gp :bp<CR> " move to the previous buffer with gp
nnoremap gn :bn<CR> " move to the next buffer with gn

" folding setting using za, zm and zr
set foldmethod=indent "fold based on indent
set foldnestmax=10    "deepest fold is 10 levels
set nofoldenable      "dont fold by default
set foldlevel=1       "this is just what i use

" scroll 4x faster
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

" remove annoying startup message
set shortmess+=I

if has("gui_running")
  set guifont=Inconsolata\ zi4\ bold:h18
  set guitablabel=%t
  set guioptions-=r
  set cursorline
  set fullscreen
  set vb t_vb=
  highlight NonText ctermfg=bg guifg=bg
endif

" printing options (print using :hardcopy)
set printoptions=portrait:n "landscape

" jump to last cursor position unless
" it is invalid in a event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" trim trailing whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
