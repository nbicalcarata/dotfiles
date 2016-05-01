" Plug core {{{

set nocompatible              " be iMproved
set modelines=0

" Identify plataform
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction

" Plug automatic installation

let basedir = '.vim'

if WINDOWS()
    let basedir = 'vimfiles'
endif

if empty(glob('~/' . basedir . '/autoload/plug.vim'))
    silent !mkdir -p '~/' . basedir . '/autoload'
    silent !curl -fLo '~/' . basedir . '/autoload/plug.vim'
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/' . basedir . '/plugged')

" }}}
" Plug install packages {{{

" General {{{

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'mklabs/vim-fetch'
Plug 'justinmk/vim-gtfo'
"Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/syntastic'
Plug 'severin-lemaignan/vim-minimap'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'dhruvasagar/vim-vinegar'
"Plug 'ryanoasis/vim-webdevicons'
"Plug '907th/vim-auto-save'
Plug 'mbbill/undotree'
Plug 'Harenome/vim-neatfoldtext'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'rking/ag.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neoyank.vim'
"}}}
" Colorschemes {{{

Plug 'nbicalcarata/vim-womprat'
Plug 'nbicalcarata/vim-airline-womprat'
Plug 'nbicalcarata/vim-airline-dieciseis'
Plug 'nanotech/jellybeans.vim'
Plug 'sickill/vim-monokai'
Plug 'tomasr/molokai'
Plug 'nbicalcarata/Muon'
Plug 'vim-scripts/lilypink'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" }}}
" Git {{{

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'

" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'jaxbot/browserlink.vim'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

if has('lua') && (version >= 704 || version == 703 && has('patch885'))
    Plug 'Shougo/neocomplete.vim'
    let g:completionEngine = 'neocomplete'
else
    Plug 'Valloric/YouCompleteMe'
    let g:completionEngine = 'YouCompleteMe'
endif

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

" }}}
" Python {{{

Plug 'klen/python-mode'
Plug 'python.vim'
Plug 'python_match.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'alfredodeza/pytest.vim'

" }}}
" PHP {{{

Plug 'StanAngeloff/php.vim'
Plug 'jwalton512/vim-blade'

" }}}

" }}}
" Plug end {{{

call plug#end()

" }}}

" Basic setup {{{

" Basics {

if !WINDOWS()
    set shell=/bin/sh
endif

scriptencoding utf-8
set background=dark                             " Assume a dark background
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing

if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif

set shortmess+=filmnrxoOtT                     " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
set nospell                                     " Spell checking off
set hidden                                      " Allow buffer switching without saving
set foldenable                                  " Enable folding
set foldlevel=99                                " Folds open at start"
set timeoutlen=1000 ttimeoutlen=0               " Eliminar retardo de Insert a Normal

" Setting up the directories {{{

"cd ~/Codigo/                                   " Default directory
set noswapfile
set backup                                     " Backups are nice ...
if has('persistent_undo')
    set undofile                                " So is persistent undo ...
    set undolevels=10000                        " Maximum number of changes that can be undone
    set undoreload=10000                        " Maximum number lines to save for undo
endif

" }}}
" Wild menu options {{{

set wildmenu                                             " cmd line completion ala zsh
set wildmode=list:longest                                " matches mimic bash or zsh
set wildignore+=node_modules                             " node_modules dir
set wildignore+=.ropeproject                             " py rope cache dir
set wildignore+=.hg,.git,.svn                            " Version control
set wildignore+=*.aux,*.out,*.toc                        " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico     " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest         " compiled object files
set wildignore+=*.spl                                    " compiled spelling word lists
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=migrations                               " Django migrations
set wildignore+=*.pyc                                    " Python byte code
set wildignore+=*.class                                  " Java byte code
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar           " MacOSX/Linux

" }}}

" }}}
" Autocmd rules {{{

" Always switch to the current file directory {{{

augroup SwitchCurrentFile
    autocmd!
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" }}}
" Running code with ,r {{{

augroup RunningCode
    autocmd!
    autocmd FileType python map <leader>r :w<CR>:!python %<CR>
    autocmd FileType php map <leader>r :w<CR>:!php %<CR>
    autocmd FileType bash map <leader>r :w<CR>:!./%<CR>
    autocmd FileType java map <leader>c :w<CR>:!javac %<CR>
    autocmd FileType java map <leader>r :w<CR>:!java %:r<CR>
augroup END

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

augroup OmniCompletion
    autocmd!
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END
" }}}
" Close vim when the window left open is Nerdtree {{{

augroup CloseVimNerdtree
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}
"No delay between Insert and Normal mode {{{

augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" }}}
" Only show cursorline in the current window {{{

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" }}}
" Open help files in right side {{{

augroup HelpFilesRightSide
    autocmd!
    autocmd FileType help :wincmd L
    autocmd FileType help set bufhidden=unload
augroup END

" }}}
" Disable colorcolumn on specific files {{{

augroup DisableColorcolumn
    autocmd!
    au BufNewFile,BufRead *.html setlocal colorcolumn=
    au BufNewFile,BufRead *.php setlocal colorcolumn=
    autocmd FileType vim-plug setl colorcolumn=
augroup END

" }}}
" Disable list on preview window {{{

augroup DisableListPreviewWindow
    autocmd!
    autocmd WinEnter * if &previewwindow | setlocal nolist | endif
augroup END

" }}}
" Detect django files {{{

augroup DjangoFiles
    autocmd!
    au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    au BufNewFile,BufRead models.py    setlocal filetype=python.django
    au BufNewFile,BufRead views.py     setlocal filetype=python.django
    au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    "au BufNewFile,BufRead *.html       setlocal filetype=htmldjango
augroup END

" }}}
" Enable minimap at start {{{

"autocmd! VimEnter * Minimap
"let g:minimap_highlight='LineNr'

" }}}
" }}}
" PHP with html syntax {{{
  
augroup phpLaravel
    autocmd!
    autocmd BufRead,BufNewFile *.php set filetype=php.laravel.html
    autocmd BufRead,BufNewFile *.blade.php set filetype=blade.html
augroup END

" }}}
" Nerdtree {{{

augroup NerdtreeRules
    autocmd!
    autocmd FileType nerdtree setlocal nolist       " suppress whitespace highlighting
    autocmd FileType nerdtree setlocal nofoldenable " suppress folding
    autocmd FileType nerdtree setlocal colorcolumn= " no colorcolumn
augroup END

" }}}

" Visual settings {{{

" General {{{

set ttyfast
set foldmethod=marker
set number
set nowrap
set linebreak
set title
set visualbell t_vb=            " turn off error beep/flash
set novisualbell                " turn off visual bell
set noea
set t_Co=256                    " Enable 256 colors
set lazyredraw
set noshowmode                  " Dont display the current mode
"set hlsearch                   " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " Find as you type search
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set scrolloff=5                 " Minimum lines to keep above and below cursor

if LINUX()
    set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
endif

" }}}
" Formatting {{{

set autoindent                  " Indent at the same level of the previous line
filetype plugin indent on
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after
set splitright                  " Puts new vsplit windows to the right
set splitbelow                  " Puts new split windows to the bottom
let loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" }}}
" Colorschemes {{{

colorscheme jellybeans
"let g:jellybeans_use_lowcolor_black = 0

" }}}
" Cursor line {{{

set cursorline

" }}}
" Statusline {{{

if has('statusline')
    set laststatus=2
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" }}}
" Styling vertical splits {{{
if LINUX()
    set fillchars=vert:│,diff:⎼,fold:⎼
    "set fillchars=vert:┃,diff:⎼,fold:⎼
endif

augroup OverrideColor
    autocmd!
    autocmd ColorScheme * highlight VertSplit guibg=NONE cterm=NONE ctermbg=NONE
    autocmd ColorScheme * highlight Folded    guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight Number    guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight LineNr    guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight GitGutterAdd guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight GitGutterChange guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight GitGutterDelete guibg=NONE ctermbg=none
    autocmd ColorScheme * highlight GitGutterChangeDelete guibg=NONE ctermbg=none
augroup END

" }}}

" }}}

" Mappings {{{

let mapleader = ","
" Space to fold
nnoremap <space> za
" Quick edit vimrc
nnoremap <leader>ev :vsplit ~/dotfiles/vimrc<cr>
nnoremap <leader>sv :source ~/dotfiles/vimrc<cr>

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

" Toggle between invisible chars
nmap <leader>l :set list!<CR>

" Ag
"nnoremap <leader>a :Ag 

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

" }}}
" Functions {{{

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
" NERDTree File highlighting {{{

" FileType <> filetype
function! NERDTreeHighlightFile(extension, fg, bg)
    exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
    exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none')
call NERDTreeHighlightFile('ini', 'yellow', 'none')
call NERDTreeHighlightFile('md', 'darkgrey', 'none')
call NERDTreeHighlightFile('markdown', 'darkgrey', 'none')
call NERDTreeHighlightFile('yml', 'yellow', 'none')
call NERDTreeHighlightFile('config', 'yellow', 'none')
call NERDTreeHighlightFile('conf', 'yellow', 'none')
call NERDTreeHighlightFile('json', 'yellow', 'none')
call NERDTreeHighlightFile('html', 'yellow', 'none')
call NERDTreeHighlightFile('styl', 'cyan', 'none')
call NERDTreeHighlightFile('css', 'cyan', 'none')
call NERDTreeHighlightFile('coffee', 'Red', 'none')
call NERDTreeHighlightFile('js', 'Red', 'none')
call NERDTreeHighlightFile('php', 'Magenta', 'none')
call NERDTreeHighlightFile('py', 'green', 'none')
call NERDTreeHighlightFile('sh', 'grey', 'none')
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
" Set airline and colorscheme color {{{

function! Base16(scheme)
    execute 'colorscheme base16-' . a:scheme
    let g:airline_theme = 'base16_' . a:scheme
endfunction

" }}}

hi Search cterm=NONE ctermfg=black
hi CursorLineNr   cterm=bold

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
" Toggle colorcolumn {{{

function! g:ToggleColorColumn()
  if &colorcolumn != ''
    set colorcolumn&
  else
    let &colorcolumn="80,".join(range(120,999),",")
  endif
endfunction

nnoremap <silent> <leader>co :call g:ToggleColorColumn()<CR>

" }}}

" }}}
" Plugin settings {{{

" Syntastic {{{

let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_html_checkers = ['w3']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_classpath = "./lib/*.jar\n./src"
"let g:EclimFileTypeValidate = 0
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
if LINUX()
    let g:syntastic_error_symbol = "✗"
    let g:syntastic_warning_symbol = "⚠"
endif
let g:syntastic_loc_list_= 5

" }}}
" NerdTree {{{

map <C-e> :NERDTreeToggle<CR>:silent NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.pyc', '\.class', '\~$', '\.swo$', '\.swp$', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeMinimalUI=1
let NERDTreeRespectWildIgnore=1
let NERDTreeMapOpenVSplit='v'

" }}}
" Airline {{{
let g:replace_separators = 0
let g:airline_powerline_fonts = 1
let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#snapshot_file = "~/dotfiles/snapshot_tmuxline"
let g:airline_theme = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1            " Activar tabline
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#branch#empty_message = '*'
let g:airline#extensions#whitespace#enabled = 0

"Remove percentage
"let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
let g:airline_section_c = airline#section#create(['%<%F'])
let g:airline_section_z = ' %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#/%L%/:%3v'

" Short names
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

" Remove separators
if get(g:, 'replace_separators', 1)

    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    if LINUX()
        let g:airline_left_alt_sep = '│'
        let g:airline_right_alt_sep = '│'
    endif
    let g:tmuxline_powerline_separators = 0

    let g:tmuxline_separators = {
          \ 'left' : '',
          \ 'left_alt': ':',
          \ 'right' : '',
          \ 'right_alt' : '│',
          \ 'space' : ' '}
endif

" }}}
" Unite {{{
"
nnoremap <leader>f :<C-u>Unite -buffer-name=files file<CR>
nnoremap <leader>a :<C-u>Unite -buffer-name=files_rec file_rec/async:!<CR>
nnoremap <silent> <leader>b :<C-u>Unite -buffer-name=buffers buffer bookmark<CR>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
let g:unite_source_codesearch_ignore_case = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file,file/new,file_mru,buffer,file_rec',
    \ 'matchers', 'matcher_fuzzy')
let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_source_history_yank_enable=1
if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts='-i -r --line-numbers --nocolor --nogroup -S'
    let g:unite_source_grep_recursive_opt = ''
endif

" Start insert.
call unite#custom#profile('default', 'context', {
\   'start_insert': 1
\ })

" Like ctrlp.vim settings.
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 20,
\   'direction': 'botright',
\ })

" settings for neomru
let g:neomru#file_mru_limit = 10
let g:neomru#file_mru_ignore_pattern = 'COMMIT_EDITMSG'

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <silent><buffer><expr> Enter unite#do_action('switch')
  nmap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  nmap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

  imap <silent><buffer><expr> Enter unite#do_action('switch')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabswitch')
  imap <silent><buffer><expr> <C-h> unite#do_action('splitswitch')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplitswitch')

"  map <buffer> <C-p> <Plug>(unite_toggle_auto_preview)

  nnoremap <ESC> :UniteClose<cr>
endfunction

if WINDOWS()
endif

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
" YouCompleteMe and Neocomplete {{{
if g:completionEngine == 'YouCompleteMe'
	" Cerrar la ventana de previsualizacion despues del completado semantico
    let g:ycm_autoclose_preview_window_after_completion = 1

    " Cerrar la ventana de previsualizacion despues de salir del modo Insert
    " Default 0
    let g:ycm_autoclose_preview_window_after_insertion = 0

    " Compatibilidad con python mode (autocompletado correcto despues de .)
    let g:pymode_rope_complete_on_dot = 0

    " Youcompleteme eclim
    " let g:EclimCompletionMethod = 'omnifunc'

elseif exists('g:completionEngine')
	let g:acp_enableAtStartup=0
	let g:{g:completionEngine}#enable_at_startup=1
	let g:{g:completionEngine}#enable_smart_case=1
	let g:{g:completionEngine}#sources#syntax#min_keyword_length=3
	let g:{g:completionEngine}#max_list=10
	let g:{g:completionEngine}#auto_completion_start_length=3
	let g:{g:completionEngine}#sources#dictionary#dictionaries={  'default' : '' }
	let g:{g:completionEngine}#sources#omni#input_patterns={}
	let g:{g:completionEngine}#keyword_patterns={ 'default': '\h\w*' }
	let g:{g:completionEngine}#data_directory="~/.cache/neocomplete"
	inoremap <expr><C-g>     {g:completionEngine}#undo_completion()
	inoremap <expr><C-l>     {g:completionEngine}#complete_common_string()
	inoremap <expr><BS>      {g:completionEngine}#smart_close_popup()."\<C-h>"
	inoremap <expr><TAB>     pumvisible() ? "\<C-n>" : "\<TAB>"
    set completeopt-=preview
endif
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

"Box Drawings Heavy Vertical U+25e3
if LINUX()
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '┃'
    let g:gitgutter_sign_removed = '┃'
    let g:gitgutter_sign_modified_removed = '┃'
endif
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
" Autosave {{{

let g:auto_save = 1                                     " Enable AutoSave on Vim startup
let g:auto_save_no_updatetime = 1                       " Do not change the 'updatetime' option
let g:auto_save_in_insert_mode = 0                      " Do not save while in insert mode
let g:auto_save_silent = 0                              " Do not display the auto-save notification
let g:auto_save_events = ["InsertLeave", "TextChanged"] " Default: [CursorHold,InsertLeave]

" }}}
" Undotree {{{

nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1

" }}}
" NeatFoldText {{{

let g:NeatFoldTextFancy = 1

" }}}
" Webdevicons {{{

"let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 0

" }}}

" }}}
" GUI Settings {{{
if LINUX()
    augroup TransparentGVIM autocmd!
        autocmd GuiEnter * silent exec "!transset -a 0.97"
    augroup END
    nnoremap <F4> :!transset -a -t 0.97<CR>
endif

if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set guioptions-=m           " Remove the menubar
    set guioptions-=L           " Remove nerdtree scroll
    set guioptions-=r           " Remove the scroll bar
    nnoremap <F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
    nnoremap <F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
    nnoremap <F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
    set wrap
    set lines=999 columns=999    " Start maximized
    set lazyredraw
    "colorscheme base16-paraiso
    "let g:airline_theme = 'base16_paraiso'
    call Base16("railscasts")
    set guifont=Hack\ Regular\ 11
    "set guifont=Iosevka\ Regular\ 12
    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ Plus\ Nerd\ File\ Types\ 12
    "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
endif

if has('gui_gtk') && has('gui_running') && LINUX()
    let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
                \' > ~/.gtkrc-2.0'
    exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
                \' >> ~/.gtkrc-2.0'
endif

" }}}
" Windows gvim settings {{{
  
if WINDOWS()
    let g:airline_powerline_fonts = 0
    let g:webdevicons_enable = 0
    let g:webdevicons_enable_ctrlp = 0
    let g:NeatFoldTextFancy = 0
    set guifont=Consolas:h11:cANSI
    colorscheme base16-flat
    let g:airline_theme = 'base16'
endif

" }}}
