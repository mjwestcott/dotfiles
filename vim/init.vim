"------------------------------------------------------------------------------
" init.vim by Matt Westcott (mattwestcott.co.uk)

set nocompatible

"------------------------------------------------------------------------------
" vim-plug

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'github/copilot.vim'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
call plug#end()

"------------------------------------------------------------------------------
" General Settings

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set background=dark
colorscheme yellow

filetype plugin indent on
syntax on

let g:terminal_ansi_colors = [
\ "#282828",
\ "#fb5f4d",
\ "#98971a",
\ "#d79921",
\ "#83a598",
\ "#b16286",
\ "#689d6a",
\ "#d5c4a1",
\ "#928374",
\ "#fc7566",
\ "#b8bd26",
\ "#fabd2f",
\ "#92b0a4",
\ "#d3869b",
\ "#8ec07c",
\ "#ebdbb2",
\]

" Cursor styles
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[0 q"

if has("gui_running")
    set transp=2
    set linespace=2
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=m
    set guioptions-=M
    set guioptions-=e
    set guicursor+=a:blinkon0
    set guifont=SF\ Mono:h16
endif

" Undo
set undofile
set undolevels=1000
set undodir=/tmp
set backupdir=/tmp
set dir=/tmp

" History
set history=1000

" Visual
set ruler
set showmode
set lazyredraw
set nocursorline
set scrolloff=3
set laststatus=2
set showtabline=0
set conceallevel=0
set foldlevelstart=99
set diffopt=vertical,filler

" Statusline
set statusline=
set statusline+=%f
set statusline+=\ %m
set statusline+=%=
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Search
set incsearch
set ignorecase
set smartcase
set nohlsearch

" Split
set splitbelow
set splitright

" Indent
set smarttab
set tabstop=8
set expandtab
set autoindent
set copyindent
set shiftround
set shiftwidth=4
set softtabstop=4

" Misc
set hidden
set mouse=a
set gdefault
set visualbell
set nojoinspaces
set noerrorbells
set updatetime=100
set clipboard=unnamed
set backspace=indent,eol,start

"------------------------------------------------------------------------------
" FileType-Specific Settings

autocmd FileType c
    \ setlocal shiftwidth=4 |
    \ setlocal tabstop=4 |
    \ setlocal expandtab

autocmd FileType cpp
    \ setlocal shiftwidth=2 |
    \ setlocal tabstop=4

autocmd FileType dhall
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab

autocmd FileType go
    \ setlocal shiftwidth=8 |
    \ setlocal noexpandtab

autocmd FileType html,css,javascript,typescript,typescriptreact
    \ setlocal textwidth=90 |
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab

autocmd FileType lisp,clojure,scheme
    \ setlocal shiftwidth=2

autocmd FileType markdown.mdx
    \ setlocal textwidth=80 |
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab |
    \ setlocal conceallevel=0

autocmd FileType python,rst
    \ setlocal textwidth=88 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab

autocmd FileType ocaml
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab

autocmd FileType ruby
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab

autocmd FileType rust
    \ setlocal textwidth=99 |
    \ setlocal shiftwidth=4 |
    \ setlocal expandtab

autocmd FileType sh
    \ setlocal textwidth=88

autocmd FileType sql
    \ setlocal shiftwidth=2 |
    \ setlocal expandtab

autocmd FileType yaml
    \ setlocal shiftwidth=2

autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType gitcommit setlocal spell! spelllang=en_gb
autocmd FileType gitconfig setlocal shiftwidth=8

autocmd BufNewFile,BufRead *bash* let g:is_bash=1
autocmd BufNewFile,BufRead \*.{md,mdwn,mkd,mkdn,mark\*} setf markdown
autocmd BufNewFile,BufRead *.erl,*.es,*.hrl,*.yaws,*.xrl setf erlang
autocmd BufNewFile,BufRead MLproject setf yaml

"------------------------------------------------------------------------------
" Mappings (see also Plugin section)

let mapleader=" "

" UK keyboards...
inoremap § <ESC>
vnoremap § <ESC>

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

noremap Q gq
nnoremap Q gqap
nnoremap Y y$
nnoremap j gj
nnoremap k gk
vnoremap < <gv
vnoremap > >gv

" The secret sauce.
noremap <C-h> b
noremap <C-l> w
noremap <C-j> 10gj
noremap <C-k> 10gk
noremap <C-n> <C-^>
noremap <C-b> :bn<CR>

" Window switching.
noremap <leader>h <C-w>h
noremap <leader>l <C-w>l
noremap <leader>k <C-w>k
noremap <leader>j <C-w>j

" These create newlines like o and O but stay in normal mode.
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Replace what is under the cursor globally, prompted for each word.
nnoremap <leader>r :%s/\<<C-r><C-w>\>//c<left><left>

" :%s/old/new/c replaces 'old' with 'new' globally, prompted for each word.
nnoremap <leader>R :%s//c<left><left>

"------------------------------------------------------------------------------
" fzf all the things

let g:fzf_layout = {'down': '50%'}
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(blue)(%an) %C(green)%cr"'
let g:fzf_action = {
\    'ctrl-t': 'tab split',
\    'ctrl-v': 'vsplit',
\    'alt-enter': 'split'
\}

nnoremap <leader><leader> :Ag<CR>
nnoremap ,, :History<CR>

nnoremap ,t :Files<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,p :GitFiles<CR>
nnoremap ,a :Ag<space>
nnoremap ,g :Ag<space><C-R><C-W><CR>
nnoremap ,v :FZF ~<CR>
nnoremap ,l :Locate<space>
nnoremap ,c :Commits<CR>
nnoremap ,C :BCommits<CR>
nnoremap ,/ :Lines<CR>
nnoremap ,: :Commands<CR>
nnoremap ,w :Windows<CR>
nnoremap ,s :Snippets<CR>
nnoremap ,M :Maps<CR>
nnoremap ,m :Marks<CR>
nnoremap ,H :Helptags<CR>
nnoremap ,S :Colors<CR>
nnoremap ,h: :History:<CR>
nnoremap ,h/ :History/<CR>

"------------------------------------------------------------------------------
" vim-rooter

let g:rooter_silent_chdir = 1
let g:rooter_resolve_links = 1


"------------------------------------------------------------------------------
" GitHub Copilot

imap <silent> <C-j> <Plug>(copilot-next)
imap <silent> <C-k> <Plug>(copilot-previous)
imap <silent> <C-\> <Plug>(copilot-dismiss)
