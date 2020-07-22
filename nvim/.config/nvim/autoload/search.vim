if ! exists('g:search#default')
  let g:search#default = 'https://duckduckgo.com/?q=%s'
end

if ! exists('g:search#github')
  let g:search#github = 'https://github.com/search?q=%s'
end

function! search#default(visual) abort
  call s:open(printf(g:search#default, s:url_escape(s:get_target(a:visual))))
endfunction

function! search#github(visual) abort
  call s:open(printf(g:search#github, s:url_escape(s:get_target(a:visual))))
endfunction

function! s:open(target) abort
  call netrw#BrowseX(a:target, v:false)
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
