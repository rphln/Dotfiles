" Setup {{{

let s:config = stdpath('config')
let s:data = stdpath('data')

let s:plug_source = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:plug_target = s:data . '/site/autoload/plug.vim'

let s:plugged = s:data . '/plug'

augroup vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup end

if empty(glob(s:plug_target))
  echo 'Installing plug.vim...'
  exec '!curl -fLo ' . s:plug_target . ' --create-dirs ' . s:plug_source

  autocmd vimrc VimEnter * PlugInstall --sync
endif

" }}}
" Plugins {{{

call plug#begin(s:plugged) | if v:true
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'honza/vim-snippets'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'

  Plug 'skielbasa/vim-material-monokai'

  " Language support.
  Plug 'elixir-editors/vim-elixir', {'for': 'elixir'}
endif | call plug#end()

" }}}

" General {{{

set clipboard+=unnamed
set clipboard+=unnamedplus

set completeopt^=longest

set lazyredraw

set linebreak
set nowrap

set mouse=nvi

set shiftround
set smarttab

set spelllang+=en
set spelllang+=pt

set splitbelow
set splitright

set ttimeoutlen=0

let g:loaded_netrw = v:true
let g:loaded_netrwPlugin = v:true

let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

let $FZF_DEFAULT_COMMAND = 'fd --type f --follow --hidden --exclude .git'
let $FZF_DEFAULT_OPTS = '--color bw --preview "cat {}"'

" }}}
" Search and replace {{{

set ignorecase
set smartcase

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
" Appearance {{{

set title
let &titlestring = "%t — nvim"

let &fillchars = "fold: ,eob: "

set list
let &listchars = "tab:┆ ,trail:•,extends:»,precedes:«,nbsp:‡"

set showbreak=↪

set nocursorcolumn
set nocursorline

set noruler

set number
set relativenumber

set textwidth=88
set colorcolumn+=+1

set laststatus=0

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

  let g:terminal_color_0  = "#435b67"
  let g:terminal_color_1  = "#fc3841"
  let g:terminal_color_2  = "#5cf19e"
  let g:terminal_color_3  = "#fed032"
  let g:terminal_color_4  = "#37b6ff"
  let g:terminal_color_5  = "#fc226e"
  let g:terminal_color_6  = "#59ffd1"
  let g:terminal_color_7  = "#ffffff"

  let g:terminal_color_8  = "#a1b0b8"
  let g:terminal_color_9  = "#fc746d"
  let g:terminal_color_10 = "#adf7be"
  let g:terminal_color_11 = "#fee16c"
  let g:terminal_color_12 = "#70cfff"
  let g:terminal_color_13 = "#fc669b"
  let g:terminal_color_14 = "#9affe6"
  let g:terminal_color_15 = "#ffffff"
endfunction

autocmd vimrc Colorscheme * call <SID>colorscheme()

silent! colorscheme material-monokai

" }}}

" General {{{

" Use `Enter` for commands.
noremap <Return> :

" Jump to the paired character.
noremap Z %

" Play the macro recorded in the `q` register. If on visual mode, do it on each line.
nnoremap Q @q
xnoremap Q :normal! @q<CR>

" Center the view on the {previous,next} search result.
nnoremap N Nzz
nnoremap n nzz

" Make `Y` consistent with `D` and `C`.
nnoremap Y y$

" Alternate between files.
nnoremap <Backspace> <C-^>

" Select the last edited text.
nnoremap gl `[v`]

" Paste over a selection without yanking it.
xnoremap gb "_dP

" Re-indent the whole buffer.
nnoremap =% gg=G``

" Stay in visual mode after indenting.
xnoremap < <gv
xnoremap > >gv

" Split horizontally or vertically.
nnoremap <M-a>s <C-w>s
nnoremap <M-a>v <C-w>v

" Move through splits.
nnoremap <M-Down>  <C-w>j
nnoremap <M-Left>  <C-w>h
nnoremap <M-Right> <C-w>l
nnoremap <M-Up>    <C-w>k

" }}}
" Insert mode {{{

" Insert character pairs.
inoremap " ""<C-g>U<Left>
inoremap ' ''<C-g>U<Left>
inoremap ` ``<C-g>U<Left>
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap { {}<C-g>U<Left>

" Join the current and next line.
inoremap <C-j> <C-o>J

" Fix the last misspelled word.
inoremap <C-l> <Esc>[S1z=``a

" Reflow the current line.
inoremap <C-y> <C-o>gq_

" Kill to the end of the {line,word}.
inoremap <C-k> <C-o>D
inoremap <M-d> <C-o>de

" Comment the current line with `<C-/>`.
imap <C-_> <C-o>gcc

" }}}
" Leader keys {{{

" Use the space bar as the leader key.
let mapleader = ' '

" Unmap the default behaviour to avoid unexpected actions.
noremap <Leader> <nop>

" Save and quit.
nnoremap <Leader>w :update<CR>
nnoremap <Leader>z ZQ
nnoremap <Leader>q ZZ

" Fuzzy finder.
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

" Trim excess spaces and lines.
nnoremap <Leader>ts :call trim#all()<CR>

" Sort the selected lines.
xnoremap <Leader>as :sort<CR>
xnoremap <Leader>ar :sort!<CR>
xnoremap <Leader>au :sort u<CR>

" Align the selected lines.
xnoremap <Leader>at :!column -t -o ' '<CR>

" Open on GitHub.
nnoremap <Leader>gh :call open#github(v:false)<CR>
xnoremap <Leader>gh :call open#github(v:true)<CR>

" Search on Google.
nnoremap <Leader>gl :call open#google(v:false)<CR>
xnoremap <Leader>gl :call open#google(v:true)<CR>

" Open an URI.
nnoremap <Leader>go :call open#uri(v:false)<CR>
xnoremap <Leader>go :call open#uri(v:true)<CR>

" }}}
" Language server {{{

" Move {forward,backward} while expanding a snippet.
let g:coc_snippet_next = '<C-e>'
let g:coc_snippet_prev = '<C-t>'

" Trigger a snippet expansion.
imap <C-e> <Plug>(coc-snippets-expand-jump)

" Code navigation.
nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)

" Show documentation for hovered object.
nnoremap K :call <SID>hover()<CR>

function! s:hover() abort
  if index(['vim', 'help'], &filetype) >= 0
    normal! K
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" vim: set ts=2 sw=2 et fdm=marker:
