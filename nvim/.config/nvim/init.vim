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

let g:startify_change_to_dir = v:false
let g:startify_change_to_vcs_root = v:true

" Section: Search and replace

set gdefault

set inccommand=nosplit
set incsearch

set nohlsearch

" Section: Completion

set completeopt+=menuone
set completeopt-=preview

let g:mucomplete#minimum_prefix_length = 0

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

" Section: Color scheme

set background=dark
set termguicolors

let g:gruvbox_bold = v:false
let g:gruvbox_sign_column = "bg0"

colorscheme gruvbox

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

" Section: Leader

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :Rg<CR>

nnoremap <Leader>u :UndotreeToggle<CR>

" Section: Snippets

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" Section: ALE

let g:ale_hover_cursor = v:false

let g:ale_sign_error = "•"
let g:ale_sign_warning = "•"

nmap <Leader>n <Plug>(ale_next_wrap)
nmap <Leader>p <Plug>(ale_previous_wrap)

autocmd vimrc FileType * call <SID>lsp()

function! s:lsp() abort
  if s:has_lsp()
    setlocal omnifunc=ale#completion#OmniFunc

    nmap <buffer> K <Plug>(ale_hover)

    nmap <buffer> gd <Plug>(ale_go_to_definition)
    nmap <buffer> gr <Plug>(ale_find_references)

    nmap <buffer> <Leader>af <Plug>(ale_fix)
    nmap <buffer> <Leader>ar <Plug>(ale_rename)
  endif
endfunction

function! s:has_lsp() abort
  for l:linter in ale#linter#Get(&filetype)
    if !empty(l:linter.lsp)
      return v:true
    endif
  endfor
endfunction
