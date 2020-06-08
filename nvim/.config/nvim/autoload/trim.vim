function! trim#all() abort
  let l:view = winsaveview()

  " Strip trailing whitespaces.
  silent! keeppatterns %s/\s\+$//e

  " Strip excess empty lines.
  silent! keeppatterns %s/\n\{3,}/\r\r/e

  " Strip trailing empty line breaks.
  silent! keeppatterns %s/\($\n\s*\)\+\%$//e

  call winrestview(l:view)
endfunction
