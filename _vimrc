" ~/.vimrc
" vim:set ft=vim et sw=2 foldmethod=marker:

silent! execute pathogen#infect()

" Section: Options {{{1
" --------------------

"Show menu with possible tab completions
set wildmenu
"set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest  " command <Tab> completion, list matches, then longest common part, then all.

set list
set listchars=tab:>·,trail:·,extends:#,nbsp:· " Highlight problematic whitespace
set ruler
set tabstop=4
set shiftwidth=4
set bg=dark
set hls
set modeline
"r insert * in comments
"o insert * automaticaly continue comment on a new line
"c cut text in comments according to textwidth
set fo+=cro
set laststatus=1 "show the status bar on bottom of the screen
set diffopt=filler,vertical
set bs=2 "alow the suppression of everything in insert mode
"Toggle minibufferExplorer
"map <F3>  :TMiniBufExplorer<cr>
set pastetoggle=<F3>
set nu
set ls=2  " Always shows the statusbar
set mouse=nv

set expandtab
set printoptions=paper:A4

" SubSection: Plugin {{{2
" -----------------------

let g:load_doxygen_syntax=1
let g:pyflakes_use_quickfix = 0

" SubSubSection: vim-projects {{{3
" --------------------------------
" /vim-projects/ }}}3

" /Plugins/ }}}2

" /Options/ }}}1

" Section: Commands {{{1
" ---------------------

" /Commands/ }}}1

" Section: Mappings {{{1
" ---------------------

" Toggle mouse on/off
function! ToggleMouse()
  if &mouse != ""
    exe "set mouse="
    echo "Mouse is off"
  else
    exe "set mouse=a"
    echo "Mouse is on"
  endif
endfunction
map <F12> :call ToggleMouse()

function! ToggleList()
  if &list
    exe "set nolist"
    echo "do not display list"
  else
    exe "set list"
    echo "display list"
  endif
endfunction
map <F11> :call ToggleList()

" let mapleader = "ù"
map <SPACE> 
map <BS> 
map <F2>  :set number!
"map <F11> :!ctags -R .
"map <leader>T :TagbarToggle<CR>
"map <leader>t :TlistToggle<CR>
nmap <C-h> <C-W>h
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-l> <C-W>l
nmap <leader>/ :let @/=""

" /Mappings/ }}}1

" Section: Autocommands {{{1
" --------------------------

if has("autocmd")

  filetype on
  filetype plugin on
  filetype plugin indent on

  autocmd BufEnter *.c set expandtab
  autocmd BufEnter *.h set expandtab

  "setup SyntaxComplete for every filetype that does not already have a
  "language specific OMNI script
  set omnifunc=syntaxcomplete#Complete

  " Python omni completion -- desactivate to leverage of jedi-vim
  " autocmd FileType python set omnifunc=pythoncomplete#Complete

  autocmd BufReadPost fugitive://* set bufhidden=delete
  autocmd BufRead,BufNewFile session*.log set filetype=logcat
  autocmd BufRead,BufNewFile */configs/* set filetype=configs
  autocmd BufRead,BufNewFile *.aidl set filetype=java

endif  " has("autocmd")

" /Autocommands/ }}}1

" Section: Visual {{{1
" --------------------

syntax on

if &term == "screen-256color"
  set t_Co=256
endif

colorscheme solarized

set guifont=DejaVu\ Sans\ Mono\ 9
set guioptions=""

" /Visual/ }}}1

