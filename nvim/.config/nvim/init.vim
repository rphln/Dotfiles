" Section: Setup

set packpath^=~/Dotfiles/_nvim/

augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim nested source $MYVIMRC
augroup end

" Section: General

set clipboard+=unnamed
set clipboard+=unnamedplus

set hidden

set lazyredraw

set shiftround

set splitbelow
set splitright

autocmd vimrc BufWritePre * if ! &binary | call trim#all() | endif

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

let &fillchars = "fold: ,eob: ,vert: "

" Section: Color scheme

syntax enable

set background=dark
set termguicolors

function! s:colorscheme() abort
  highlight! link MatchParen Type
endfunction

autocmd vimrc Colorscheme * call <SID>colorscheme()

colorscheme quantum

" Section: Plugins

let g:neosnippet#snippets_directory = "~/.config/nvim/snippets/"

let g:startify_change_to_dir = v:false
let g:startify_change_to_vcs_root = v:true

if executable('fd')
  let g:ctrlp_user_command = 'fd --type f --hidden --exclude .git'
else
  let g:ctrlp_user_command = 'git ls-files --cached --others --exclude-standard'
end

" Section: Overrides

let mapleader = ' '

noremap : ;
noremap ; :

nnoremap <Backspace> <C-^>

xnoremap < <gv
xnoremap > >gv

nnoremap n nzz
xnoremap N Nzz

xnoremap Q :normal! @q<CR>
nnoremap Q @q

nnoremap Y y$

" Section: Misc

onoremap af :<C-u>normal! ggVG<CR>``
xnoremap af :<C-u>normal! ggVG<CR>

nnoremap cm *Ncgn

nnoremap gl `[v`]
nnoremap gL `[V`]

nnoremap g? ?\c
nnoremap g/ /\c

nnoremap yr :%s/\<<C-r><C-w>\>/

" Section: Insert

inoremap <C-l> <Esc>[S1z=``a

" Section: Completion

inoremap <expr> <Tab>   complete#tab(v:false)
inoremap <expr> <S-Tab> complete#tab(v:true)

inoremap <expr> <C-n> complete#next(v:false)
inoremap <expr> <C-p> complete#next(v:true)

" Section: Leader

xnoremap <Leader>c :!column -Lt -o ' '<CR>gv=

nnoremap <Leader>gh :call search#github(v:false)<CR>
xnoremap <Leader>gh :call search#github(v:true)<CR>

nnoremap <Leader>gs :call search#default(v:false)<CR>
xnoremap <Leader>gs :call search#default(v:true)<CR>

nnoremap <Leader>bb <Cmd>Buffers<CR>
nnoremap <Leader>bd <Cmd>bdelete<CR>

" Section: Readline

cnoremap <C-a> <Home>
cnoremap <C-e> <End>

inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$

inoremap <C-b> <C-g>U<Left>
inoremap <C-f> <C-g>U<Right>

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

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Section: Diagnostics

if has('nvim-0.5')
  packadd! nvim-lsp

  lua lsp = require('nvim_lsp')

  call v:lua.lsp.elixirls.setup({})
  call v:lua.lsp.pyls.setup({})
  call v:lua.lsp.rust_analyzer.setup({})

  function! s:lsp() abort
    setlocal omnifunc=v:lua.vim.lsp.omnifunc

    nnoremap <buffer> yr <Cmd>call v:lua.vim.lsp.buf.rename()<CR>

    nnoremap <buffer> K <Cmd>call v:lua.vim.lsp.buf.hover()<CR>
    nnoremap <buffer> gd <Cmd>call v:lua.vim.lsp.buf.definition()<CR>
    nnoremap <buffer> gi <Cmd>call v:lua.vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> gr <Cmd>call v:lua.vim.lsp.buf.references()<CR>
  endfunction

  autocmd vimrc FileType python,elixir,rust call <SID>lsp()
endif

" vim: set ts=2 sw=2 et:
