function! texfold#expr()
  return luaeval('fold_expr(_A)', getline(v:lnum))
endfunction

function! texfold#text()
  return luaeval('fold_text(_A[1], _A[2])', [getline(v:foldstart), len(v:folddashes)])
endfunction

lua <<EOF
local patterns = {
  { match = [[%%%s*(.*){{{]],         capture = true,  fold = 'a1', label = 'Fold'        },
  { match = [[%%%s*}}}]],             capture = false, fold = 's1', label = nil           },

  { match = [[%%]],                   capture = false, fold = '=',  label = nil           },

  { match = [[\chapter%*?{(.*)}]],    capture = true,  fold = '>1', label = 'Chapter'     },
  { match = [[\section%*?{(.*)}]],    capture = true,  fold = '>2', label = 'Section'     },
  { match = [[\subsection%*?{(.*)}]], capture = true,  fold = '>3', label = 'Subsection'  },

  { match = [[\begin{description}]],  capture = false, fold = 'a1', label = 'Description' },
  { match = [[\end{description}]],    capture = false, fold = 's1', label = nil           },

  { match = [[\begin{itemize}]],      capture = false, fold = 'a1', label = 'Itemize'     },
  { match = [[\end{itemize}]],        capture = false, fold = 's1', label = nil           },

  { match = [[\begin{enumerate}]],    capture = false, fold = 'a1', label = 'Enumerate'   },
  { match = [[\end{enumerate}]],      capture = false, fold = 's1', label = nil           },

  { match = [[]],                     capture = false, fold = '=',  label = nil           },
}

local function match_fold_pattern(line)
  for _, pattern in ipairs(patterns) do
    text = line:match(pattern.match)
    if text then
      return pattern, text
    end
  end
end

function fold_expr(line)
  pattern, _ = match_fold_pattern(line)
  return pattern.fold
end

function fold_text(line, level)
  pattern, text = match_fold_pattern(line)

  label = pattern.label

  if pattern.capture and text:match('%S') then
    label = label .. ": " .. text
  end

  return string.rep("─", level) .. " " .. label
end
EOF
