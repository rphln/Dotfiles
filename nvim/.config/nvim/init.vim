" Paths {{{

let s:config = stdpath('config')
let s:data = stdpath('data')

let s:plug_source = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:plug_target = s:data . '/site/autoload/plug.vim'

let s:plugged = s:data . '/plug'

" }}}
" Automatic commands namespace {{{

augroup vimrc
  autocmd!
augroup end

" }}}
" Auto-install Plug {{{

if empty(glob(s:plug_target))
  echo 'Installing plug.vim...'
  exec '!curl -fLo ' . s:plug_target . ' --create-dirs ' . s:plug_source

  autocmd vimrc VimEnter * PlugInstall --sync
endif

" }}}
" Plugins {{{

call plug#begin(s:plugged) | if 1
  Plug 'honza/vim-snippets'

  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'

  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-apathy'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'

  " Language server and more.
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Language support.
  Plug 'sheerun/vim-polyglot'

  " Color scheme.
  Plug 'skielbasa/vim-material-monokai', {'tag': '989b0e2'}

  " Must be loaded early in order to work correctly.
  call plug#load('vim-sensible')
endif | call plug#end()

" }}}

" General {{{

" Auto-reload `init.vim`.
autocmd vimrc BufWritePost $MYVIMRC nested source $MYVIMRC

" Use both system clipboards.
set clipboard+=unnamed,unnamedplus

" Suggest the longest common match first.
set completeopt^=longest

" Treat dashes as word characters.
set iskeyword+=-

" Hide the status line.
set laststatus=0

" Don't redraw the screen while executing macros.
set lazyredraw

" Allow jumping to matching square brackets.
set matchpairs+=<:>

" Enable mouse support.
set mouse=nvi

" Number of lines to keep around the cursor.
set scrolloff=4

" Check spelling.
set spelllang+=en,pt

" Position of new windows.
set splitright splitbelow

" Use a custom terminal title.
set title
let &titlestring = "%t — nvim"

" Remove the delay from <Esc>.
set ttimeoutlen=0

" Disable netrw.
let g:loaded_netrw = v:true
let g:loaded_netrwPlugin = v:true

" }}}
" Search and replace {{{

" Ignore case in searches by default, unless one or more characters in the pattern are
" uppercased.
set ignorecase smartcase

" Preview substitutions as you type.
set inccommand=nosplit

" Search as you type.
set incsearch

" Don't highlight all search results.
set nohlsearch

" }}}
" Color scheme {{{

syntax enable

set background=dark
set termguicolors

let g:materialmonokai_gui_italic = v:false
let g:materialmonokai_italic = v:false

function! s:colorscheme() abort
  highlight! link ColorColumn Folded
  highlight! link MatchParen Type
endfunction

autocmd vimrc Colorscheme * call <SID>colorscheme()

silent! colorscheme material-monokai

" }}}
" Appearance {{{

" Hide interface clutters.
let &fillchars = "fold: ,eob: "

" Show whitespace characters.
set list
let &listchars = "tab:┆ ,trail:•,extends:…,precedes:…,nbsp:‡"

" Don't highlight the current line or column.
set nocursorline nocursorcolumn

" Show relative line numbers.
set number relativenumber

" Hide the position indicator.
set noruler

" Show the maximum line length.
set textwidth=88 colorcolumn+=+1

" }}}
" Word wrapping {{{

" Disable automatic line breaking outside of comments.
set formatoptions-=t

" Don't insert line breaks in the middle of words.
set linebreak

" Disable line wrapping by default; instead, it should be enabled on a per file type
" basis.
set nowrap

" Show line continuations.
set showbreak=↪

" }}}
" Soft tabs {{{

" Use spaces instead of tabs.
set expandtab

" Shift to the next tab stop.
set shiftround

" Set indent spacing.
set shiftwidth=2 softtabstop=2

" }}}
" Views  {{{

" Persist the undo history between sessions.
set undofile

" Prevents unintended side effects.
set viewoptions-=curdir
set viewoptions-=options

" Automatically keep track of views for existing files.
autocmd vimrc BufWinEnter * if ! empty(glob("%:p")) | silent! loadview | endif
autocmd vimrc BufWinLeave * if ! empty(glob("%:p")) | silent! mkview   | endif

" }}}
" Backups {{{

" Store backups before overwriting files.
set backup

" Don't clutter the working directory.
set backupdir^=~/.local/share/nvim/backup/

" Append a timestamp to the backup name.
autocmd vimrc BufWritePre * let &backupext = strftime("@%F %R")

" }}}
" Fuzzy finder {{{

" Skip binary or ignored files.
let $FZF_DEFAULT_COMMAND = 'fd --type f --follow --hidden --exclude .git'

" Disable all colors.
let $FZF_DEFAULT_OPTS = '--color bw --preview "cat {}"'

" }}}

" General {{{

" Clear to use as leader.
noremap <Space> <nop>

" Use semicolon for commands.
noremap ; :

" Repeat the last `f` or `t` operator.
noremap : ;

" Use Perl-like regular expressions when searching.
noremap / /\v
noremap ? ?\v

" Jump to the matching pair character.
noremap Z %

" Execute the macro recorded in `q`.
nnoremap Q @q
xnoremap Q :normal! @q<CR>

" Center view on the next (or previous) search result.
nnoremap n nzz
nnoremap N Nzz

" Yank from the cursor to the end of the line.
nnoremap Y y$

" Insert a blank line below the cursor.
nnoremap <Return> o<Esc>

" Alternate between files.
nnoremap <Backspace> <C-^>

" Select the last edited text.
nnoremap gV `[v`]

" Jump to the end of the pasted text.
nnoremap p p`]
xnoremap p p`]

" Don't leave visual mode after indenting.
xnoremap < <gv
xnoremap > >gv

" }}}
" Split navigation {{{

" Split horizontally or vertically.
nnoremap <M-s> <C-w>s
nnoremap <M-v> <C-w>v

" Move through splits.
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

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

" Use the space bar as leader key.
let mapleader = ' '

" Paste over a selection without yanking it.
xnoremap <Leader>p "_dP`]

" Save and quit.
nnoremap <Leader>q ZZ

" Save file.
nnoremap <Leader>w :update<CR>

" Align selected columns.
xnoremap <Leader>at :!column -t -o ' '<CR>

" Sort selected lines and remove duplicates.
xnoremap <Leader>au :sort u<CR>

" Sort selected lines in reverse order.
xnoremap <Leader>ar :sort!<CR>

" Sort selected lines.
xnoremap <Leader>as :sort<CR>

" Trim spaces.
nnoremap <Leader>ts :call trim#all()<CR>

" Fuzzy file finder.
nnoremap <Leader>f :Files<CR>

" Search files using `rg`.
nnoremap <Leader>r :Rg<CR>

" Open GitHub repositories.
nnoremap <Leader>gh :call open#github(v:false)<CR>
xnoremap <Leader>gh :call open#github(v:true)<CR>

" Search on Google.
nnoremap <Leader>gl :call open#google(v:false)<CR>
xnoremap <Leader>gl :call open#google(v:true)<CR>

" Open links.
nnoremap <Leader>go :call open#uri(v:false)<CR>
xnoremap <Leader>go :call open#uri(v:true)<CR>

" }}}
" Language server {{{

" Move {forward,backward} while expanding a snippet.
let g:coc_snippet_next = '<C-e>'
let g:coc_snippet_prev = '<C-t>'

" Trigger a snippet expansion.
imap <silent> <C-e> <Plug>(coc-snippets-expand-jump)

" Code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Show documentation for hovered object.
nnoremap <silent> K <Cmd>call <SID>hover()<CR>

function! s:hover() abort
  if index(['vim', 'help'], &filetype) >= 0
    normal! K
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" vim: set ts=2 sw=2 et fdm=marker:
