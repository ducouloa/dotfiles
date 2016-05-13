" Options {{{

" Python indent options
setlocal cinwords=if,elif,else,for,while,try,except,finally,def,class
setlocal cindent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal shiftround
setlocal smartindent
setlocal smarttab
setlocal expandtab
setlocal autoindent

" Python other options
setlocal complete+=t
setlocal formatoptions-=t
setlocal textwidth=79
setlocal cursorline

" }}}

" Utils {{{

" Comment this script as it seems to slow down a lot writing of long file
" au BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

if exists('g:pymode_function')
	finish
endif
let g:pymode_function = 1

" Change python indentation policy on the fly
function PythonToggleIndent()
	if &tabstop == 3
		setlocal tabstop=4
		setlocal softtabstop=4
		setlocal shiftwidth=4
	else
		setlocal tabstop=3
		setlocal softtabstop=3
		setlocal shiftwidth=3
	endif
endfunction

command! -nargs=0 PyToggleIndent call PythonToggleIndent()

" Execute current file when <F5> is pressed
nmap <F5> :!python2.7 %
" }}}


" vim: fdm=marker:fdl=1
