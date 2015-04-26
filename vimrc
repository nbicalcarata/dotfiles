" Plug core {{{
" *****************************************************************************

set nocompatible              " be iMproved
set modelines=0

" Plug automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall
  endif

call plug#begin('~/.vim/plugged')

" *****************************************************************************
" }}}
" Plug install packages {{{
" *****************************************************************************
" General {{{

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'majutsushi/tagbar'
Plug 'chartoin/vim-airline'
Plug 'mklabs/vim-fetch'
Plug 'justinmk/vim-gtfo'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/syntastic'
Plug 'severin-lemaignan/vim-minimap' 
Plug 'benmills/vimux' 
Plug 'christoomey/vim-tmux-navigator'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'dhruvasagar/vim-vinegar'
Plug 'ryanoasis/vim-webdevicons'

"}}}
" Colorschemes {{{

Plug 'nbicalcarata/vim-womprat'
Plug 'nbicalcarata/vim-airline-womprat'
Plug 'nanotech/jellybeans.vim'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'nbicalcarata/Muon'
Plug 'vim-scripts/lilypink'
Plug 'chriskempson/base16-vim'

" }}}
" Git {{{

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'jaxbot/browserlink.vim'

" }}}
" Snippets & AutoComplete {{{

Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Raimondi/delimitMate'

" }}}
" Python {{{

Plug 'klen/python-mode'
Plug 'python.vim'
Plug 'python_match.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'alfredodeza/pytest.vim'

" }}}
" *****************************************************************************
" }}}
" Plug end {{{
" *****************************************************************************
call plug#end()
" *****************************************************************************
" }}}

" Basic setup {{{
" *****************************************************************************

set background=dark         " Assume a dark background
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set clipboard=unnamedplus
set shortmess+=cfilmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set nospell                         " Spell checking off
set hidden                          " Allow buffer switching without saving
set foldenable                    " Enable folding
set timeoutlen=1000 ttimeoutlen=0   " Eliminar retardo de Insert a Normal 
set iskeyword+=-

" Setting up the directories {{{ 

set noswapfile
set backup                     " Backups are nice ...
if has('persistent_undo')
   set undofile                " So is persistent undo ...
   set undolevels=1000         " Maximum number of changes that can be undone
   set undoreload=10000        " Maximum number lines to save for undo 
endif 

" }}}
" Wild menu options {{{

set wildmenu                                     " cmd line completion ala zsh
set wildmode=list:longest                        " matches mimic bash or zsh
set wildignore+=node_modules                     " node_modules dir
set wildignore+=.ropeproject                     " py rope cache dir
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=migrations                       " Django migrations
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.class                          " Java byte code

" }}}
" *****************************************************************************
" }}}
" Autocmd rules {{{
" *****************************************************************************
" Always switch to the current file directory {{{

autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" }}}
" Running code with ,r {{{

autocmd FileType python map <leader>r :w<CR>:!python %<CR>
autocmd FileType bash map <leader>r :w<CR>:!./%<CR>
autocmd FileType java map <leader>c :w<CR>:!javac %<CR>
autocmd FileType java map <leader>r :w<CR>:!java %:r<CR>

" }}}
" Restore cursor to file position in previous editing session {{{

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction
augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" }}}
"Omnicompletion {{{

autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango

" }}}
" Close vim when the window left open is Nerdtree {{{

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" }}}
"No delay between Insert and Normal mode {{{

augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" }}}
" Only show cursorline in the current window and in normal mode {{{

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
" Open help files in right side {{{

autocmd FileType help :wincmd L
autocmd FileType help set bufhidden=unload

" }}}
" Detect django files {{{

au BufNewFile,BufRead admin.py     setlocal filetype=python.django
au BufNewFile,BufRead urls.py      setlocal filetype=python.django
au BufNewFile,BufRead models.py    setlocal filetype=python.django
au BufNewFile,BufRead views.py     setlocal filetype=python.django
au BufNewFile,BufRead settings.py  setlocal filetype=python.django
au BufNewFile,BufRead forms.py     setlocal filetype=python.django
"au BufNewFile,BufRead *.html       setlocal filetype=htmldjango
"
" }}}
" Enable minimap at start {{{

"autocmd! VimEnter * Minimap

" }}}
" *****************************************************************************
" }}}
" Visual settings {{{
" *****************************************************************************
" General {{{

set foldmethod=marker
set number
set wrap
set linebreak
set title
set nolist
set noea
set t_Co=256                    " Enable 256 colors
set lazyredraw
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
"set showcmd                      Shows the last command executed"
"set hlsearch                    " Highlight search matches
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set matchtime=2                 " show matching bracket for 0.2 seconds"
set incsearch                   " Find as you type search
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolloff=5                 " Minimum lines to keep above and below cursor
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight whitespace

" }}}
" Formatting {{{ 

set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after 
set splitright                  " Puts new vsplit windows to the right 
set splitbelow                  " Puts new split windows to the bottom
let loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set matchpairs+=<:>             " Match, to be used with %
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" }}}
" Colorschemes {{{

"let base16colorspace=256  " Access colors present in 256 colorspace
"let g:kolor_bold=0
"colorscheme lilypink
"colorscheme kolor
"colorscheme monokai
"colorscheme aldmeris
" colorscheme muon
"colorscheme womprat
"colorscheme Tomorrow-Night-Bright
" colorscheme railscasts
"colorscheme base16-default
"source ~/dotfiles/color/rmbackground.vim

" }}}
" Cursor line {{{

set cursorline

" }}}
" Statusline {{{

if has('statusline')
    set laststatus=2
    set statusline=%<%f\                    "Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" }}}
" Styling vertical splits {{{

set fillchars=vert:│,diff:⎼,fold:⎼

" }}}
" GUI Settings {{{

if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set guioptions-=m           " Remove the menubar
    set guioptions-=L           " Remove nerdtree scroll
    set guioptions-=r           " Remove the scroll bar
    nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
    nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
    set wrap
    set lines=999 columns=999    " Start maximized
    set lazyredraw
    colorscheme jellybeans
"   set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif

" }}}
" *****************************************************************************
" }}}
" Mappings {{{
" *****************************************************************************
let mapleader = ","
" Space to fold
nnoremap <space> za
" Quick edit vimrc
nnoremap <leader>ev :vsplit ~/dotfiles/vimrc<cr>
nnoremap <leader>sv :source ~/dotfiles/vimrc<cr>

" Ctr+C, Ctrl+V keys to copy paste
"nmap <C-V> "+gP
"imap <C-V> <ESC><C-V>i
"vmap <C-C> "+y

nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Bind nohl
" Removes highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Bind Ctrl+<movement> keys to move around the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Buffer switching mappings 
" left/right arrows to switch buffers in normal mode
"map <right> :bn<cr>
"map <left> :bp<cr>

" Resizing windows
nnoremap <C-up> <C-W>-
nnoremap <C-down> <C-W>+
nnoremap <C-right> 5<C-W><
nnoremap <C-left> 5<C-W>>

" Substitute
nnoremap <leader>s :%s//<left>

" Select current line (no indentation)
nnoremap vv ^vg_

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Same for 0, home, end, etc
noremap $ g$
noremap <End> g<End>
noremap 0 g0
noremap <Home> g<Home>
noremap ^ g^

" Shortcuts
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Find character under cursor with ,zxn
noremap <leader>z xhp/<C-R>-<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

"<leader>q to close buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle between absolute and relative line numbers

nnoremap <Leader>n :call NumberToggle()<cr>

" Tmux + vim special keys compatibility {{{

if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" }}}
" *****************************************************************************
" }}}
" Functions {{{
" *****************************************************************************
" Initialize directories {{{

function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir', }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "directory = $HOME . '/.vim/'
    
    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()

" }}}
" Initialize NERDTree as needed {{{

function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" }}}
" Change status on tmux {{{

"function! AddTmuxline()
"  if exists(':Tmuxline')
""   augroup airline_tmuxline
""      au!
""      au InsertEnter * Tmuxline airline_insert
""      au InsertLeave * Tmuxline airline
""    augroup END
""  endif
"endfunction
"au VimEnter * :call AddTmuxline()

" }}}
" Better folding style {{{

function! NeatFoldText() 
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" }}}
" NERDTress File highlighting {{{

"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 "exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
 "exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"endfunction

"call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
"call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('md', 'blue', 'none', 'blue', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"call NERDTreeHighlightFile('py', 'green', 'none', 'green', '#151515')
" source: https://github.com/scrooloose/nerdtree/issues/201#issuecomment-9954740"

" }}}
" Jump to CSS definition {{{
function! JumpToCSS()
  let id_pos = searchpos("id", "nb", line('.'))[1]
  let class_pos = searchpos("class", "nb", line('.'))[1]

  if class_pos > 0 || id_pos > 0
    if class_pos < id_pos
      execute ":vim '#".expand('<cword>')."' **/*.css"
    elseif class_pos > id_pos
      execute ":vim '.".expand('<cword>')."' **/*.css"
    endif
  endif
endfunction

nnoremap <F9> :call JumpToCSS()<CR>

" source http://stackoverflow.com/a/12835224
" }}}
" Base16 helper {{{

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
  source ~/dotfiles/color/rmbackground.vim
endif

hi Search cterm=NONE ctermfg=black 
hi CursorLineNr   cterm=bold

"}}}
" Toggle between relative and absolute line numbers {{{

function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
        set number!
    else
        set relativenumber
    endif
endfunc

" }}}
" *****************************************************************************
" }}}
" Plugin settings {{{
" *****************************************************************************
" Syntastic {{{

let g:syntastic_javascript_checkers = ['jshint'] 
let g:syntastic_html_checkers = ['w3']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_classpath = "./lib/*.jar\n./src"
"let g:EclimFileTypeValidate = 0
"let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

" }}}
" NerdTree {{{

map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.pyc', '\.class', '\~$', '\.swo$', '\.swp$', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeMinimalUI=1

" }}}
" Airline {{{

" Correccion de los caracters extraños (espacios en blanco)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#whitespace#enabled = 0      "Desactivar la deteccion
let g:airline#extensions#tabline#enabled = 1         "Activar tabline
"let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = 'X'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#syntastic#enabled = 1       "Enable syntastic 
"let g:airline#extensions#tabline#show_tab_nr = 0   "Show tab number
let g:airline#extensions#tabline#tab_nr_type = 1 " index number
"let g:airline#extensions#tabline#fnamemod = ':t'    "Desplegar solo el nombre
"let g:airline_section_c = '%F'                      "Full path and filename
"let g:airline#extensions#bufferline#enabled = 1     "bufferline  
let g:airline#extensions#tabline#tab_min_count = 2  
let g:airline#extensions#virtualenv#enabled = 1
let g:tmuxline_preset = 'full'
let g:airline_theme = 'base16_solarized'
let g:airline_powerline_fonts=1
"Configure whether buffer numbers should be shown
"let g:airline#extensions#tabline#buffer_nr_show = 1
"let g:tmuxline_powerline_separators = 0

"enable/disable displaying index of the buffer.
"When enabled, numbers will be displayed in the tabline and mappings will be
"exposed to allow you to select a buffer directly.  Up to 9 mappings will be
"exposed.

"let g:airline#extensions#tabline#buffer_idx_mode = 1
"nmap <leader>1 <Plug>AirlineSelectTab1
"nmap <leader>2 <Plug>AirlineSelectTab2
"nmap <leader>3 <Plug>AirlineSelectTab3
"nmap <leader>4 <Plug>AirlineSelectTab4
"nmap <leader>5 <Plug>AirlineSelectTab5
"nmap <leader>6 <Plug>AirlineSelectTab6
"nmap <leader>7 <Plug>AirlineSelectTab7
"nmap <leader>8 <Plug>AirlineSelectTab8
"nmap <leader>9 <Plug>AirlineSelectTab9


"Desactivar flechas
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"let g:airline_left_alt_sep = '│'
"let g:airline_right_alt_sep = '│'
"let g:airline#extensions#tabline#left_sep = ''
"let g:airline#extensions#tabline#left_alt_sep = '│'
"let g:airline#extensions#tabline#right_sep = ''
"let g:airline#extensions#tabline#right_alt_sep = '│'
"   
"let g:tmuxline_separators = {
"    \ 'left' : '',
"    \ 'left_alt': '',
"    \ 'right' : '',
"    \ 'right_alt' : '│',
"    \ 'space' : ' '}
" }}}
" ctrlp {{{

let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|class)$',
  \ }
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0

" CtrlP mappings
nnoremap <leader>f :CtrlPBuffer<CR>

" }}}
" PythonMode {{{

" Disable if python support not present
if !has('python')
    let g:pymode = 1
endif

" Automatic virtualenv detection
let g:pymode_virtualenv = 1

" Turn off the run code script  
let g:pymode_run = 0
let g:pymode_lint_checker = "pyflakes"
let g:pymode_utils_whitespaces = 0
let g:pymode_options = 0
let g:pymode_lint_on_write = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0
let g:pydoc_open_cmd = 'vsplit' 

" }}}
" YouCompleteMe {{{

" Cerrar la ventana de previsualizacion despues del completado semantico
let g:ycm_autoclose_preview_window_after_completion = 1

" Cerrar la ventana de previsualizacion despues de salir del modo Insert
" Default 0
let g:ycm_autoclose_preview_window_after_insertion = 0

" Compatibilidad con python mode (autocompletado correcto despues de .)
let g:pymode_rope_complete_on_dot = 0

" Youcompleteme eclim 
" let g:EclimCompletionMethod = 'omnifunc'

" }}}
" UltiSnips {{{

let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" }}}
" Matchtag always {{{

" Custom MatchTag syntax group with a default highlight color 
"let g:mta_use_matchparen_group = 0

" }}}
" Vim notes {{{

let g:notes_directories = ['~/Documentos/Notas']

" }}}
" Git gutter {{{

nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterRevertHunk

" }}}
" Smooth scroll {{{

noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" }}}
" Vimux {{{

" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane map
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane map
map <Leader>vx :VimuxInterruptRunner<CR>
" Clear the tmux history of the runner pane
map <Leader>vc :VimuxClearRunnerHistory<CR>

" }}}
" Preview file on browser {{{

nnoremap <F2>f :!firefox %<CR>
nnoremap <F2>c :!chromium-browser %<CR>
nnoremap <F2>g :!google-chrome %<CR>

" }}}
" Tagbar {{{

nmap <Leader>tt :TagbarToggle<CR> 

let g:tagbar_type_css = {
            \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }

" }}}
" Pytest {{{

nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>

" }}}
" Webdevicons {{{

let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

"}}}
" *****************************************************************************
" }}}
