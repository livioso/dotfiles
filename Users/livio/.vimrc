set nocompatible
set langmenu=en_US.UTF-8
syntax on
set number
set history=600
set cmdheight=3

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
	colorscheme spacegray
	set guifont=Source\ Code\ Pro:h19
	set cursorline
	set transparency=2
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
