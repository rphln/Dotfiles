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

autocmd vimrc BufWritePre * if ! &binary | call trim#all() | endif

" Section: Snippets

let g:neosnippet#snippets_directory = "~/.config/nvim/snippets/"

" Section: Search and replace

set ignorecase
set smartcase

set inccommand=nosplit
set incsearch

set nohlsearch

" Section: Completion

set completeopt+=menuone
set completeopt-=preview

let g:float_preview#docked = v:false

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

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
end

let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'border':  ['fg', 'Comment'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ }

" Section: Mappings

let mapleader = ' '

noremap : ;
noremap ; :

nnoremap <Backspace> <C-^>

nnoremap Q @q
xnoremap Q :normal! @q<CR>

nnoremap N Nzz
nnoremap n nzz

nnoremap Y y$

nnoremap gl `[V`]

nnoremap gs :%s/\C\<<C-r><C-w>\>/

xnoremap gb "_dp

xnoremap < <gv
xnoremap > >gv

" Section: Insert mappings

inoremap <C-l> <Esc>[S1z=``a

" Section: Completion

inoremap <expr> <Tab>   complete#tab(v:false)
inoremap <expr> <S-Tab> complete#tab(v:true)

inoremap <expr> <C-n> complete#next(v:false)
inoremap <expr> <C-p> complete#next(v:true)

" Section: Leader mappings

xnoremap <Leader>c :!column -Lt -o ' '<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>gh :call open#github(v:false)<CR>
xnoremap <Leader>gh :call open#github(v:true)<CR>

nnoremap <Leader>go :call open#uri(v:false)<CR>
xnoremap <Leader>go :call open#uri(v:true)<CR>

nnoremap <Leader>gs :call open#search(v:false)<CR>
xnoremap <Leader>gs :call open#search(v:true)<CR>

" Section: Readline

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

" Section: Future

if has('nvim-0.5')
  packadd! nvim-lsp

  lua lsp = require('nvim_lsp')

  call v:lua.lsp.elixirls.setup({})
  call v:lua.lsp.pyls.setup({})
  call v:lua.lsp.rls.setup({})

  function! s:lsp() abort
    setlocal omnifunc=v:lua.vim.lsp.omnifunc

    nnoremap <buffer> <Leader>lc <Cmd>call v:lua.vim.lsp.buf.code_action()<CR>
    nnoremap <buffer> <Leader>lf <Cmd>call v:lua.vim.lsp.buf.formatting()<CR>
    nnoremap <buffer> <Leader>lr <Cmd>call v:lua.vim.lsp.buf.rename()<CR>
    nnoremap <buffer> <Leader>ls <Cmd>call v:lua.vim.lsp.buf.workspace_symbol()<CR>

    nnoremap <buffer> K  <Cmd>call v:lua.vim.lsp.buf.hover()<CR>
    nnoremap <buffer> gd <Cmd>call v:lua.vim.lsp.buf.definition()<CR>
    nnoremap <buffer> gi <Cmd>call v:lua.vim.lsp.buf.implementation()<CR>
    nnoremap <buffer> gr <Cmd>call v:lua.vim.lsp.buf.references()<CR>
  endfunction

  autocmd FileType python,elixir,rust call <SID>lsp()
endif

" vim: set ts=2 sw=2 et:
