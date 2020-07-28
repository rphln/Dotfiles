function! complete#next(reverse) abort
  let l:next = a:reverse ? "\<C-p>" : "\<C-n>"

  if pumvisible()
    return l:next
  end

  if ! empty(&omnifunc)
    return "\<C-x>\<C-o>"
  end

  return l:next
endfunction

function! complete#tab(reverse) abort
  if pumvisible() || s:getchar() =~ '\S'
    return complete#next(a:reverse)
  else
    return "\<Tab>"
  end
endfunction

function! s:getchar() abort
  return matchstr(getline('.'), printf('.\%%%dc', col('.')))
endfunction
