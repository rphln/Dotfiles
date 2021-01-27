" Section: Setup

set packpath^=~/Dotfiles/_nvim/

augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim nested source $MYVIMRC
augroup end

" Section: General

set title
let &titlestring = "%t — %{v:progname}"

set clipboard^=unnamed
set clipboard^=unnamedplus

set hidden

set lazyredraw

set shiftround

set splitbelow
set splitright

let g:lion_squeeze_spaces = v:true

" Section: Search and replace

set gdefault

set inccommand=nosplit
set incsearch

set nohlsearch

" Section: Completion

set completeopt+=menuone
set completeopt-=preview

" Section: Views and undo

set undofile

set viewoptions-=curdir
set viewoptions-=options

autocmd vimrc BufWinEnter * if ! empty(glob("%:p")) | silent! loadview | endif
autocmd vimrc BufWinLeave * if ! empty(glob("%:p")) | silent! mkview   | endif

" Section: Line wrapping

set breakindent
set showbreak=↪

set linebreak

set nowrap
set textwidth=80

" Section: Appearance

let &fillchars = "eob: "

set laststatus=0
set noruler

set list
let &listchars = "tab:┆ ,trail:␣,nbsp:·,extends:»,precedes:«"

set scrolloff=8
set sidescrolloff=8

set termguicolors
colorscheme darcula

" Section: Overrides

let g:mapleader = "\<Space>"

noremap : ;
noremap ; :

nnoremap <Backspace> <C-^>

nnoremap / /\c
nnoremap ? ?\c

xnoremap < <gv
xnoremap > >gv

nnoremap n nzz
nnoremap N Nzz

nnoremap Q @q
xnoremap Q :normal! @q<CR>

nnoremap Y y$

" Section: Misc

onoremap af :<C-u>normal! ggVG<CR>
xnoremap af :<C-u>normal! ggVG<CR>

nnoremap cm *Ncgn

nnoremap gB `[V`]
nnoremap gb `[v`]

nnoremap yr :%s/\<<C-r><C-w>\>/

" Section: Readline

noremap! <C-a> <Home>
noremap! <C-e> <End>

inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>

" Section: Character pairs

inoremap " ""<C-g>U<Left>
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap ` ``<C-g>U<Left>
inoremap { {}<C-g>U<Left>

let g:surround_{char2nr("[")} = "[\n\t\r\n]"
let g:surround_{char2nr("{")} = "{\n\t\r\n}"
