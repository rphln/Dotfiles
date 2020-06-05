" Section: Setup

augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim nested source $MYVIMRC
augroup end

set packpath^=~/Dotfiles/_nvim/

" Section: General

set clipboard+=unnamed
set clipboard+=unnamedplus

set lazyredraw

set shiftround

set splitbelow
set splitright

let g:loaded_netrw = v:true
let g:loaded_netrwPlugin = v:true

" Section: Hard time

let g:hardtime_allow_different_key = v:true
let g:hardtime_default_on = v:true

let g:list_of_insert_keys = ["<Backspace>", "<Up>", "<Down>", "<Left>", "<Right>"]

" Section: Snippets

let g:neosnippet#disable_runtime_snippets = {'_' : v:true}
let g:neosnippet#snippets_directory = "~/.config/nvim/snippets/"

" Section: Search and replace

set inccommand=nosplit
set incsearch

set nohlsearch

" Section: Views and undo

set undofile

set viewoptions-=curdir
set viewoptions-=options

autocmd vimrc BufWinEnter * if ! empty(glob("%:p")) | silent! loadview | endif
autocmd vimrc BufWinLeave * if ! empty(glob("%:p")) | silent! mkview   | endif

" Section: Line wrapping

set nowrap

set breakindent
set showbreak=↪

set colorcolumn+=+1
set textwidth=80

set linebreak

" Section: Appearance

set title
let &titlestring = "%t — nvim"

set laststatus=0
set noruler

set list
let &listchars = "tab:┆ ,trail:␣,nbsp:·,extends:»,precedes:«"

set number
set relativenumber

set scrolloff=8
set sidescrolloff=8

let &fillchars = "fold: ,eob: "

" Section: Color scheme

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

colorscheme material-monokai

" Section: Fuzzy finder

let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
let $FZF_DEFAULT_OPTS = '--color bw'

let g:fzf_layout = {'window': {'width': 0.6, 'height': 0.8}}

" Section: Mappings

let mapleader = ' '

noremap <Leader> <Nop>
noremap <Return> :

nnoremap <Backspace> <C-^>

nnoremap Q @q
xnoremap Q :normal! @q<CR>

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

onoremap A <Cmd>normal! ggVG<CR>``

inoremap <C-l> <Esc>[S1z=``a

" Section: Leader mappings

xnoremap <Leader>c :!column -t -o ' '<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>gh :call open#github(v:false)<CR>
vnoremap <Leader>gh :call open#github(v:true)<CR>

nnoremap <Leader>go :call open#uri(v:false)<CR>
vnoremap <Leader>go :call open#uri(v:true)<CR>

nnoremap <Leader>gs :call open#search(v:false)<CR>
vnoremap <Leader>gs :call open#search(v:true)<CR>

" Section: Readline

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>

inoremap <C-k> <C-o>D
inoremap <M-d> <C-o>de

" Section: Character pairs

inoremap " ""<C-g>U<Left>
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap ` ``<C-g>U<Left>
inoremap { {}<C-g>U<Left>

let g:surround_{char2nr('[')} = "[\n\t\r\n]"
let g:surround_{char2nr('{')} = "{\n\t\r\n}"

" Section: Snippets

imap <C-t> <Plug>(neosnippet_expand_or_jump)
smap <C-t> <Plug>(neosnippet_expand_or_jump)
xmap <C-t> <Plug>(neosnippet_expand_target)

" Section: Future

if has('nvim-0.5')
  packadd! nvim-lsp

  lua lsp = require('nvim_lsp')

  call v:lua.lsp.elixirls.setup({})
  call v:lua.lsp.pyls.setup({})

  function! s:lsp() abort
    setlocal omnifunc=v:lua.vim.lsp.omnifunc

    nnoremap <buffer> K <Cmd>call v:lua.vim.lsp.buf.hover()<CR>
    nnoremap <buffer> gd <Cmd>call v:lua.vim.lsp.buf.definition()<CR>
  endfunction

  autocmd FileType python,elixir call <SID>lsp()
endif

" vim: set ts=2 sw=2 et:
