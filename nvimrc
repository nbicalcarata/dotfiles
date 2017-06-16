" Plug core {{{

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

"let basedir = '.config/nvim'

if WINDOWS()
    let g:basedir = 'vimfiles'
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" }}}

" General {{{
"Plug 'rliang/nvim-pygtk3', {'do': 'make install'}
Plug 'equalsraf/neovim-gui-shim'
Plug 'scrooloose/nerdtree'
"Plug 'eiginn/netrw'
"Plug 'tpope/vim-vinegar'
Plug 'dhruvasagar/vim-vinegar'
Plug 'scrooloose/nerdcommenter'
Plug 'justinmk/vim-gtfo'
Plug 'mbbill/undotree'
Plug 'Harenome/vim-neatfoldtext'
Plug 'Shougo/neomru.vim'
Plug 'kassio/neoterm'
"Plug 'Shougo/denite.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'FelikZ/ctrlp-py-matcher'
"Plug 'metakirby5/codi.vim'
Plug 'nbicalcarata/vim-zim'
Plug 'joanrivera/vim-zimwiki-syntax'
"Plug 'coxjc/VimSearch'
Plug 'wesQ3/vim-windowswap'
"Plug 'tmhedberg/SimpylFold'
Plug 'pseewald/vim-anyfold'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kevinkjt2000/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'
Plug 'frace/vim-unsurpriseme'
Plug 'mhinz/vim-grepper'
Plug 'Yggdroot/indentLine'

"}}}
" Colorschemes {{{

"Plug 'ujihisa/unite-colorscheme'
"Plug 'nbicalcarata/vim-womprat'
"Plug 'nbicalcarata/vim-airline-womprat'
"Plug 'nbicalcarata/vim-airline-dieciseis'
Plug 'nbicalcarata/vim-airline-darktooth'
Plug 'nanotech/jellybeans.vim'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'AlessandroYorba/Alduin'
Plug 'whatyouhide/vim-gotham'
Plug 'joshdick/onedark.vim'
Plug 'w0ng/vim-hybrid'
Plug 'ayu-theme/ayu-vim'
Plug 'jacoborus/tender'
Plug 'MaxSt/FlatColor'
Plug 'miyakogi/seiya.vim'

" }}}
" Git {{{

"Plug 'mattn/webapi-vim'
"Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
"Plug 'chemzqm/vim-easygit'
Plug 'jreybert/vimagit'
" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"Plug 'wellle/tmux-complete.vim'
" Showing function signature and inline doc.
Plug 'Shougo/echodoc.vim'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
"Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'lvht/phpcd.vim', { 'for': 'php' , 'do': 'composer update' }
"Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
" `npm install` For javascript code completion support
Plug 'roxma/nvim-completion-manager'
" PHP code completion is moved to a standalone plugin
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
"Plug 'roxma/python-support.nvim'
"Plug 'alvan/vim-php-manual'
"Plug 'padawan-php/deoplete-padawan', { 'do': 'composer install' }
" }}}
" Syntax highlighting{{{

Plug 'dominikduda/vim_current_word'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sheerun/vim-polyglot'
"Plug 'ryanoasis/vim-devicons'
"Plug 'tweekmonster/django-plus.vim'
"Plug 'reedes/vim-pencil'
"Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'janko-m/vim-test'
"Plug 'rhysd/nyaovim-mini-browser'
Plug 'StanAngeloff/php.vim'
"Plug 'rafaelndev/deoplete-laravel-plugin', {'for': ['php'], 'do': 'composer install'}
"Plug 'maralla/completor.vim'

" }}}

" Plug end {{{

call plug#end()

" }}}

" Basics {{{

"set shell=/bin/sh

cd ~/Workspace
set completeopt-=preview
set completeopt+=noinsert
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing
set clipboard=unnamedplus
if !WINDOWS()
    set clipboard=unnamed
endif
"set shortmess+=cafilmnrxoOtT                     " Abbrev. of messages (avoids 'hit enter')
set shortmess+=c                     " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set nospell                                     " Spell checking off
set hidden                                      " Allow buffer switching without saving
set foldenable                                  " Enable folding
set foldmethod=marker
set foldcolumn=4
set foldlevel=99                                " Folds open at start"
set timeoutlen=1000 ttimeoutlen=0               " Eliminar retardo de Insert a Normal
set conceallevel=2

" }}}
" Setting up the directories {{{

set noswapfile
set backup                                     " Backups are nice ...
if has('persistent_undo')
    set undofile                                " So is persistent undo ...
    set undolevels=10000                        " Maximum number of changes that can be undone
    set undoreload=10000                        " Maximum number lines to save for undo
endif

function! InitializeDirectories()
    let l:parent = $HOME
    let l:prefix = 'nvim'
    let l:dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir', }

    if has('persistent_undo')
        let l:dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "directory = $HOME . '/.vim/'

    let l:common_dir = l:parent . '/.' . l:prefix

    for [l:dirname, l:settingname] in items(l:dir_list)
        let l:directory = l:common_dir . l:dirname . '/'
        if exists('*mkdir')
            if !isdirectory(l:directory)
                call mkdir(l:directory)
            endif
        endif
        if !isdirectory(l:directory)
            echo 'Warning: Unable to create backup directory: ' . l:directory
            echo 'Try: mkdir -p ' . l:directory
        else
            let l:directory = substitute(l:directory, ' ', '\\\\ ', 'g')
            exec 'set ' . l:settingname . '=' . l:directory
        endif
    endfor
endfunction
call InitializeDirectories()

" }}}
" Wild menu options {{{

set wildignorecase
set wildmode=list:longest,full                           " matches mimic bash or zsh
set wildignore+=.hg,.git,.svn                            " Version control
set wildignore+=*.aux,*.out,*.toc                        " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.ico     " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest         " compiled object files
set wildignore+=*.spl                                    " compiled spelling word lists
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=*.pyc                                    " Python byte code
set wildignore+=*.class                                  " Java byte code
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.rar           " MacOSX/Linux
set wildignore+=*/node_modules/*,*/vendor/*

" }}}
" Autocmd rules {{{

" Running code with ,r {{{

"augroup RunningCode
    "autocmd!
    "autocmd FileType python map <leader>e :w<CR>:!python %<CR>
    "autocmd FileType php map <leader>e :w<CR>:!php %<CR>
    "autocmd FileType bash map <leader>e :w<CR>:!./%<CR>
    "autocmd FileType java map <leader>c :w<CR>:!javac %<CR>
    "autocmd FileType java map <leader>e :w<CR>:!java %:r<CR>
"augroup END

" }}}
" Whitespace settings per filetype {{{

"autocmd Filetype html,blade,php setlocal ts=2 sts=2 sw=2
"autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=4 sts=4 sw=4

" }}}
" Omnicompletion {{{

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
"augroup END

" }}}
" No delay between Insert and Normal mode {{{

"augroup FastEscape
    "autocmd!
    "au InsertEnter * set timeoutlen=0
    "au InsertLeave * set timeoutlen=1000
"augroup END

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
    autocmd FileType help wincmd L
    autocmd FileType help set bufhidden=unload
augroup END

" }}}
" Disable list on preview window {{{

augroup DisableListPreviewWindow
    autocmd!
    autocmd WinEnter * if &previewwindow | setlocal nolist | endif
augroup END

" }}}
" Zim rules {{{

augroup ZimRules
    autocmd!
    autocmd FileType zimwiki setlocal nonumber
    autocmd FileType zimwiki setlocal wrap
    "autocmd BufEnter * if &ft == 'zimwiki' | vert resize 60 | endif
augroup END

" }}}
" NerdTreeExit {{{

augroup NerdTreeExit
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}
" Detgect django files {{{

"augroup DjangoFiles
    "autocmd!
    "au BufNewFile,BufRead admin.py     setlocal filetype=python.django
    "au BufNewFile,BufRead urls.py      setlocal filetype=python.django
    "au BufNewFile,BufRead models.py    setlocal filetype=python.django
    "au BufNewFile,BufRead views.py     setlocal filetype=python.django
    "au BufNewFile,BufRead settings.py  setlocal filetype=python.django
    "au BufNewFile,BufRead forms.py     setlocal filetype=python.django
    ""au BufNewFile,BufRead *.html       setlocal filetype=htmldjango
"augroup END

" }}}
" PHP with html syntax {{{

augroup phpLaravel
    autocmd!
    "autocmd BufRead,BufNewFile *.php UltiSnipsAddFiletypes php.php-laravel.html
    autocmd BufRead,BufNewFile *.blade.php UltiSnipsAddFiletypes php.php-laravel.html
    ""autocmd BufRead,BufNewFile *.blade.php set filetype=blade.html
augroup END

" }}}
" }}}
" Visual settings {{{

" General {{{
set number
set wrap
set linebreak
set title
set visualbell t_vb=            " turn off error beep/flash
set novisualbell                " turn off visual bell
set equalalways
set lazyredraw
set noshowmode                  " Dont display the current mode
set nohlsearch                  " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set scrolloff=5                 " Minimum lines to keep above and below cursor
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set inccommand=split            " live sustitution

if LINUX()
    set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
endif

" }}}
" Formatting {{{

filetype plugin indent on
set autoindent
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after
set splitright                  " Puts new vsplit windows to the right
set splitbelow                  " Puts new split windows to the bottom
let g:loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" }}}
" True color {{{

set termguicolors

" }}}
" Cursor line {{{

set cursorline
let g:terminal_color_7  = '#FBBC05'
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}
" Statusline {{{
set statusline=
set laststatus=2
"set statusline+=\ %(%{'help'!=&filetype?'':''}\ \ %)
set statusline+=\ %(%{'help'!=&filetype?'CWD':''}\ \ %)
set statusline+=%<                                     " Where to truncate line
set statusline+=%{Relative_Path_CWD()}                 " Current dir
"set statusline+=\ \ %f                                " Path relative to current buffer
set statusline+=\ \ %f                                " Path relative to current buffer
set statusline+=\%{&modified?'\ +':''}
set statusline+=%=                                     " Separation point
set statusline+=\%{&readonly?'\ ':''}
set statusline+=\ %{''!=#&filetype?&filetype:'none'}   " FileType
"set statusline+=\ %{WebDevIconsGetFileTypeSymbol()}
"set statusline+=\\ %2v                                " Virtual column number
set statusline+=\ \ %2v                                " Virtual column number
set statusline+=%5l                                    " Current line
set statusline+=/%L
"set statusline+=\ \ %{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}
set statusline+=\ \ %{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}
"set statusline+=\ %{strftime(\"%H:%M\ \")}
set statusline+=\ %{LinterStatus()}

function! Relative_Path_CWD()
    let l:path = fnamemodify(getcwd(),":t")
    return l:path
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK ' : printf(
    \   '%dW %dE ',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" }}}
" Styling vertical splits {{{
if LINUX()
    set fillchars=vert:│,fold:۰,diff:·
    "set fillchars=vert:┃,diff:⎼,fold:⎼
    "set fillchars=""
endif

" }}}
" Override color au {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link VertSplit LineNr
    "autocmd ColorScheme * hi link deniteMatched Statement
    "autocmd ColorScheme * hi link deniteMatchedChar Type
    " No background
    "autocmd ColorScheme * hi! link StatusLine FoldColumn
    "autocmd ColorScheme * hi! link StatusLineNC LineNr
    " Background
    autocmd ColorScheme * hi! link StatusLine CursorLine

    autocmd ColorScheme * hi! link TabLineFill FoldColumn
    "autocmd ColorScheme * hi! link TabLineSel CursorLine
    autocmd ColorScheme * hi! link TabLine LineNr
    autocmd ColorScheme * hi! link FoldColumn LineNr
    autocmd ColorScheme * hi! link CursorLineNr CursorLine
    autocmd ColorScheme * hi! link ALEErrorSign ErrorMsg
    autocmd ColorScheme * hi! link ALEWarningSign WarningMsg
    autocmd ColorScheme * hi! link Folded LineNr
    "autocmd ColorScheme * hi FoldColumn    guibg=NONE guifg=bg ctermbg=none ctermfg=bg
    autocmd ColorScheme * hi LineNr        guibg=NONE ctermbg=none
    autocmd ColorScheme * hi SignColumn        guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterAdd guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterChange guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterDelete guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterChangeDelete guibg=NONE ctermbg=none
    "autocmd ColorScheme * hi ALEErrorSign guibg=NONE ctermbg=none
    "autocmd ColorScheme * hi ALEWarningSign guibg=NONE ctermbg=none
augroup END

"exec 'hi SyntasticErrorSign guifg=red ctermfg=red' .
            "\' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
            "\' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')

" }}}
" Colorscheme {{{
let g:alduin_Shout_Fire_Breath = 1
"colorscheme base16-solarized-dark
"colorscheme gotham
colorscheme onedark
"let g:airline_theme = 'base16_solarized'

" }}}

" }}}
" Mappings {{{

" During insert, kj escapes, `^ is so that the cursor doesn't move
inoremap kj <Esc>`^
inoremap jk <Esc>`^

" Escape from command line using jk and kj
"cmap jk <C-c>
"cmap kj <C-c>

let g:mapleader = ','

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Space to fold
nnoremap <space> za

" Quick edit vimrc
nnoremap <leader>ev :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

nnoremap <F1> <nop>
nnoremap Q <nop>

" Bind nohl
" Removes highlight of your last search
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>

" Resizing windows
nnoremap <C-up> <C-W>-
nnoremap <C-down> <C-W>+
nnoremap <C-right> 5<C-W><
nnoremap <C-left> 5<C-W>>

" Substitute
nnoremap <leader>s :%s//<left>
vnoremap <leader>s :%s//<left>

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

" Easier horizontal scrolling
map zl zL
map zh zH

" fullscreen mode for GVIM and Terminal, need 'wmctrl' in you PATH
"map <silent> <F11> :call ToggleFullScreen()<CR>

"<leader>q to close buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle between absolute and relative line numbers
nnoremap <Leader>n :call NumberToggle()<cr>

" Toggle between invisible chars
nmap <leader>l :set list!<CR>

" Ag
"nnoremap <leader>a :Ag

" Move between splits
"nnoremap <C-H> <C-W><C-H>
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>

" Term move between splits
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
"tnoremap <C-w> <C-\><C-n><C-w>c

" Esc alternative
"inoremap kj <Esc>
"tnoremap kj <Esc>

"set working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Save as sudo
"cmap w!! w !gksudo tee > /dev/null %

"Focus term
"nnoremap <leader>te :buf term<CR>
"Rename buffer
nnoremap <leader>bn :keepalt file<space>
" }}}
" Functions {{{

" Highlight word under cursor {{{

"set updatetime=10

"function! HighlightWordUnderCursor()
    "if getline(".")[col(".")-1] !~# '[[:punct:][:blank:]]' 
        "exec 'match' 'Visual' '/\V\<'.expand('<cword>').'\>/' 
    "else 
        "match none 
    "endif
"endfunction

"autocmd! CursorHold,CursorHoldI * call HighlightWordUnderCursor()

" }}}
" Set airline and colorscheme color {{{

function! Base16(scheme)
    execute 'colorscheme base16-' . a:scheme
    let g:airline_theme = 'base16_' . a:scheme
endfunction

" }}}
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
" Toggle fullscreen {{{

function! ToggleFullScreen()
  if g:GuiWindowFullScreen
    let l:state = 0
  else
    let l:state = 1
  endif
  call GuiWindowFullScreen(l:state)
endfunction

" }}}
" Toggle colorcolumn {{{

function! ToggleColorColumn()
  if &colorcolumn != ''
    set colorcolumn&
  else
    "let &colorcolumn='80,'.join(range(120,999),',')
    let &colorcolumn=80
  endif
endfunction

"nnoremap <silent> <leader>co :call ToggleColorColumn()<CR>

" }}}
" Initialize NERDTree as needed {{{

function! NERDTreeInitAsNeeded()
    redir => l:bufoutput
    buffers!
    redir END
    let l:idx = stridx(l:bufoutput, 'NERD_tree')
    if l:idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" }}}
" Move cursor to last position on file {{{

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
augroup FirstLineCommit
    autocmd!
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session

function! ResCur()
    if line("'\"") <= line('$')
        silent! normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" }}}

" }}}

" Plugins settings {{{

" NERDTree {{{

let g:NERDTreeMinimalUI = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCascadeSingleChildDir = 0
nnoremap <silent> <leader>e :NERDTreeFind<cr>
map <C-e> :NERDTreeToggle<CR>
let g:NERDTreeWinPos="right"
let g:NERDTreeQuitOnOpen=0

" }}}
" YouCcompleteMe {{{

" Cerrar la ventana de previsualizacion despues del completado semantico
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_use_ultisnips_completer = 1

" }}}
" Deoplete {{{

"" Use deoplete.
"let g:deoplete#enable_at_startup = 1

""" Use smartcase.
"let g:deoplete#enable_smart_case = 1

""" TAB to select.
"inoremap <silent><expr><Tab> pumvisible() ? "\<c-n>"
      "\ : (<SID>is_whitespace() ? "\<Tab>" : deoplete#mappings#manual_complete())
"inoremap <expr><S-Tab>  pumvisible() ? "\<c-p>" : "\<c-h>"

"function! s:is_whitespace()
  "let l:col = col('.') - 1
  "return !l:col || getline('.')[l:col - 1]  =~? '\s'
"endfunction

"call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

" }}}

" UltiSnips {{{

let g:UltiSnipsExpandTrigger='<c-e>'
"let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
inoremap <c-x><c-k> <c-x><c-k>
let g:UltiSnipsSnippetDirectories = ['UltiSnips']

"To load frameworks honza snippets
"UltiSnipsAddFiletypes php-laravel
"UltiSnipsAddFiletypes php-spec
"UltiSnipsAddFiletypes javascript-jasmine
"autocmd FileType js UltiSnipsAddFiletypes javascript-jasmine

" }}}
" Matchtag always {{{

" Custom MatchTag syntax group with a default highlight color
"let g:mta_use_matchparen_group = 0
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'blade' : 1,
    \ 'php' : 1,
    \}

" }}}
" Git gutter {{{

nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterRevertHunk
"nmap <Leader>gc :Gcommit<cr>
""let g:gitgutter_max_signs = 800  " default value 500

"Box Drawings Heavy Vertical U+25e3
"let g:gitgutter_sign_added = '┃'
if LINUX()
    let g:gitgutter_sign_added = '┃'
    "let g:gitgutter_sign_added = '╂'
    let g:gitgutter_sign_modified = '┃'
    "let g:gitgutter_sign_modified = '┣'
    let g:gitgutter_sign_removed_first_line = '▔'
    "let g:gitgutter_sign_removed_first_line = '^'
    "let g:gitgutter_sign_removed = '┻'
    let g:gitgutter_sign_removed = '▁'
    let g:gitgutter_sign_modified_removed = '┗'
endif
"http://www.utf8-chartable.de/unicode-utf8-table.pl?start=9472&unicodeinhtml=dec

" }}}
" Preview file on browser {{{

nnoremap <F2>f :!firefox %<CR>
nnoremap <F2>c :!chromium-browser %<CR>
nnoremap <F2>g :!google-chrome %<CR>

" }}}
" Vimtest {{{

"nmap <silent><Leader>tf <Esc>:Pytest file<CR>
"nmap <silent><Leader>tc <Esc>:Pytest class<CR>
"nmap <sdilent><Leader>tm <Esc>:Pytest method<CR>

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let g:test#strategy = 'neoterm'

function! DockerTransform(cmd) abort
  return 'docker exec -it --user=laradock laradock_workspace_1 '.a:cmd
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'

" }}}
" Undotree {{{

nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" }}}
" NeatFoldText {{{

let g:NeatFoldTextFancy = 1
let g:NeatFoldTextShowLineCount = 0

" }}}
" Zim {{{

nnoremap <leader>az :GrepperAg  ~/Documentos/Apuntes/<C-Left><Left>

" }}}
" Devicons {{{

let g:WebDevIconsUnicodeDecorateFolderNodes = 0
let g:DevIconsEnableFoldersOpenClose = 0
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:webdevicons_enable_airline_statusline = 0


" }}}
" AnyFold {{{

"let g:anyfold_activate=1
let g:anyfold_fold_display=0
let g:anyfold_fold_comments=1

augroup FileTypeFolds
    autocmd!
    autocmd Filetype python let b:anyfold_activate=1
    autocmd Filetype javascript let b:anyfold_activate=1
    autocmd Filetype php let b:anyfold_activate=1
    autocmd Filetype bash let b:anyfold_activate=1
    autocmd Filetype java let b:anyfold_activate=1
    autocmd Filetype cs let b:anyfold_activate=1
    autocmd Filetype html let b:anyfold_activate=1
    autocmd Filetype html,blade setlocal foldcolumn=0
    autocmd TermOpen * setlocal foldcolumn=0
augroup END

" }}}
" CtrlP {{{

nnoremap <leader>z :CtrlP ~/Documentos/Apuntes/<cr>
nnoremap <leader>f :CtrlPLine<cr>
nnoremap <leader>r :CtrlPYankring<cr>
nnoremap <leader>j :CtrlPBuffer<cr>
nnoremap <leader>m :CtrlPMRUFiles<cr>
nnoremap <leader>D :CtrlP
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_use_caching = 0

"" Set delay to prevent extra search
"let g:ctrlp_lazy_update = 1

"" Do not clear filenames cache, to improve CtrlP startup
"" You can manualy clear it by <F5>
""let g:ctrlp_clear_cache_on_exit = 0

"" Set no file limit, we are building a big project
"let g:ctrlp_max_files = 0

"" If ag is available use it as filename list generator instead of 'find'
"if executable("ag")
   ""set grepprg=ag\ --nogroup\ --nocolor
   "let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
"endif

" }}}
" Denite {{{

" Change mappings.
"nnoremap <C-P> :Denite buffer file_rec<CR>
"nnoremap <leader>D :Denite 
"nnoremap <leader>m :Denite file_mru<cr>
"nnoremap <leader>f :Denite line<cr>
"nnoremap <leader>o :Denite outline<cr>
"nnoremap <leader>r :Denite register<cr>
""nnoremap <leader>az :Denite grep -path=~/Documentos/Apuntes/<cr>
"nnoremap <leader>z :Denite file_rec -path=~/Documentos/Apuntes/<cr>

"call denite#custom#alias('source', 'file_rec/git', 'file_rec')
"call denite#custom#var('file_rec/git', 'command',
"\ ['git', 'ls-files', '-co', '--exclude-standard'])
"nnoremap <silent> <C-p> :<C-u>Denite buffer
"\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

"if executable('ag')
   "call denite#custom#var('file_rec', 'command',
   "\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
   "" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
   "let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
   "" ag is fast enough that CtrlP doesn't need to cache
   "let g:ctrlp_use_caching = 0
"endif

"" Change mappings
"call denite#custom#map(
     "\ 'insert',
     "\ '<C-j>',
     "\ '<denite:move_to_next_line>',
     "\ 'noremap'
     "\)
"call denite#custom#map(
     "\ 'insert',
     "\ '<C-k>',
     "\ '<denite:move_to_previous_line>',
     "\ 'noremap'
     "\)

"call denite#custom#option('default', 'prompt', '❯')
""call denite#custom#option('default', 'auto_resize', 1)

" }}}
" Neoterm {{{
let g:neoterm_position = 'horizontal'
let g:neoterm_size = 5
"let g:neoterm_position = 'vertical'
"let g:neoterm_size = 80
let g:neoterm_automap_keys = ',tt'
let g:neoterm_autoscroll = 1
" hide/close terminal
nnoremap <silent> ,tj :Ttoggle<cr>
" clear terminal
nnoremap <silent> ,tc :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tk :call neoterm#kill()<cr>

" }}}
" Grepper {{{

nnoremap <Leader>a :Grepper<cr>

" gsW, gsi', motions
nmap as  <plug>(GrepperOperator)
xmap as  <plug>(GrepperOperator)

"Start searching the word under the cursor:
nnoremap <leader>x :Grepper -tool ag -cword -noprompt<cr>

" }}}
" Workspace {{{

let g:workspace_use_devicons = 1
let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"

" }}}
" Airline {{{

let g:replace_separators = 0
let g:airline_powerline_fonts = 1
let g:tmuxline_preset = 'full'
let g:airline_skip_empty_sections = 1
"let g:airline#extensions#branch#empty_message = '*'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#tabline#enabled = 1            " Activar tabline
"let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
let g:airline#extensions#tabline#show_buffers = 1
"let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tmuxline#snapshot_file = "~/.config/snapshot_tmuxline"
"let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'

"Remove percentage
""let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3v'
"let g:airline_section_c = airline#section#create(['%<%F'])
let g:airline_section_z = '%#__accent_bold#%4l%#__restore__#/%L%/:%3v'

""Add clock
function! AirlineInit()
  "let g:airline_section_y = airline#section#create(['ffenc', ' %{strftime("%H:%M")}'])
  "let g:airline_section_y = airline#section#create([' %{Relative_Path_CWD()}', '   %{strftime("%H:%M")}'])
  "let g:airline_section_y = airline#section#create([' %{fnamemodify(getcwd(),":t")}', '   %{strftime("%H:%M")}'])
  let g:airline_section_y = airline#section#create(['%{fnamemodify(getcwd(),":t")}'])
endfunction

augroup AirlineClock
    autocmd!
    autocmd VimEnter * call AirlineInit()
augroup END


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

let g:airline#extensions#tabline#buffers_label = 'B'
let g:airline#extensions#tabline#tabs_label = 'T'

"let g:airline#extensions#default#section_truncate_width = {
      "\ 'b': 79,
      "\ 'x': 60,
      "\ 'y': 20,
      "\ 'z': 45,
      "\ 'warning': 80,
      "\ 'error': 80,
      "\ }

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
" Unthemed vert split char in airline {{{

"augroup ThemedChar
    "autocmd!
    "au User AirlineAfterInit,AirlineAfterTheme call FixSplitColours()
"augroup END

"fun! FixSplitColours()
    "let l:theme = get(g:, 'airline_theme', g:colors_name)
    ""let l:focusedColour = g:airline#themes#{l:theme}#palette['inactive']['airline_c'][1]
    "let l:focusedColour = g:airline#themes#{l:theme}#palette['inactive']['airline_a'][1]
    "let l:inactiveColour = g:airline#themes#{l:theme}#palette['inactive']['airline_a'][1]
    "exec 'hi StatusLine guibg=' . l:focusedColour
    "exec 'hi StatusLineNC guibg=' . l:inactiveColour
"endfun

" }}}
" NerdFonts {{{
" It's a matter of going to the Font Awesome page, clicking on the icon and getting the Unicode code, then in Vim (in insert mode):
" Ctrl+V u <FA unicode number >
" testing extra-powerline-symbols

" set font:
" for now must grab this specific one:
" https://github.com/ryanoasis/powerline-extra-symbols/blob/master/patched-fonts/DroidSansMonoForPowerlinePlusNerdFileTypesMono.otf
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ 12

" testing rounded separators (extra-powerline-symbols):

" Rounded
"let g:airline_left_sep = "\uE0B4"
"let g:airline_left_alt_sep = "\uE0B5"
"let g:airline_right_sep = "\uE0B6"
"let g:airline_right_alt_sep = "\uE0B7"

"Edge down
"let g:airline_left_sep = "\uE0B8"
"let g:airline_left_alt_sep = "\uE0B9"
"let g:airline_right_sep = "\uE0BA"
"let g:airline_right_alt_sep = "\uE0BB"

"let g:tmuxline_separators = {
    "\ 'left' : '',
    "\ 'left_alt': '',
    "\ 'right' : '',
    "\ 'right_alt' : '',
    "\ 'space' : ' '}
"Edge up
"let g:airline_left_sep = "\uE0BC"
"let g:airline_left_alt_sep = "\uE0BD"
"let g:airline_right_sep = "\uE0BE"
"let g:airline_right_alt_sep = "\uE0BF"

"Flames
"let g:airline_left_sep = "\uE0C0"
"let g:airline_left_alt_sep = "\uE0C1"
"let g:airline_right_sep = "\uE0C2"
"let g:airline_right_alt_sep = "\uE0C3"

"Matrix
"let g:airline_left_sep = "\uE0C4"
"let g:airline_left_alt_sep = "\uE0C6"
"let g:airline_right_sep = "\uE0C5"
"let g:airline_right_alt_sep = "\uE0C7"

" set the CN (column number) symbol:
"let g:airline_section_z = airline#section#create(["\uE0A1" . '%{line(".")}' . " \uE0A3" . '%{col(".")}'])

"Improves the contrast for the inactive statusline. To enable it: >
"let g:airline_base16_improved_contrast = 1

"Uses a predefined colorpalette for defining the colors, instead of guessing
"the values from other highlight groups. To enable it: >
"let g:airline#themes#base16#constant = 1

" }}}
" Startify {{{

set sessionoptions-=help,blank

let g:startify_custom_header = [
             \ '                       █▀▀▄ █▀▀ █▀▀█ ▀█░█▀ ░▀░ █▀▄▀█',
             \ '                       █░░█ █▀▀ █░░█ ░█▄█░ ▀█▀ █░▀░█',
             \ '                       ▀░░▀ ▀▀▀ ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░░░▀',
             \ ]

augroup StartifyAu
    autocmd!
    autocmd User Startified setlocal cursorline
augroup END

"let g:startify_change_to_dir = 0
"let g:startify_session_persistence = 1
let g:startify_session_autoload = 1

function! KillNeoterm()
    "bufdo if bufname("%")=~"term://*" | bd! | endif
    bufdo if bufname("%")=~"neoterm-1$" | bd! | endif
endfunction

"bufdo if bufname("%")=~?'.exe$' | bdel | endif
"bufdo if bufname("%")=~'' | bd! | endif

nnoremap <leader>kn :call KillNeoterm()<cr>
nnoremap <leader>S :SSave<cr>


let g:startify_session_before_save = [
        \ 'echo "Cleaning up before saving.."',
        \ 'silent! NERDTreeClose'
        \ ]

let g:startify_session_remove_lines = ['neoterm']

" }}}
" Tagbar {{{

"nmap <leader>tb :TagbarToggle<CR>

" }}}
" Magit {{{

"let g:magit_show_help=0

" }}}
" ale {{{

"nmap <silent> <C-s>k <Plug>(ale_previous_wrap)
"nmap <silent> <C-s>j <Plug>(ale_next_wrap)

" }}}
" phpcd {{{

"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['phpcd', 'omni']

" }}}
" nvim-completion-manager {{{

"let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
"" language specific completions on markdown file
"let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')

"" utils, optional
"let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
"let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
inoremap <silent> <c-e> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}
let g:cm_refresh_default_min_word_len = 2

" }}}
" vim-gtfo {{{

"let g:gtfo#terminals = { 'unix': 'tilix' }

" }}}
" Set gnome-terminal color with dconf-cli, linux mint 18.1 {{{
" Based on https://antonioshadji.github.io/switch-terminal-colors-at-night/
" To make it work, create new terminal profile, set it as default, enable custom background and transparency
" Install https://github.com/miyakogi/seiya.vim

let g:profile_id = system('dconf read /org/gnome/terminal/legacy/profiles:/default')
" Remove new line and quotes from dconf key
let g:profile_id = substitute(g:profile_id, "\n", "", "g") 
let g:profile_id = substitute(g:profile_id, "'", "", "g")
let g:trans_level = system('dconf read /org/gnome/terminal/legacy/profiles:/:' . g:profile_id . '/background-transparency-percent')
let previous_exists = 0

function! GetNvimBackgroundColor()
    let l:nvim_background = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    return l:nvim_background
endfunction

function! GetNvimForegroundColor()
    let l:nvim_foreground = synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui')
    return l:nvim_foreground
endfunction

function! SetTermBackground()
    silent! SeiyaDisable
    let l:background = GetNvimBackgroundColor()
    let l:foreground = GetNvimForegroundColor()
    silent exec system('dconf write /org/gnome/terminal/legacy/profiles:/:' . g:profile_id . '/background-color ' . "'".'"' . l:background . '"'."'")
    silent exec system('dconf write /org/gnome/terminal/legacy/profiles:/:' . g:profile_id . '/foreground-color ' . "'".'"' . l:foreground . '"'."'")
    silent! SeiyaEnable
endfunction

function! TermTransparency(order)
    if g:previous_exists == 1
        let g:trans_level = g:previous_level
        let g:previous_exists = 0
    elseif a:order == 0
        let g:previous_level = g:trans_level
        let g:previous_exists = 1
        let g:trans_level = 0
    elseif g:trans_level <= 40 && a:order == 2
        let g:trans_level += 5
    elseif g:trans_level >= 5 && a:order == 1
        let g:trans_level -= 5
    endif
    silent exec system('dconf write /org/gnome/terminal/legacy/profiles:/:' . g:profile_id . '/background-transparency-percent ' . g:trans_level)
    echom g:trans_level
endfunction

"Reset to opaque
nnoremap <leader><Space> :call TermTransparency(0)<cr>
"Decrease transparency
nnoremap <leader>1 :call TermTransparency(1)<cr>
"Increase transparency
nnoremap <leader>2 :call TermTransparency(2)<cr>
",co to set colorscheme and terminal background
nnoremap <leader>co :colorscheme  <bar>:call SetTermBackground()<bar>:Tmuxline vim_statusline_3<C-Left><C-Left><C-Left><left>

"augroup TermBackground
    "autocmd!
    "autocmd ColorScheme * call SetTermBackground()
"augroup END

" }}}
" Seiya {{{

"let g:seiya_auto_enable=1
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

" }}}
" {{{

hi! link CurrentWordTwins Visual
let g:vim_current_word#highlight_current_word = 0

" }}}
" LanguageClient {{{

let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
let g:LanguageClient_diagnosticsDisplay = {
    \   1: {
    \       'name': 'Error',
    \       'texthl': 'SyntasticError',
    \       'signText': '>>',
    \       'signTexthl': 'Error',
    \   },
    \   2: {
    \      'name': 'Warning',
    \       'texthl': 'SyntasticWarning',
    \       'signText': '!',
    \       'signTexthl': 'SignWarning',
    \   },
    \   3: {
    \       'name': 'Information',
    \       'texthl': 'LanguageClientInformation',
    \       'signText': 'i',
    \       'signTexthl': 'SignInformation',
    \   },
    \   4: {
    \       'name': 'Hint',
    \       'texthl': 'LanguageClientHint',
    \       'signText': '.',
    \       'signTexthl': 'SignHint',
    \   },
    \}

" }}
" Tmux-complete {{{

"let g:tmuxcomplete#trigger = ''

" }}}
" IndentLine {{{
" You can also use one of ¦, ┆, or │ 
"let g:indentLine_char = '│' 
let g:indentLine_char = '┆'

" }}}
" echodoc {{{

"let g:echodoc#enable_at_startup = 1

"}}}
" completor {{{

"let g:completor_php_omni_trigger = '([$\w]{2,}|use\s*|->[$\w]*|::[$\w]*|implements\s*|extends\s*|class\s+[$\w]+|new\s*)$'

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" }}}
