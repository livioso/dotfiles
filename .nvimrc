set shell=/bin/bash

call plug#begin('~/.vim/plugged')
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'tpope/vim-fugitive' " => vim-fugitive before vim-airline!
Plug 'vim-airline/vim-airline-themes'
Plug 'othree/es.next.syntax.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'ekalinin/Dockerfile.vim'
Plug 'junegunn/limelight.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'junegunn/vim-peekaboo'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'robbles/logstash.vim'
Plug 'jparise/vim-graphql'
Plug 'zchee/deoplete-jedi'
Plug 'wellle/targets.vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'uarun/vim-protobuf'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/yajs.vim'
Plug 'tpope/vim-repeat'
Plug 'wincent/terminus'
Plug 'benmills/vimux'
Plug 'dag/vim-fish'

" trail
Plug 'machakann/vim-highlightedyank'
  let g:highlightedyank_highlight_duration = 150

Plug 'maxmellon/vim-jsx-pretty'
  let g:vim_jsx_pretty_colorful_config = 1

Plug 'SirVer/ultisnips'
  let g:UltiSnipsExpandTrigger="<c-l>"
  let g:UltiSnipsJumpForwardTrigger="<c-k>"
  let g:UltiSnipsJumpBackwardTrigger="<c-j>"

Plug 'airblade/vim-gitgutter'
  let g:gitgutter_realtime = 1
  let g:gitgutter_eager = 1

Plug 'ElmCast/elm-vim'
  let g:elm_setup_keybindings = 0

Plug 'wincent/loupe'
  let g:LoupeClearHighlightMap = 0

Plug 'chriskempson/base16-vim'
  let base16colorspace = 256

Plug 'elzr/vim-json'
  let g:vim_json_syntax_conceal = 0

Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)

Plug 'tyru/open-browser.vim'
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

Plug 'junegunn/fzf',
  \ { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'
  let $FZF_DEFAULT_COMMAND = 'ag -g ""'
  let g:fzf_layout = { 'down': '~25%' }
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Exception'],
    \ 'fg+':     ['fg', 'Normal', 'Normal', 'Normal'],
    \ 'bg+':     ['bg', 'Exception', 'Normal'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'Keyword'],
    \ 'prompt':  ['fg', 'Exception'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

    function! s:fzf_statusline()
      setlocal statusline=\ 
    endfunction

    autocmd! User FzfStatusLine call <SID>fzf_statusline()

Plug 'vim-airline/vim-airline'
  let g:airline_detect_spell=0 " changes mode from N > SPELL => N
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#fnamemod = ':f'
  let g:airline#extensions#hunks#enabled = 0
  let g:airline#extensions#hunks#non_zero_only = 0
  let g:airline_powerline_fonts = 1
  let g:airline_symbols = { 'notexists': '' }
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#branch#format = 0
  let g:airline_section_warning = ''
  let g:airline_section_error = ''
  let g:airline_section_z = "%l·%c"
  let g:airline_section_y = ""
  let g:airline_section_x = "%P"
  let g:airline_section_c = "%f %m"
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

Plug 'benekastah/neomake'
  autocmd! BufWritePost,BufWinEnter * silent Neomake
  autocmd BufWritePost *.js silent Neomake eslint
  let g:neomake_error_sign = { 'text': "●" }
  let g:neomake_warning_sign = { 'text': "●" }
  let g:neomake_informational_sign = { 'text': "●" }
  let g:neomake_message_sign = { 'text': "●" }
  let g:neomake_javascript_eslint_exe = './node_modules/eslint/bin/eslint.js'
  let g:neomake_javascript_enabled_makers = ['eslint, flow']
  let g:neomake_open_list = 0

if has('nvim')
  Plug 'Shougo/deoplete.nvim'
    " let g:deoplete#sources._ = ['buffer', 'tag']
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#disable_auto_complete = 0
    let g:deoplete#max_list = 10
    inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"
endif

call plug#end()

" General settings
set background=dark
colorscheme base16-oceanicnext    " also nice: base16-eighties
language C                        " LC=C where C is default
command! Wq wq                    " map Wq => wq
let mapleader = "\<Space>"        " set leader key to space
set mouse=a                       " a = all
set updatetime=250                " snappier UI updates (git, etc.)
set number                        " works also with set relativenumber
set regexpengine=1                " older but faster engine
set timeoutlen=500                " don't wait long next key press (ambiguous leader situations)
set path+=**                      " recursively look for files (e.g. :find)
set completeopt-=preview          " disable preview scratch
set virtualedit=block             " block selection even if line is not long enough
set laststatus=2                  " always show the status line
set inccommand=nosplit            " live preview substitution
set nobackup
set noswapfile
set backspace=indent,eol,start
set emoji
set history=1000
set cmdheight=4
set foldcolumn=0
set scrolloff=5
set sidescrolloff=5
set sidescroll=1
set noshowmode
set nowrap
set hidden
syntax on

"           ┌── Disable hlsearch while loading viminfo
"           │   ┌── Remember marks for last 500 files
"           │   │     ┌── Remember up to 10000 lines in each register
"           │   │     │     ┌── Remember up to 1MB in each register
"           │   │     │     │     ┌── Remember last 1000 search patterns
"           │   │     │     │     │     ┌── Remember last 1000 commands
"           │   │     │     │     │     │
set viminfo=h,'1000,<1000,s1000,/1000,:1000

" persistent undo
set undodir=~/.vimundo/
set undolevels=5000
set undofile

" show command completion
set wildmenu
set wildignore+=*/node_modules/*

" netrw show tree view
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_preview = 1   "(p)review on vertical split
let g:netrw_winsize = 40
let g:netrw_alto = 0

" disable all bells
set belloff=all
set noerrorbells " no beep on error
set novisualbell " no flashing screen on error

" smart join comments (with j)
set formatoptions+=j  " remove comment when joining lines
set nojoinspaces      " always append one space instead of 2

" indentation settings
set autoindent
filetype plugin indent on

" trailing white spaces
set list listchars+=trail:•
set list listchars+=tab:\›\ 

" faster scrolling
set lazyredraw
set noshowcmd

" tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" searching settings
set incsearch   " incremental search
set ignorecase  " ignore case in search
set smartcase   " except we write it BOLD then don't ignore case

" split view separator
highlight VertSplit ctermbg=NONE guibg=NONE
set fillchars=vert:│

" add .js suffix for modules (enables gf)
set suffixesadd+=.js

" split view settings
set splitbelow " open below instead of above
set splitright " open right instead of left

" folding setting (za, zm and zr)
set foldmethod=indent
set foldlevel=99
set fillchars+=fold:\ 

" spell checker
set spell " enable checking
set spellcapcheck= " e.g. Choo => choo => same

" messages
set shortmess+=I " remove startup message
set shortmess+=w " [w] instead of written

" hide tool bar
set showtabline=0
set tabpagemax=0

" printing options (print using :hardcopy)
set printoptions=portrait:n "landscape

" clear search on when hitting return
nnoremap <silent> <CR> :nohlsearch <CR>
" → except when in the quick fix window, <CR> is used to jump
" to the file under the cursor, so redefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" → and except when we are in command line history, <CR>
" is used to run the command under cursor (q:, q/ etc.)
autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

" automatically resize splits equally on resize
autocmd VimResized * execute "normal \<C-w>="

" treat .fishrc as fish
autocmd BufNewFile,BufRead .fishrc
  \ set filetype=fish

" treat eslintrc as JSON
autocmd BufNewFile,BufRead .eslintrc
  \ set filetype=json

" treat .docker as Dockerfile
autocmd BufNewFile,BufRead *.docker
  \ set filetype=dockerfile

" jump to last cursor position when
" reopening file, except if gitcommit
autocmd BufReadPost *
  \ if line("'\"") > 0
  \ && line("'\"") <= line("$")
  \ && &filetype != "gitcommit" |
  \   exe "normal g`\"" |
  \ endif

" let self keyword in python stand out a bit
autocmd FileType python
  \   syn keyword pythonSelf self
  \ | highlight def link pythonSelf Special

" replace X with Y: SX/Y<CR>
nmap S :%s//gc<LEFT><LEFT><LEFT>

" jump to tag
nnoremap T <C-]>
nnoremap gt *g<C-]>

" allow the . to execute once
" for each line of a visual selection
vnoremap . :normal .<CR>

" see :help scroll-insert
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

" because fuck you K
map K <nop>

" <Leader> mappings
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
map <Leader>u :w <CR>
map <Leader>w :w <CR>
map <Leader>f :Buffers <CR>
map <Leader><Leader> <C-w><C-p>
map <Leader>v :vsplit .<CR>
map <Leader>t :vsplit <CR><ESC> :terminal<CR>
map <Leader>q :q <CR>
map <Leader>src :source ~/.vimrc <CR>
map <Leader>erc :e ~/.dotfiles/.nvimrc <CR>
map <Leader>etc :e ~/.dotfiles./.tmux.conf <CR>
map <Leader>efc :e ~/.dotfiles/.fishrc <CR>
map <Leader>n :lnext<CR>
map <Leader>todo :Todo <CR>
map <Leader>fixme :Fixme <CR>
map <Leader>til :Til <CR>
map <Leader>date :Date <CR>
map <Leader>dnl O// eslint-disable-next-line
map <Leader>li :Lint <CR>
map <Leader>rd :redraw! <CR>
map <Leader>ll :Limelight!! <CR>
map <Leader>b :VimuxRunLastCommand <CR>
map <Leader>g gt
map <silent> <Leader>j :GFiles <CR>
map <silent> <Leader>J :FZF <CR>
map <silent> <Leader>/ :Ag <CR>
map <silent> <Leader>ag :Ag <CR>
map <silent> <Leader>* * :exec 'Ag' expand('<cword>') <CR>
map <silent> <F12> :BuildCTags <CR>
imap <silent> '' `
imap <silent> jj <ESC> <CR>

" use abbreviations to fix
" common spelling mistakes
iabbrev mispell misspell
iabbrev prodcut product

" Functions
"
" trim trailing white spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
command! TrimWhiteSpace :call TrimWhiteSpace()

function! Todo()
  let today = strftime("TODO (livioso %d.%m.%Y) ")
  exe "normal o". today
  exe "normal gcc"
  exe "normal A"
endfunction
command! Todo :call Todo()

function! Fixme()
  let today = strftime("FIXME (livioso %d.%m.%Y) ")
  exe "normal o". today
  exe "normal gcc"
  exe "normal A"
endfunction
command! Fixme :call Fixme()

function! Date()
  let today = strftime(" %d.%m.%Y ")
  exe "normal a". today
endfunction
command! Date :call Date()

function! LastGitCommit()
  let hash = system("git log --oneline | head -n1 | awk '{print $1}'")
  exe "normal a". hash
endfunction
command! LastGitCommit :call LastGitCommit()

function! BuildCTags()
  exe ':!/usr/local/bin/ctags -R $PWD -o=$PWD/tags --exclude=.git --exclude=node_modules --python-kinds=-iv'
endfunction
command! BuildCTags :call BuildCTags()

function! PrettyPrintJSON()
  exe '%!python -m json.tool'
endfunction
command! PrettyPrintJSON :call PrettyPrintJSON()

function! SafariTab()
  let tab = system('osascript -e "tell application \"Safari\" to return URL of document 1"')
  exe "normal a". tab
endfunction
command! SafariTab :call SafariTab()

" minor color tweaks: search coloring
highlight Search cterm=NONE ctermfg=black ctermbg=lightgrey
highlight IncSearch cterm=NONE ctermfg=black ctermbg=lightgreen
highlight EndOfBuffer ctermfg=black ctermbg=black

" use rg over grep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
else
  echohl ErrorMsg
  echomsg 'Missing rg: install rg'
  echohl NONE<Paste>
endif

" different cursor in insert / normal mode (iTerm)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if !has('nvim')
  set nolist
endif

if has('nvim')
  " deoplete -> favour buffer over everything
  call deoplete#custom#set('buffer', 'rank', 9999)
endif
