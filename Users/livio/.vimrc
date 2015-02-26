set nocompatible
set shell=/bin/bash

" Vim Plug (https://github.com/junegunn/vim-plug)
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
" Plug 'airblade/vim-gitgutter'
" Plug 'tpope/vim-fugitive'
call plug#end()

" Enable vim airline
let g:airline#extensions#tabline#enabled = 1

" Syntastic (recommended settings)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"

" General settings
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256
set background=dark
colorscheme base16-ocean
set backspace=indent,eol,start
set mouse=a " use mouse :)
set langmenu=en_US.UTF-8
set number
set history=600
set cmdheight=4
syntax on

" no need for it ~
set nobackup
set noswapfile

" show command completion
set wildmenu

" netrw show tree view
let g:netrw_liststyle=3

" disable all bells
set noerrorbells " no beep on error
set t_vb=        " no beep on <ESC>
set novisualbell " no flashing screen on error

" tab settings
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2

" just show file name in tab
let &titlestring = @%
set title

" status line settings
set laststatus=2 " always show the statusline
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(Line\ %l,\ Column\ %c%)\ (%P)

" searching settings
set ignorecase  " ignore case in search
set incsearch   " incremental search
nnoremap <cr> :nohlsearch<cr> " clear search on when hitting return

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
	set guifont=Source\ Code\ Pro:h19
	set guitablabel=%t
	set cursorline
	" set transparency=2
	highlight NonText ctermfg=bg guifg=bg
endif

" jump to last cursor position unless
" it is invalid in a event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
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
