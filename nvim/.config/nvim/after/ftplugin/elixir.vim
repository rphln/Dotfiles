let &l:makeprg = "mix compile"

let b:surround_{char2nr('d')} = "do\n\t\r\nend"
let b:surround_{char2nr('i')} = "IO.inspect(\r)"
