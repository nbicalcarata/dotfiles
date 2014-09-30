"*****************************************************************************
"" Bundle core
"*****************************************************************************

set nocompatible              " be iMproved
set modelines=0

filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"*****************************************************************************
"" Bundle install packages
"*****************************************************************************

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'bling/vim-airline'
Plugin 'mklabs/vim-fetch'
Plugin 'justinmk/vim-gtfo'
Plugin 'edkolev/tmuxline.vim'
Plugin 'scrooloose/syntastic'
Plugin 'severin-lemaignan/vim-minimap' 
Plugin 'dhruvasagar/vim-vinegar'

"" Color
Plugin 'nbicalcarata/vim-womprat'
Plugin 'nbicalcarata/vim-airline-womprat'
Plugin 'nanotech/jellybeans.vim'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'twerth/ir_black'

"" Git
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-fugitive'

"" Html
Plugin 'Valloric/MatchTagAlways'
Plugin 'chrisgillis/vim-bootstrap3-snippets'
Plugin 'mattn/emmet-vim'

"" Snippets & AutoComplete"
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'

"" Python
Plugin 'klen/python-mode'
Plugin 'python.vim'
Plugin 'python_match.vim'
Plugin 'jmcantrell/vim-virtualenv'


call vundle#end()            " required
filetype plugin indent on     " required!

"*****************************************************************************
"" Basic Setup
"*****************************************************************************

set background=dark         " Assume a dark background
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set clipboard=unnamedplus

let mapleader = ","

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set nospell                         " Spell checking off
set hidden                          " Allow buffer switching without saving
set nofoldenable                    " Disable folding
set timeoutlen=1000 ttimeoutlen=0   " Eliminar retardo de Insert a Normal 

" Setting up the directories 
set noswapfile
set backup                     " Backups are nice ...
if has('persistent_undo')
   set undofile                " So is persistent undo ...
   set undolevels=1000         " Maximum number of changes that can be undone
   set undoreload=10000        " Maximum number lines to save for undo 
endif

" Wild menu options
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


"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Running code with ,r
autocmd FileType python map <leader>r :w<CR>:!python %<CR>
autocmd FileType bash map <leader>r :w<CR>:!./%<CR>
autocmd FileType java map <leader>c :w<CR>:!javac %<CR>
autocmd FileType java map <leader>r :w<CR>:!java %:r<CR>

" Restore cursor to file position in previous editing session
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

"Omnicompletion
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango

" NERDTree open with vim
" autocmd vimenter * NERDTree

"No delay between Insert and Normal mode
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END


"*****************************************************************************
"" Visual Settigns
"*****************************************************************************

set number
set wrap
set linebreak
set title
set nolist
set t_Co=256                    " Enable 256 colors
colorscheme womprat
set lazyredraw
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set hlsearch                    " Highlight search matches
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set showmatch                   " show matching brackets/parenthesis
set incsearch                   " Find as you type search
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolloff=5                 " Minimum lines to keep above and below cursor
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight whitespace

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                    "Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" Formatting
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after 
                                " punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right 
set splitbelow                  " Puts new split windows to the bottom
let loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set matchpairs+=<:>             " Match, to be used with %
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" Cursor line
hi CursorLine ctermbg=237 ctermfg=none

set cursorline

" Cursor Line number styling
hi CursorLineNr   cterm=bold ctermfg=Grey gui=bold guifg=Grey

"let g:jellybeans_background_color_256='NONE'

" Colorcolumn
"set colorcolumn=81

" Styling vertical splits
set fillchars=vert:│,diff:⎼,fold:⎼

" Virtualenv
let g:airline#extensions#virtualenv#enabled = 1

" Tmux line
let g:tmuxline_preset = 'tmux'

" vim-airline
let g:airline_theme = 'womprat'
let g:airline_powerline_fonts=1


"Configure whether buffer numbers should be shown
"let g:airline#extensions#tabline#buffer_nr_show = 1

" Correccion de los caracters extraños (espacios en blanco)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#whitespace#enabled = 0  "Desactivar la deteccion
"let g:airline#extensions#tabline#enabled = 1     "Activar tabline
let g:airline#extensions#syntastic#enabled = 1   "Enable syntastic integration
"let g:airline#extensions#eclim#enabled = 0      "Enable eclim integration
"let g:airline#extensions#tabline#fnamemod = ':t' "Desplegar solo el nombre
"let g:airline_section_c = '%F'                 "Full path and filename
"let g:airline#extensions#bufferline#enabled = 0 "Desactivar bufferline dentro 

" GUI Settings
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
    set guifont=Inconsolata\ for\ Powerline\ 14
endif

"*****************************************************************************
"" Mappings
"*****************************************************************************

" Ctr+C, Ctrl+V keys to copy paste
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Buffer switching mappings 
" left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>

" Keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" Preview file on browser
nnoremap <F2>f :!firefox %<CR>
nnoremap <F2>c :!chromium-browser %<CR>
nnoremap <F2>g :!google-chrome %<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Same for 0, home, end, etc
noremap $ g$
noremap <End> g<End>
noremap 0 g0
noremap <Home> g<Home>
noremap ^ g^

" Fugitive 
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gr :Gread<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gg :SignifyToggle<CR>

" Shortcuts
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Find character under cursor with ,zx
nnoremap <leader>z xhp/<C-R>-<CR>

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
map <silent> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

let b:match_ignorecase = 1

" Syntastic
let g:syntastic_javascript_checkers = ['jshint'] 
let g:syntastic_html_checkers = ['w3']
let g:syntastic_java_checkers = ['javac']
let g:syntastic_java_javac_classpath = "./lib/*.jar\n./src"
"let g:EclimFileTypeValidate = 0
let g:syntastic_mode_map = {'mode': 'passive'}

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.pyc', '\.class', '\~$', '\.swo$', '\.swp$', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=2
"let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeMinimalUI=1


" Smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" ctrlp
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

" PythonMode 
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


"" YouCompleteMe
" Cerrar la ventana de previsualizacion despues del completado semantico
let g:ycm_autoclose_preview_window_after_completion = 1

" Cerrar la ventana de previsualizacion despues de salir del modo Insert
" Default 0
let g:ycm_autoclose_preview_window_after_insertion = 0

" Compatibilidad con python mode (autocompletado correcto despues de .)
let g:pymode_rope_complete_on_dot = 0

" Youcompleteme eclim 
" let g:EclimCompletionMethod = 'omnifunc'

"" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"*****************************************************************************
"" Functions
"*****************************************************************************

" Initialize directories {
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

" Initialize NERDTree as needed
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

" Change status on tmux
function! AddTmuxline()
  if exists(':Tmuxline')
    augroup airline_tmuxline
      au!
      au InsertEnter * Tmuxline airline_insert
      au InsertLeave * Tmuxline airline
    augroup END
  endif
endfunction
au VimEnter * :call AddTmuxline()
