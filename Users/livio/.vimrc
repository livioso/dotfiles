set nocompatible
set shell=/bin/bash

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive' " => vim-fugitive before vim-airline!
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'vim-airline/vim-airline-themes'
Plug 'livioso/neosnippet-snippets'
Plug 'othree/es.next.syntax.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'Keithbsmiley/swift.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'Shougo/neoinclude.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'jparise/vim-graphql'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'rizzatti/dash.vim'
Plug 'sheerun/yajs.vim'
Plug 'tpope/vim-repeat'
Plug 'wincent/terminus'

" not sure about this one yet :)
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/goyo.vim'
Plug 'ekalinin/Dockerfile.vim'

Plug 'ElmCast/elm-vim'
  let g:elm_setup_keybindings = 0

Plug 'wincent/loupe'
  let g:LoupeClearHighlightMap=0

Plug 'chriskempson/base16-vim'
  let base16colorspace = 256

Plug 'mxw/vim-jsx'
  let g:jsx_ext_required = 0 " Allow JSX in normal JS files

Plug 'elzr/vim-json'
  let g:vim_json_syntax_conceal = 0

Plug 'terryma/vim-expand-region'
  vmap v <Plug>(expand_region_expand)
  vmap <C-v> <Plug>(expand_region_shrink)

Plug 'Shougo/neosnippet'
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  smap <expr><TAB> neosnippet#expandable_or_jumpable()
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

Plug 'tyru/open-browser.vim'
  let g:netrw_nogx = 1 " disable netrw's gx mapping.
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

Plug 'Shougo/unite.vim'
  let g:unite_data_directory='~/.config/nvim/.cache/unite'
  let g:unite_source_rec_max_cache_files=10000
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts =
    \ '-i --vimgrep --hidden --ignore ' .
    \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_prompt = ' ‣‣ '
  let g:unite_winheight = 15
  let g:unite_split_rule = 'botright'
  " Unite // overwrite settings.
  autocmd FileType unite call s:unite_my_settings()
  function! s:unite_my_settings() "
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <silent><buffer><expr> <C-s> unite#do_action('split')
    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  endfunction
  nnoremap <space>/ :Unite grep:.<CR>
  nnoremap <space>h :Unite history/yank -default-action=append<CR>
  nnoremap <C-p> :Unite
    \ -prompt-direction="top"
    \ -winheight=8 -auto-resize
    \ -start-insert file_rec/git <CR>

Plug 'Shougo/deoplete.nvim'
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#disable_auto_complete = 0
  let g:deoplete#max_list = 5
  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"

Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
  let g:tern_show_signature_in_pum = 1
  let g:tern_show_argument_hints = 'on_hold'
  autocmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd FileType javascript map <buffer> gd :TernDef<CR>
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

Plug 'vim-airline/vim-airline'
  let g:airline_detect_spell=0 " changes mode from N > SPELL => N
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#fnamemod = ':f'
  let g:airline#extensions#hunks#non_zero_only = 1
  let g:airline_section_z = "%l·%c"
  let g:airline_section_y = ""
  let g:airline_section_x = "%P"
  let g:airline_section_c = "%t %m"
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
  let g:neomake_javascript_eslint_exe = './node_modules/eslint/bin/eslint.js'
  let g:neomake_javascript_enabled_makers = ['eslint, flow']
  let g:neomake_open_list = 0
call plug#end()

" Unite -> this must be after plug#end!
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Depplete -> favour buffer over everything
call deoplete#custom#set('buffer', 'rank', 9999)

" General settings
set t_Co=256
set background=dark
" one of my all time favourites
" colorscheme base16-eighties
colorscheme base16-oceanicnext
set backspace=indent,eol,start
set emoji
set mouse=a " use mouse 😬
set number
language C " LC=C where C is default
set relativenumber
set viminfo='1000,<500,:500,/500
set history=1000
set undolevels=1000
set cmdheight=4
set foldcolumn=0
set scrolloff=5
set sidescroll=1
set noshowmode
set nowrap
set hidden
syntax on

" disable preview scratch
set completeopt-=preview

" pastetoggle
set pastetoggle=<F2>

" highlight
set highlight+=N:ColorColumn    " make current line number stand out a little
set highlight+=@:DiffText

" no need for it ~
set nobackup
set noswapfile

" show command completion
set wildmenu
set wildignore+=*/node_modules/*

" netrw show tree view
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

" disable all bells
set belloff=all
set noerrorbells " no beep on error
set novisualbell " no flashing screen on error
set t_vb=        " no beep on <ESC>

" smart join comments (with j)
set formatoptions+=j

" set leader key to space
let mapleader = "\<Space>"

" indentation settings
set autoindent
filetype plugin indent on

" trailing whitespaces
set list listchars+=trail:•
set list listchars+=tab:\ \ 
set list listchars+=extends:»

" seems to be faster (scrolling)
set lazyredraw
set noshowcmd

" tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" status line settings
set laststatus=2 " always show the statusline

" searching settings
set incsearch   " incremental search
set ignorecase  " ignore case in search
set smartcase   " except we write it BOLD then don't ignore case
nnoremap <silent> <CR> :nohlsearch <CR> " clear search on when hitting return

" use very magic setting for search
nnoremap / /\v
vnoremap / /\v

" in the quick fix window, <CR> is used to jump to the
" error under the cursor, so redefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" automatically resize splits equally on resize
autocmd VimResized * execute "normal \<C-w>="
set fillchars=vert:┃
hi VertSplit ctermbg=NONE guibg=NONE

" gf add .js suffix for modules
set suffixesadd+=.js

" split view settings
set splitbelow " open below instead of above
set splitright " open right instead of left

" navigate split easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" folding setting using za, zm and zr
nnoremap <Tab> za         " toggle fold at current position
set foldmethod=indent     " fold based on indent (faster than syntax)
set foldlevel=99
set fillchars+=fold:\ 

" enable spell checker
set spell

" jump to tag
nnoremap T <C-]>
nnoremap gt g<C-]>

" allow the . to execute once
" for each line of a visual selection
vnoremap . :normal .<CR>

" remove startup message
set shortmess+=I

" hide toolbar
set showtabline=0
set tabpagemax=0

" printing options (print using :hardcopy)
set printoptions=portrait:n "landscape

" threat eslintrc as JSON
autocmd BufNewFile,BufRead .eslintrc set ft=json

" jump to last cursor position unless
" it is invalid in a event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" replace X with Y: SX/Y<CR>
nmap S :%s//gc<LEFT><LEFT><LEFT>

" use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
else
  echohl ErrorMsg
  echomsg 'Missing ag: install ag'
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

" trim trailing whitespaces
function! _TrimWhiteSpace()
  %s/\s\+$//e
endfunction

" appends // TODO (livioso 12.05.2016)
function! Todo()
  let today = strftime("// TODO (livioso %d.%m.%Y) ")
  exe "normal a". today
endfunction
command! Todo :call Todo()

function! Fixme()
  let today = strftime("// FIXME (livioso %d.%m.%Y) ")
  exe "normal a". today
endfunction
command! Fixme :call Fixme()

" !npm run lint:fix and :w
function! Lint()
  echom ">>> lint:fix started. 🐒"
  exe '!npm run lint:fix'
endfunction
command! Lint :call Lint()

" generate tags (jsctags)
nnoremap <silent> tags :!find . -type f -iregex .*\.js$
  \ -not -path "./node_modules/*" -exec jsctags {} -f \;
  \ \| sed '/^$/d' \| sort > tags & <CR>

" I always seem to write Wq instead of wq 
command Wq wq

" copy and paste from system clipboard
" with <leader>y and <leader>p
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" personal <Leader> mappings
map <Leader>w :w <CR>
map <Leader>f <C-w><C-w>
map <Leader>j <C-p>
map <Leader>v :vsplit .<CR>
map <Leader>q :q <CR>
map <Leader>erc :e ~/.vimrc <CR>
map <Leader>src :source ~/.vimrc <CR>
map <Leader>n :lnext<CR>
map <Leader>b <C-i> <CR>
map <Leader>n <C-o> <CR>
map <Leader>dbg odebugger;<ESC>
map <Leader>todo :Todo <CR>
map <Leader>fixme :Fixme <CR>
map <Leader>nomut A // eslint-disable-line immutable/no-mutation<ESC>
map <Leader>noexp A // eslint-disable-next-line import/prefer-default-export<ESC>
map <Leader>li :Lint <CR>
map <Leader>rd :redraw! <CR>

" limelight and goyo
map <Leader>g :Goyo <CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
map <Leader>ll :Limelight!! <CR>

" toggle dark / light
command Light :set background=light
command Dark :set background=dark

" NeomMake temporary solution see https://github.com/neomake/neomake/pull/248
so ~/.fixNeoMakeDefaults.vim
call NeoMakeDefaults()
let g:neomake_error_sign = { 'text': "●", 'texthl': 'NeomakeErrorDefault' }
let g:neomake_warning_sign = { 'text': "●", 'texthl': 'NeomakeWarningDefault' }
let g:neomake_informational_sign = { 'text': "●", 'texthl': 'NeomakeInformationDefault' }
let g:neomake_message_sign = { 'text': "●", 'texthl': 'NeomakeMessageDefault' }

" FIXME (livioso 29.09.2016) this all seems fixed! :)
" No more need for it => if so delete all this shit.
" set termguicolors
" for some reason this
" is not set properly. :(
" hi Normal guibg = 3b3b3b

