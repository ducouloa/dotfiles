fun! s:LogcatFoldLevel(line)
  print line
  str=a:line
  if str == "H"
    return 1
  if str == "G"
    return 1
  if str == "W"
    return 1
endfunc

fun! TestTest(line)
  let s:lec = getline(a:line)[0]
  if s:lec == "G"
    return 1
  elseif s:lec == "H"
    return 1
  endif

  return 0
endfunc

set foldexpr=TestTest(v:lnum)
set foldmethod=expr

"set foldexpr=getline(v:lnum)[0]==\"G"|\"H\"

