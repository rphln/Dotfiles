setlocal spell wrap colorcolumn^=+1

if &filetype ==? 'gitcommit'
  setlocal colorcolumn^=51
end
