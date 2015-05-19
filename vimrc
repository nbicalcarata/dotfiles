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
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
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
"Plug '907th/vim-auto-save'
Plug 'mbbill/undotree'
Plug 'FelikZ/ctrlp-py-matcher'

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
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

Plug 'Valloric/YouCompleteMe'
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

set background=dark                             " Assume a dark background
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing
scriptencoding utf-8
set clipboard=unnamedplus
set shortmess+=cfilmnrxoOtT                     " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set history=1000                                " Store a ton of history (default is 20)
set nospell                                     " Spell checking off
set hidden                                      " Allow buffer switching without saving
set foldenable                                  " Enable folding
set foldlevel=99                                " Folds open at start"
set timeoutlen=1000 ttimeoutlen=0               " Eliminar retardo de Insert a Normal

" Setting up the directories {{{

cd ~/Codigo/                                   " Default directory
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
" *****************************************************************************
" }}}
" Autocmd rules {{{
" *****************************************************************************
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
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
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

" }}}
"  PHP Override Higlighting {{{

function! PhpSyntaxOverride()
    hi! def link phpDocTags  phpDefine
    hi! def link phpDocParam phpType
endfunction

augroup phpSyntaxOverride
    autocmd!
    autocmd FileType php call PhpSyntaxOverride()
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
" *****************************************************************************
" }}}
" Visual settings {{{
" *****************************************************************************
" General {{{

set synmaxcol=120
set ttyfast
set foldmethod=marker
"set colorcolumn=80
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
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•

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
    set statusline=%<%f\                     " Filename
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
" Column markers {{{
" 80
"let &colorcolumn=join(range(81,999),",")
" 80 and 120
let &colorcolumn="80,".join(range(120,999),",")

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
    "set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
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
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_loc_list_= 5

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
let NERDTreeRespectWildIgnore=1
let NERDTreeMapOpenVSplit='v'

" }}}
" Airline {{{

let g:airline_powerline_fonts = 1
let g:tmuxline_preset = 'full'
let g:airline_theme = 'base16'

let g:airline#extensions#tabline#enabled = 1            "Activar tabline
let g:airline#extensions#tabline#show_buffers = 0       "No mostrar buffers
let g:airline#extensions#tabline#tab_min_count = 2      "Activar solo cuando hay 2 tabs
let g:airline#extensions#syntastic#enabled = 1          "Enable syntastic
let g:airline#extensions#virtualenv#enabled = 1

" }}}
" CtrlP {{{

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc|class|pdf)$',
  \ }
let g:ctrlp_use_caching = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_open_new_file = 'r'          " Open new file in current window
let g:ctrlp_mruf_max = 250
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:20'

" CtrlP mappings
nnoremap <leader>b :CtrlPBuffer<CR>

" Speed up search with ctrlp-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

" Indexing with the_silver_searcher, install with: sudo dnf install the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
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

"Box Drawings Heavy Vertical U+25e3
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'
let g:gitgutter_sign_modified_removed = '┃'

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

"let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

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
" *****************************************************************************
" }}}
