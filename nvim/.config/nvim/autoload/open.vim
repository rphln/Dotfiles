let g:open#command = 'xdg-open'

let g:open#github = 'https://github.com/%s'
let g:open#google = 'https://www.google.com/search?gl=us&hl=en&q=%s'

function! open#uri(visual) abort
  call s:open(s:get_target(a:visual))
endfunction

function! open#github(visual) abort
  call s:open(printf(g:open#github, s:get_target(a:visual)))
endfunction

function! open#google(visual) abort
  call s:open(printf(g:open#google, s:get_target(a:visual)))
endfunction

function! s:open(target) abort
  call jobstart(join([g:open#command, shellescape(a:target)]), {'detach': v:true})
endfunction

" See: <https://stackoverflow.com/a/1534347>
function! s:get_visual_selection() abort
  let l:before = @"

  try
    normal! gv""y
    return @"
  finally
    let @" = l:before
  endtry
endfunction

function! s:get_target(visual) abort
  return a:visual ? s:get_visual_selection() : expand('<cfile>')
endfunction
