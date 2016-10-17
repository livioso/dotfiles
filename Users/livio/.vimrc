set shell=/bin/bash

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-fugitive' " => vim-fugitive before vim-airline!
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'vim-airline/vim-airline-themes'
Plug 'livioso/neosnippet-snippets'
Plug 'othree/es.next.syntax.vim'
Plug 'gavocanov/vim-js-indent'
Plug 'ekalinin/Dockerfile.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'airblade/vim-gitgutter'
Plug 'Keithbsmiley/swift.vim'
Plug 'junegunn/limelight.vim'
Plug 'elixir-lang/vim-elixir'
Plug 'Shougo/neoinclude.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'jparise/vim-graphql'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'sheerun/yajs.vim'
Plug 'tpope/vim-repeat'
Plug 'wincent/terminus'

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
  nnoremap <C-p> :Unite
    \ -prompt-direction="top"
    \ -winheight=7 -auto-resize
    \ -start-insert file_rec/git <CR>

Plug 'Shougo/deoplete.nvim'
  " let g:deoplete#sources._ = ['buffer', 'tag']
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#disable_auto_complete = 0
  let g:deoplete#max_list = 5
  inoremap <silent><expr> <Tab>
    \ pumvisible() ? "\<C-n>" : "\<TAB>"

Plug 'vim-airline/vim-airline'
  let g:airline_detect_spell=0 " changes mode from N > SPELL => N
  let g:airline#extensions#tabline#enabled = 0
  let g:airline#extensions#tabline#fnamemod = ':f'
  let g:airline#extensions#hunks#non_zero_only = 1
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
  let g:neomake_javascript_eslint_exe = './node_modules/eslint/bin/eslint.js'
  let g:neomake_javascript_enabled_makers = ['eslint, flow']
  let g:neomake_open_list = 0

call plug#end()

" Unite -> this must be after plug#end!
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])

" Depplete -> favour buffer over everything
call deoplete#custom#set('buffer', 'rank', 9999)


" I always seem to write Wq instead of wq 

" General settings
set background=dark
colorscheme base16-oceanicnext    " also nice: base16-eighties
language C                        " LC=C where C is default
command! Wq wq                     " map Wq => wq
set backspace=indent,eol,start
set emoji
set mouse=a " use mouse 😬
set relativenumber
set number
set viminfo='1000,<500,:500,/500
set history=1000
set undolevels=1000
set cmdheight=4
set foldcolumn=0
set scrolloff=5
set sidescrolloff=5
set sidescroll=1
set noshowmode
set nowrap
set hidden
syntax on

" recursively look for files (e.g. :find)
set path+=**

" disable preview scratch
set completeopt-=preview

" pastetoggle
set pastetoggle=<F2>

" highlight
set highlight+=N:ColorColumn    " make current line number stand out a little
set highlight+=@:DiffText

" block selection even if line is long enough
set virtualedit=block

" no need for it ~
set nobackup
set noswapfile

" show command completion
set wildmenu
set wildignore+=*/node_modules/*

" Netrw show tree view
let g:netrw_liststyle = 3
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_preview = 1   "(p)review on vertical split
let g:netrw_winsize = 40
let g:netrw_alto = 0
let g:netrw_browsex_viewer = '-'

" disable all bells
set belloff=all
set noerrorbells " no beep on error
set novisualbell " no flashing screen on error

" smart join comments (with j)
set formatoptions+=j  " remove comment when joining lines
set nojoinspaces      " always append one space instead of 2

" set leader key to space
let mapleader = "\<Space>"

" indentation settings
set autoindent
filetype plugin indent on

" trailing white spaces
set list listchars+=trail:•
set list listchars+=tab:\ \ 

" faster scrolling)
set lazyredraw
set noshowcmd

" tab settings
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" status line settings
set laststatus=2 " always show the status line

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

" split view separator
highlight VertSplit ctermbg=NONE guibg=NONE
set fillchars=vert:│

" add .js suffix for modules (enables gf)
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
nnoremap <Tab> za       " toggle fold at current position
set foldmethod=indent   " fold based on indent (faster)
set foldlevel=99
set fillchars+=fold:\ 

" spell checker
set spell " enable checking
set spellcapcheck= " e.g. Choo => choo => same

" jump to tag
nnoremap T <C-]>
nnoremap gt *g<C-]>

" allow the . to execute once
" for each line of a visual selection
vnoremap . :normal .<CR>

" messages
set shortmess+=I " remove startup message
set shortmess+=w " [w] instead of written

" hide tool bar
set showtabline=0
set tabpagemax=0

" printing options (print using :hardcopy)
set printoptions=portrait:n "landscape

" threat eslintrc as JSON
autocmd BufNewFile,BufRead .eslintrc set ft=json

" jump to last cursor position when reopening file
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

" <Leader> mappings
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
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
map <Leader>til :Til <CR>
map <Leader>date :Date <CR>
map <Leader>nomut A // eslint-disable-line immutable/no-mutation<ESC>
map <Leader>noexp A // eslint-disable-next-line import/prefer-default-export<ESC>
map <Leader>li :Lint <CR>
map <Leader>rd :redraw! <CR>
map <Leader>ll :Limelight!! <CR>
map <Leader>g gt
map <Leader>r :UniteResume <CR>

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

function! Til()
  let today = strftime("Updated %d.%m.%Y ")
  exe "normal a". today
endfunction
command! Til :call Til()

function! Date()
  let today = strftime(" %d.%m.%Y ")
  exe "normal a". today
endfunction
command! Date :call Date()

" !npm run lint:fix and :w
function! Lint()
  echom ">>> lint:fix started. 🐒"
  exe '!npm run lint:fix'
endfunction
command! Lint :call Lint()

" toggle dark / light
command! Light :set background=light
command! Dark :set background=dark

" minor color tweaks: search
highlight Search cterm=NONE ctermfg=black ctermbg=lightgrey
highlight IncSearch cterm=NONE ctermfg=black ctermbg=lightgreen
highlight EndOfBuffer ctermfg=black ctermbg=black

" ---------------------------------------------------------------------------------------

" Neomake temporary solution see https://github.com/neomake/neomake/pull/248
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

" TODO (livioso 15.10.2016) Not used anymore, do I miss it?
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
"   let g:tern_show_signature_in_pum = 1
"   let g:tern_show_argument_hints = 'on_hold'
"   autocmd FileType javascript setlocal omnifunc=tern#Complete
"   autocmd FileType javascript map <buffer> gd :TernDef<CR>
"   autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" " generate tags (jsctags)
" nnoremap <silent> tags :!find . -type f -iregex .*\.js$
"   \ -not -path "./node_modules/*" -exec jsctags {} -f \;
"   \ \| sed '/^$/d' \| sort > tags & <CR>
