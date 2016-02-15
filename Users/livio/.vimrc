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
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'Keithbsmiley/swift.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils' "required by garbas/vim-snipmate
Plug 'tomtom/tlib_vim' "required by garbas/vim-snipmate
Plug 'honza/vim-snippets' "required by garbas/vim-snipmate
Plug 'justinj/vim-react-snippets'
Plug 'mxw/vim-jsx'
Plug 'sheerun/yajs.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'othree/es.next.syntax.vim'
Plug 'terryma/vim-expand-region'
Plug 'elzr/vim-json'
Plug 'benekastah/neomake'
call plug#end()

" Setup vim airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':f'
let g:airline_section_z="%l:%c"
let g:airline_section_y=""
let g:airline_section_x="%P"
let g:airline_section_c="%t %m"
let g:airline_left_sep=''
let g:airline_right_sep=''
" Setup NeoMake
autocmd! BufWritePost,BufWinEnter * Neomake
let g:neomake_javascript_enabled_makers= ['eslint']
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_open_list = 0
let g:neomake_error_sign = {
  \ 'text': '❯❯',
  \ 'texthl': 'ErrorMsg',
  \ }
highlight myWarningMsg ctermbg=0 ctermfg=3
let g:neomake_warning_sign = {
  \ 'text': '❯❯',
  \ 'texthl': 'myWarningMsg',
  \ }
" Setup Ctrl + P
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_mruf_last_entered = 1
" Setup SnipMates(<tab> used by ycm use <ss>)
imap <C-J> <esc>a<Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger
" Setup vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
" Setup vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" Setup vim-json
let g:vim_json_syntax_conceal = 0

" General settings
let base16colorspace=256 " Access colors present in 256 colorspace
set t_Co=256
set background=dark
colorscheme base16-eighties
set backspace=indent,eol,start
set mouse=a " use mouse :)
set langmenu=en_US.UTF-8
set number
set history=1000
set undolevels=1000
set cmdheight=5
set foldcolumn=0
set scrolloff=4
set nowrap
syntax on

" highlight current line
set cursorline
hi CursorLineNr cterm=Bold ctermfg=Blue

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

" set leader key to space
let mapleader = "\<Space>"

" indentation settings
set autoindent
filetype plugin indent on

" trailing whitespaces
set list listchars=trail:·

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
nnoremap <CR> :nohlsearch <CR> " clear search on when hitting return

" in the quickfix window, <CR> is used to jump to the
" error under the cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" buffer settings
nnoremap gp :bp<CR> " move to the previous buffer with gp
nnoremap gn :bn<CR> " move to the next buffer with gn

" split view settings
set splitbelow " open below instead of above
set splitright " open right instead of left

" folding setting using za, zm and zr
set foldmethod=indent "fold based on indent
set foldnestmax=10    "deepest fold is 10 levels
set nofoldenable      "dont fold by default
set foldlevel=1       "this is just what i use

" scroll up / down fast(er) using ctrl+(jk)
nnoremap <C-j> 4<C-e>
nnoremap <C-k> 4<C-y>

" enable spellchecking for markdown
autocmd BufRead,BufNewFile *.md setlocal spell

" personal <Leader> mappings
map <Leader>w :w <CR>
map <Leader>f <C-w><C-w>
map <Leader>j <C-p>
map <Leader>v :vsplit .<CR>
map <Leader>q :q <CR>
map <Leader>erc :e ~/.vimrc <CR>
map <Leader>src :source ~/.vimrc <CR>
map <Leader>n :lnext<CR>

" search for word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" jump to tag
nnoremap t <C-]>

" copy and paste from system clipboard
" with <leader>y and <leader>p
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" remove startup message
set shortmess+=I

" hide toolbar
set showtabline=0
set tabpagemax=0

" printing options (print using :hardcopy)
set printoptions=portrait:n "landscape

" jump to last cursor position unless
" it is invalid in a event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" saving read only files (sudo tee trick)
cmap w!! w !sudo tee % >/dev/null

" use SX/Y<CR>
nmap S :%s//g<LEFT><LEFT>

" use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " ag for ctrlp / fast enough. need to cache
  let g:ctrlp_user_command = 'ag %s -l -g ""'
  let g:ctrlp_use_caching = 0
else
  echohl ErrorMsg
  echomsg 'Missing ag: brew install ag'
  echohl NONE<Paste>
endif

" trim trailing whitespaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction

function! BeautifyJson()
  %!python -m json.tool
endfunction

