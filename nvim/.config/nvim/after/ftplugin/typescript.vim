set filetype=typescript

let &l:formatexpr = ""
let &l:formatprg = "prettier --stdin-filepath %"
