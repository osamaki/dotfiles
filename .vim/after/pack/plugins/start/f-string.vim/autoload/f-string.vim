" syn region pythonfString matchgroup=pythonQuotes
      " \ start=+[fF]\@1<=\z(['"]\)+ end="\z1"
      " \ contains=@Spell,pythonEscape,pythonInterpolation
" syn region pythonfDocstring matchgroup=pythonQuotes
      " \ start=+[fF]\@1<=\z('''\|"""\)+ end="\z1" keepend
      " \ contains=@Spell,pythonEscape,pythonSpaceError,pythonInterpolation,pythonDoctest
