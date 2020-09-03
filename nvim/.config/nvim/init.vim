" Section: Setup

set packpath^=~/Dotfiles/_nvim/

augroup vimrc
  autocmd!
  autocmd BufWritePost init.vim nested source $MYVIMRC
augroup end

" Section: General

set title
let &titlestring = "%t — vim"

set clipboard^=unnamed
set clipboard^=unnamedplus

set hidden

set lazyredraw

set shiftround

set splitbelow
set splitright

" Section: Search and replace

set gdefault

set inccommand=split
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

set laststatus=0
set noruler

set list
let &listchars = "tab:┆ ,trail:␣,nbsp:·,extends:»,precedes:«"

set scrolloff=8
set sidescrolloff=8

let &fillchars = "fold: ,eob: ,vert: "

" Section: Color scheme

set background=dark
set termguicolors

let g:gruvbox_sign_column = "bg0"

colorscheme gruvbox

" Section: Plugins

let g:neosnippet#snippets_directory = "~/.config/nvim/snippets/"

let g:startify_change_to_dir = v:false
let g:startify_change_to_vcs_root = v:true

let g:lion_squeeze_spaces = v:true

" Section: Fuzzy finder

let $FZF_DEFAULT_OPTS = "--color 16"

if executable('fd')
  let $FZF_DEFAULT_COMMAND = "fd --type f --hidden --exclude .git"
end

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

nnoremap yos :set spell! spell?<CR>
nnoremap yow :set wrap! wrap?<CR>

" Section: Insert

inoremap <C-l> <Esc>[S1z=``a

" Section: Completion

inoremap <expr> <Tab> complete#tab(v:false)
inoremap <expr> <S-Tab> complete#tab(v:true)

inoremap <expr> <C-n> complete#next(v:false)
inoremap <expr> <C-p> complete#next(v:true)

" Section: Leader

nnoremap <Leader>f :Files<CR>

map <Leader>gg <Plug>(lmgtfy-grep)
map <Leader>gh <Plug>(lmgtfy-github)
map <Leader>gs <Plug>(lmgtfy-duckduckgo)

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

" Section: Snippets

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Section: Diagnostics

if has('nvim-0.5')
  packadd! nvim-lspconfig

  sign define LspDiagnosticsErrorSign text=@
  sign define LspDiagnosticsWarningSign text=?

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
