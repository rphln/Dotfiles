set filetype=typescript

let &l:formatexpr = ""
let &l:formatprg = "prettier --stdin-filepath %"

let b:surround_{char2nr('c')} = "/* \r */"
let b:surround_{char2nr('d')} = "{\n\t\r\n}"
