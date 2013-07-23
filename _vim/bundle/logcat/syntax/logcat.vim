syntax region logVERBOSE start="V/" end="$"
syntax region logDEBUG   start="D/" end="$"
syntax region logINFO    start="I/" end="$"
syntax region logWARNING start="W/" end="$"
syntax region logERROR   start="E/" end="$"
syntax region logALERT   start="A/" end="$"

syntax match diagVERBOSE "^.\{30} V .*$"
syntax match diagDEBUG   "^.\{30} D .*$"
syntax match diagINFO    "^.\{30} I .*$"
syntax match diagWARNING "^.\{30} W .*$"
syntax match diagERROR   "^.\{30} E .*$"
syntax match diagALERT   "^.\{30} A .*$"

syntax match sesVERBOSE "^.\{6,48} VERBOSE.*$"
syntax match sesDEBUG   "^.\{6,48} DEBUG.*$"
syntax match sesINFO    "^.\{6,48} INFO.*$"
syntax match sesWARNING "^.\{6,48} WARNING.*$"
syntax match sesERROR   "^.\{6,48} ERROR.*$"
syntax match sesALERT   "^.\{6,48} CRITICAL.*$"

"syntax region loghVERBOSE start="V/" end=""
"syntax region loghDEBUG   start="D/" end=""
"syntax region loghINFO    start="I/" end=""
"syntax region loghWARNING start="W/" end=""
"syntax region loghERROR   start="E/" end=""
"syntax region loghALERT   start="A/" end=""

highlight default sesVERBOSE ctermfg=0 ctermbg=0
highlight default sesDEBUG   ctermfg=0 ctermbg=4   guibg=#000033
highlight default sesINFO    ctermfg=0 ctermbg=2   guibg=#003300
highlight default sesWARNING ctermfg=0 ctermbg=3  guibg=#CC3300
highlight default sesERROR   ctermfg=0 ctermbg=1   guibg=#660000
highlight default sesALERT   ctermfg=0 ctermbg=5   guibg=#330000

highlight default diagVERBOSE ctermfg=0  guifg=#CCCCCC
highlight default diagDEBUG   ctermfg=4   guifg=#0066FF
highlight default diagINFO    ctermfg=2   guifg=#00CC00
highlight default diagWARNING ctermfg=3  guifg=#FF6600
highlight default diagERROR   ctermfg=1    guifg=#FF0000
highlight default diagALERT   ctermfg=5    guifg=#CC0000

highlight default logVERBOSE ctermfg=0  guifg=#CCCCCC
highlight default logDEBUG   ctermfg=4   guifg=#0066FF
highlight default logINFO    ctermfg=2   guifg=#00CC00
highlight default logWARNING ctermfg=3  guifg=#FF6600
highlight default logERROR   ctermfg=1    guifg=#FF0000
highlight default logALERT   ctermfg=5    guifg=#CC0000
"highlight default loghVERBOSE ctermfg=0
"highlight default loghDEBUG   ctermfg=33
"highlight default loghINFO    ctermfg=40
"highlight default loghWARNING ctermfg=214
"highlight default loghERROR   ctermfg=9
"highlight default loghALERT   ctermfg=1
"

nnoremap <buffer> <silent> zo
                            \ :call SyncFold('open')<CR>
nnoremap <buffer> <silent> zc
                            \ :call SyncFold('close')<CR>
command! -nargs=0 TF :call TF()
