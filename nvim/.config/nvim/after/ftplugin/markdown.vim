setlocal spell wrap colorcolumn^=+1

let b:ale_fixers  = ['remove_trailing_lines']
let b:ale_linters = []

if &filetype ==? 'gitcommit'
  setlocal colorcolumn^=51
end

if &filetype ==? 'tex'
  let b:ale_linters += ['texlab']
end
