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

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'

" Section: Fuzzy finder

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --exclude .git'
end

let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.8}}

let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'IncSearch'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'IncSearch'],
      \ 'info':    ['fg', 'IncSearch'],
      \ 'border':  ['fg', 'Search'],
      \ 'prompt':  ['fg', 'Comment'],
      \ 'pointer': ['fg', 'IncSearch'],
      \ 'marker':  ['fg', 'IncSearch'],
      \ 'spinner': ['fg', 'IncSearch'],
      \ 'header':  ['fg', 'WildMenu'],
      \ }

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

nnoremap c> *Ncgn
nnoremap c< #NcgN

nnoremap gl `[v`]
nnoremap gL `[V`]

nnoremap yr :%s/\C\<<C-r><C-w>\>/

" Section: Insert

inoremap <C-l> <Esc>[S1z=``a

" Section: Completion

inoremap <expr> <Tab>   complete#tab(v:false)
inoremap <expr> <S-Tab> complete#tab(v:true)

inoremap <expr> <C-n> complete#next(v:false)
inoremap <expr> <C-p> complete#next(v:true)

" Section: Leader

xnoremap <Leader>c :!column -Lt -o ' '<CR>gv=

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>gh :call search#github(v:false)<CR>
xnoremap <Leader>gh :call search#github(v:true)<CR>

nnoremap <Leader>gs :call search#default(v:false)<CR>
xnoremap <Leader>gs :call search#default(v:true)<CR>

nnoremap <Leader>bb <Cmd>Buffers<CR>
nnoremap <Leader>bk <Cmd>bdelete<CR>

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

" Section: Diagnostics

nmap <Leader>n <Plug>(ale_next_wrap)
nmap <Leader>p <Plug>(ale_previous_wrap)

function! s:lsp() abort
  setlocal omnifunc=ale#completion#OmniFunc

  nmap <buffer> K <Plug>(ale_hover)

  nmap <buffer> gd <Plug>(ale_go_to_definition)
  nmap <buffer> gr <Plug>(ale_find_references)

  nmap <buffer> <Leader>af <Plug>(ale_fix)
  nmap <buffer> <Leader>ar <Plug>(ale_rename)
endfunction

autocmd vimrc FileType python,elixir,rust call <SID>lsp()

" vim: set ts=2 sw=2 et:
