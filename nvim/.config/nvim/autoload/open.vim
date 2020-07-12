if ! exists('g:open#command')
  let g:open#command = 'xdg-open %s'
end

if ! exists('g:open#github')
  let g:open#github = 'https://github.com/search?q=%s'
end

if ! exists('g:open#search')
  let g:open#search = 'https://duckduckgo.com/?q=%s'
end

function! open#uri(visual) abort
  call s:open(s:get_target(a:visual))
endfunction

function! open#github(visual) abort
  call s:open(printf(g:open#github, s:url_escape(s:get_target(a:visual))))
endfunction

function! open#search(visual) abort
  call s:open(printf(g:open#search, s:url_escape(s:get_target(a:visual))))
endfunction

function! s:open(target) abort
  call jobstart(printf(g:open#command, shellescape(a:target)), {'detach': v:true})
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

function! s:url_escape(string) abort
  return substitute(a:string, '\W', '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
endfunction
