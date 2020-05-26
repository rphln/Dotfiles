" Setup {{{

augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim nested source $MYVIMRC
augroup end

set packpath^=~/Dotfiles/_nvim/

" }}}
" General {{{

set clipboard+=unnamed
set clipboard+=unnamedplus

set lazyredraw

set shiftround

set splitbelow
set splitright

let g:loaded_netrw = v:true
let g:loaded_netrwPlugin = v:true

let g:hardtime_allow_different_key = v:true
let g:hardtime_default_on = v:true

let g:list_of_insert_keys = ["<Backspace>", "<Up>", "<Down>", "<Left>", "<Right>"]

" }}}
" Search and replace {{{

set inccommand=nosplit
set incsearch

set nohlsearch

" }}}
" Views and undo {{{

set undofile

set viewoptions-=curdir
set viewoptions-=options

autocmd vimrc BufWinEnter * if ! empty(glob("%:p")) | silent! loadview | endif
autocmd vimrc BufWinLeave * if ! empty(glob("%:p")) | silent! mkview   | endif

" }}}
" Line wrapping {{{

set nowrap

set textwidth=80
set colorcolumn+=+1

set linebreak

set breakindent
set showbreak=↪

" }}}
" Appearance {{{

set title
let &titlestring = "%t — nvim"

set laststatus=0
set noruler

set list
let &listchars = "tab:┆ ,trail:•,nbsp:‡,extends:»,precedes:«"

set number
set relativenumber

set scrolloff=8
set sidescrolloff=8

let &fillchars = "fold: ,eob: "

" }}}
" Color scheme {{{

syntax enable

set background=dark
set termguicolors

let g:materialmonokai_gui_italic = v:false
let g:materialmonokai_italic = v:false

function! s:colorscheme() abort
  highlight! link ColorColumn LineNr
  highlight! link MatchParen Type
endfunction

autocmd vimrc Colorscheme * call <SID>colorscheme()

silent! colorscheme material-monokai

" }}}
" Snippets {{{

let g:neosnippet#disable_runtime_snippets = {'_' : v:true}
let g:neosnippet#snippets_directory = "~/.config/nvim/snippets/"

" }}}
" Fuzzy finder {{{

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
let $FZF_DEFAULT_OPTS = '--color bw'

let g:fzf_layout = {'window': {'width': 0.6, 'height': 0.8}}

" }}}
" Mappings {{{

let mapleader = ' '

noremap <Leader> <Nop>
noremap <Return> :

nnoremap <Backspace> <C-^>

nnoremap Q @q
xnoremap Q :normal! @q<CR>

xnoremap . :normal! .<CR>

nnoremap g/ /\c
nnoremap g? ?\c

nnoremap N Nzz
nnoremap n nzz

nnoremap Y y$

nnoremap gl `[V`]

nnoremap gs :%s/\<<C-r><C-w>\>/
nnoremap gS :'[,']s/\<<C-r><C-w>\>/

xnoremap gb "_dp

xnoremap < <gv
xnoremap > >gv

inoremap " ""<C-g>U<Left>
inoremap ` ``<C-g>U<Left>
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap { {}<C-g>U<Left>

inoremap <C-l> <Esc>[S1z=``a

inoremap <C-k> <C-o>D
inoremap <M-d> <C-o>de

xnoremap <Leader>c :!column -t -o ' '<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

imap <C-e> <Plug>(neosnippet_expand_or_jump)
smap <C-e> <Plug>(neosnippet_expand_or_jump)
xmap <C-e> <Plug>(neosnippet_expand_target)

" }}}
" Split management {{{

nnoremap <M-a>s <C-w>s
nnoremap <M-a>v <C-w>v

nnoremap <M-Down>  <C-w>j
nnoremap <M-Left>  <C-w>h
nnoremap <M-Right> <C-w>l
nnoremap <M-Up>    <C-w>k

" }}}

" vim: set ts=2 sw=2 et fdm=marker:
