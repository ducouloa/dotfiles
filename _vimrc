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

" Expend the main content: eg: headers in vimwiki or taskpaper
set foldlevel=1
set cryptmethod=blowfish
set printoptions=paper:A4

" SubSection: Plugin {{{2
" -----------------------

let g:load_doxygen_syntax=1
let g:pyflakes_use_quickfix = 0

" Plugin: vim-pathogen {{{3
" --------------------------------
" copie of the pathogen plugin
" plugin isolation
" /vim-pathogen }}}3

" Plugin: vim-fugitive {{{3
" --------------------------------
" Out of the box from github bundle/vim-fugitive
" Git support in git
" /vim-fugitive/ }}}3

" Plugin: vim-solarized {{{3
" --------------------------------
" Out of the box from github bundle/vim-colors-solarized
" solarized colorscheme for git
" /vim-solarized/ }}}3

" Plugin: vim-project {{{3
" --------------------------------
" Copy of http://www.vim.org/scripts/script.php?script_id=69 v1.4.1
" Manage vim project in a .vimproject file
" /vim-project/ }}}3

" Plugin: taskpaper {{{3
" --------------------------------
" clone of git://github.com/davidoc/taskpaper.vim.git
" Manage todo_list the taskpaper way + taskpaper filetype management
" /taskpaper/ }}}3

" Plugin: vim-startify {{{3
" --------------------------------
" clone git://github.com/mhinz/vim-startify
" Allow to have a startup screen within vim
" /vim-startify/ }}}3

" Plugin: vim-easymotion {{{3
" --------------------------------
" clone git://github.com/Lokaltog/vim-easymotion
" allow to move faster within vim buffer
" /vim-easymotion/ }}}3

" Plugin: buffer-explorer {{{3
" --------------------------------
" clone git://github.com/widox/vim-buffer-explorer-plugin
" Visualize opened buffer
" /buffer-explorer/ }}}3

" Plugin: javacomplete {{{3
" --------------------------------
" clone git://github.com/vim-scripts/javacomplete
" Add code basic java code completion
" /javacomplete/ }}}3

" Plugin: taglist {{{3
" --------------------------------
" clone git://github.com/vim-scripts/taglist.vim
" Create a Tag menu context of the current buffer
" /taglist/ }}}3

" Plugin: wikipedia {{{3
" --------------------------------
" source TBD
" filetype + syntax for the mediawiki filetype
" /wikipedia/ }}}3

" Plugin: jedi-vim {{{3
" --------------------------------
" clone of https://github.com/davidhalter/jedi-vim
" python code completion for vim
" to initialize the module, jump in and 
" git submodule update --init
"
" That command will clone the jedi library as a submodule
" /jedi-vim/ }}}3

" Plugin: nerdtree {{{3
" --------------------------------
" clone of https://github.com/scrooloose/nerdtree
" alternative file explorer for vim
" /nerdtree/ }}}3

" Plugin: tagbar {{{3
" --------------------------------
" clone of https://github.com/majutsushi/tagbar
" Same as taglist but different
" /tagbar/ }}}3

" Plugin: logcat {{{3
" --------------------------------
" add Color syntax to logcat log + MVP session.log files
" add folding support for MVP session.log files
" /logcat/ }}}3

" Plugin: vimux {{{3
" --------------------------------
" integrate vim with tmux
" clone of the github repo https://github.com/benmills/vimux
" /vimux/ }}}3

" Plugin: Syntastic {{{3
" --------------------------------
" Syntax error checking
" clone of the github repo https://github.com/scrooloose/syntastic.git
let g:syntastic_python_flake8_args='--ignore=E501'
let g:syntastic_python_checkers=['flake8']
" /Syntastic/ }}}3

" Plugin: vimwiki {{{3
" --------------------------------
" personal vim wiki organiser
" clone of the github repo https://github.com/vimwiki
"
" See also the google group page: code.google.com/p/vimwiki/
" This vimwiki plugin as a strong integration with calendar-vim plugin.
" Thus I installed them together

let vmw_wiki = {}
let vmw_wiki.path = '~/wres/'
let vmw_wiki.path_html = '~/wres/html/'
let vmw_wiki.diary_rel_path = 'perso/diary/'
let g:vimwiki_list = [vmw_wiki]

" allow folding in vimwiki files:
let g:vimwiki_folding = 'expr'
let g:vimwiki_hl_headers = 1
" highlight checked checkbox with comment color
let g:vimwiki_hl_cb_checked = 1


function! VimwikiLinkHandler(link) "{{{ Use Vim to open links with the
  " 'vlocal:' or 'vfile:' schemes.  E.g.:
  "   1) [[vfile:///~/Code/PythonProject/abc123.py]], and
  "   2) [[vlocal:./|Wiki Home]]
  let link = a:link
  if link =~ "vlocal:" || link =~ "vfile:"
    let link = link[1:]
  else
    return 0
  endif
  let [idx, scheme, path, subdir, lnk, ext, url] = 
       \ vimwiki#base#resolve_scheme(link, 0)
  if g:vimwiki_debug
    echom 'LinkHandler: idx='.idx.', scheme=[v]'.scheme.', path='.path.
         \ ', subdir='.subdir.', lnk='.lnk.', ext='.ext.', url='.url
  endif
  if url == ''
    echom 'Vimwiki Error: Unable to resolve link!'
    return 0
  else
    call vimwiki#base#edit_file('tabnew', url, [], 0)
    return 1
  endif
endfunction " }}}


" /vimwiki/ }}}3

" Plugin: calendar {{{3
" --------------------------------
" Calendar plugin for vim: display a calendar with \cal
" clone of the github repo https://github.com/mattn/calendar-vim
"
" Use vimwiki calendar integration
let g:vimwiki_use_calendar = 1

" /calendar/ }}}3


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

"Allow saving during edition: Must be disable in the bashrc: stty -ixon
imap <C-S> <C-O>:write
nmap <C-S> :write
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

