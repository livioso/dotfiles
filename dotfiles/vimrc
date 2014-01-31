" General settings
set nocompatible
set hidden
set lazyredraw
set langmenu=en_US.UTF-8
set showtabline=2 " always show tabs

" Bells
set noerrorbells " no beep on error
set t_vb=        " no beep on <ESC>
set novisualbell " no flashing screen on error

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Move a line of text using ALT+[jk]
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Statusline
" set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2 " allways show the statusline
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(Line\ %l,\ Column\ %c%)\ (%P)

" Searching
set hlsearch        " underline search results
set ignorecase      " ignore case in search
set incsearch       " incremental search
nnoremap <cr> :nohlsearch<cr> " clear search on when hitting return

" Jump to last cursor position unless it's invalid in a event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" Look and feel settings
if has("gui_running")
  if has("gui_gtk2")
    " We are on linux
    set guifont=Inconsolata\ Bold\ 12
  endif
  if has("gui_win32")
    " We are on windows
    set guifont=Consolas:h12:cANSI
  endif
endif

set number          " show line numbers
set scrolloff=10    " cursor - scroll offset
set cursorline
set guicursor+=a:blinkon0
set background=dark
colorscheme ir_black " solorized
syntax enable

" Command input settings
set cmdheight=4
set showcmd
set wildmenu " show command completion
set wildmode=longest,list,full
set history=600

" Show a line after character 80
set colorcolumn=80
highlight ColorColumn guibg=grey7
highlight CursorLineNr guifg=white guibg=grey7 gui=bold
" Folding setting using za, zm and zr
set foldmethod=indent "fold based on indent
set foldnestmax=10    "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1       "this is just what i use

" Tabs, spaces and indention
set smartindent
set tabstop=2
set softtabstop=2 " insert 2 spaces for one tab
set shiftwidth=2
set expandtab

" Adjust tabs coloring
hi TabLine      guifg=white guibg=grey7 gui=none
hi TabLineFill  guifg=grey20 guibg=grey20 gui=underline
hi TabLineSel   guifg=white guibg=grey7 gui=bold
hi Title        guifg=white guibg=grey7 gui=bold

" Do highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Do enable Doxygen highlighting
set langmenu=en_US.UTF-8

" Moving between open splits by using j and k
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" I would like to see the little history
" windows for search and commands always
nnoremap : q:i
nnoremap / q/i


" Settings related to GVIM
set sessionoptions+=resize,winpos
set guioptions-=T " remove toolbar
set guioptions-=r " remove scrollbar
set guioptions-=e " remove tabs from gvim

" don't scroll up an down using
" the arrow keys => do it the vim way ;-)
noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>

" Change between cpp and h files in C++
map <A-o> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" CommmandT improvments
set wildignore+=*.o,*.obj,.git
let g:CommandTMaxHeight=15

" Mapleader ',' is easier than default
" e.g. ,t (CommmandT)
let mapleader = ","
