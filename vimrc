" Entorno ---------------------------------

set nocompatible              " be iMproved
set modelines=0

filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My bundles here: ----------------------------
" General
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'flazz/vim-colorschemes'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'bling/vim-airline'
Bundle 'bling/vim-bufferline'
Bundle 'daylerees/colour-schemes', { 'rtp': 'vim-themes/' }
Bundle 'chriskempson/base16-vim'
Bundle 'mhinz/vim-startify'
"Bundle 'koron/minimap-vim'

"Programacion
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplete.vim.git'
Bundle 'tpope/vim-fugitive'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

"Snippets & AutoComplete"
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

"Python
Bundle 'klen/python-mode'
Bundle 'python.vim'
Bundle 'python_match.vim'
Bundle 'pythoncomplete'

"Javascript {
Bundle 'elzr/vim-json'
Bundle 'groenewege/vim-less'
Bundle 'pangloss/vim-javascript'
Bundle 'briancollins/vim-jst'

"HTML {
Bundle 'hail2u/vim-css3-syntax'
Bundle 'tpope/vim-haml'
Bundle 'lordm/vim-browser-reload-linux'

" Ruby {
Bundle 'tpope/vim-rails'
let g:rubycomplete_buffer_loading = 1
"let g:rubycomplete_classes_in_global = 1
"let g:rubycomplete_rails = 1

"Django
Bundle 'mjbrownie/vim-htmldjango_omnicomplete'

"Misc
Bundle 'tpope/vim-markdown'


filetype plugin indent on     " required!

" General ---------------------------------

set background=dark         " Assume a dark background
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8
set clipboard=unnamedplus

autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" Always switch to the current file directory

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set nospell                         " Spell checking off
set hidden                          " Allow buffer switching without saving
set nofoldenable                    "Disable folding

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

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

" Setting up the directories ---------------------------------

set noswapfile
set backup               " Backups are nice ...
if has('persistent_undo')
   set undofile                " So is persistent undo ...
   set undolevels=1000         " Maximum number of changes that can be undone
   set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
let mapleader = ","

" Vim UI -------------------------------------
set relativenumber
"set number
colorscheme darkburn
set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
"set cursorline                  " Highlight current line
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
                                " Selected characters/lines in visual mode
endif

if has('statusline')
    set laststatus=2
    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
"set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
"set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
"set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" Formatting

set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

"Omnicompletion

autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango

"Key remapping -------------------------------------
"Ctr+C, Ctrl+V keys to copy paste
"nmap <C-V> "+gP
""imap <C-V> <ESC><C-V>i
"vmap <C-C> "+y

"Preview file on browser
nnoremap <F12>f :exe ':silent !firefox %'<CR>
nnoremap <F12>c :exe ':silent !chromium-browser %'<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Same for 0, home, end, etc
noremap $ g$
noremap <End> g<End>
noremap 0 g0
noremap <Home> g<Home>
noremap ^ g^

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

 " Shortcuts--------------------------------------
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
" Change Working Directory to that of the current file cmap cwd lcd %:p:h cmap cd. lcd %:p:h 
" Visual shifting (does not exit Visual mode) vnoremap < <gv vnoremap > >gv 
" Allow using the repeat operator with a visual selection (!) 
" http://stackoverflow.com/a/8064607/127816 vnoremap . :normal .<CR> 
" Fix home and end keybindings for screen, particularly on mac 
" - for some reason this fixes the arrow keys too. huh. map [F $ imap [F $ map [H g0 imap [H g0 
" For when you forget to sudo.. Really Write the file. cmap w!! w !sudo tee % >/dev/null 
" Some helpers to edit mode " http://vimcasts.org/e/14 cnoremap %% <C-R>=expand('%:h').'/'<cr> map <leader>ew :e %% map <leader>es :sp %%

map <leader>ev :vsp %%
map <leader>et :tabe %%

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

"Plugins
let g:NERDShutUp=1
let b:match_ignorecase = 1

"Syntastic ================================
let g:syntastic_javascript_checkers = ['jshint'] 
let g:syntastic_html_checkers = ['w3']

"Neocomplete ==================================
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.hg', '\.svn', '\.bzr']
"If it is set to 0 then the CWD is never changed by the NERD tree.

"If set to 1 then the CWD is changed when the NERD tree is first loaded to the
"directory it is initialized in. For example, if you start the NERD tree with >
"    :NERDTree /home/marty/foobar
"then the CWD will be changed to /home/marty/foobar and will not be changed
"again unless you init another NERD tree with a similar command.

"If the option is set to 2 then it behaves the same as if set to 1 except that
"the CWD is changed whenever the tree root is changed. For example, if the CWD
"is /home/marty/foobar and you make the node for /home/marty/foobar/baz the new
"root then the CWD will become /home/marty/foobar/baz.
let NERDTreeChDirMode=2
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=0
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

"JSON
nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>

" PyMode
let g:pymode_lint_checker = "pyflakes"
let g:pymode_utils_whitespaces = 0
let g:pymode_options = 0

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

" On Windows use "dir" as fallback command.
if has('win32') || has('win64')
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'dir %s /-n /b /s /a-d'
    \ }
else
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
            \ 2: ['.hg', 'hg --cwd %s locate -I .'],
        \ },
        \ 'fallback': 'find %s -type f'
    \ }
endif

" PythonMode 
" Disable if python support not present
if !has('python')
    let g:pymode = 1
endif

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

" vim-airline 
" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols , , , , , , and .in the statusline
let g:airline_powerline_fonts=0
" If the previous symbols do not render for you then install a
" powerline enabled font.

"Establecer el tema de airline
let g:airline_theme = 'base16'
let g:airline_left_sep=''  " Slightly fancier than '>'
let g:airline_right_sep='' " Slightly fancier than '<'

if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    "let g:airline_left_sep='›'  " Slightly fancier than '>'
    "let g:airline_right_sep='‹' " Slightly fancier than '<'
endif

"Correcion de los carac:ters extraños (espacios en blanco)
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"Desactivar la deteccion de espacios en blanco
let g:airline#extensions#whitespace#enabled = 0

"Activar tabline
"let g:airline#extensions#tabline#enabled = 1

"Desactivar bufferline dentro de airline
let g:airline#extensions#bufferline#enabled = 0

"Eliminar retardo al pasar de Insert a Normal ==================
set timeoutlen=1000 ttimeoutlen=0

"No delay between Insert and Normal mode
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END

" GUI Settings  ====================================

" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    "set guioptions-=m           " Remove the menubar
    "set lines=40                " 40 lines of text instead of 24
    set lines=999 columns=999    " Start maximized
    set guifont=Inconsolata\ Regular\ 14,Droid\ Sans\ Mono\ Regular\ 12,Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 18
    if has("gui_gtk2")
        set lazyredraw
        set guifont=Inconsolata\ Regular\ 14,Droid\ Sans\ Mono\ Regular\ 12,Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 18
        colorscheme base16-default
    endif
    if &term == 'xterm' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
endif

let g:startify_custom_header = [
            \'            Yb    dP 88 8b    d8   888888P       dP88 ',
            \'             Yb  dP  88 88b  d88       dP       dP 88 ',
            \'              YbdP   88 88YbdP88      dP   .o. d888888',
            \'               YP    88 88 YY 88     dP    """     88',
            \'',
            \'',
            \]

let g:startify_files_number = 15
let g:startify_list_order = ['files', 'bookmarks', 'sessions']

"vim-browser-reload-linux

"Depends on xdotool
"browser reload:

":ChromeReload <regex>      //reload Google Chrome with optional regex for window title
":FirefoxReload     //reload Firefox
":OperaReload       //reload Opera
":AllBrowserReload  //reload all browser

"start auto reload:

":ChromeReloadStart
":FirefoxReloadStart
":OperaReloadStart
":AllBrowserReloadStart

"stop auto reload:

":ChromeReloadStop
":FirefoxReloadStop
":OperaReloadStop
":AllBrowserReloadStart

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

 "Initialize NERDTree as needed {
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


