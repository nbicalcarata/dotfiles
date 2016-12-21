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
    let basedir = 'vimfiles'
endif

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !mkdir -p '~/.config/nvim/autoload'
    silent !curl -fLo '~/.config/nvim/autoload/plug.vim'
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

" }}}

" General {{{

Plug 'equalsraf/neovim-gui-shim'
Plug 'scrooloose/nerdtree'
Plug 'dhruvasagar/vim-vinegar'
Plug 'scrooloose/nerdcommenter'
Plug 'justinmk/vim-gtfo'
Plug 'mbbill/undotree'
Plug 'Harenome/vim-neatfoldtext'
Plug 'Shougo/neomru.vim'
Plug 'kassio/neoterm'
Plug 'Shougo/denite.nvim'
Plug 'metakirby5/codi.vim'
Plug 'mileszs/ack.vim'
Plug 'nbicalcarata/vim-zim'
Plug 'joanrivera/vim-zimwiki-syntax'
"Plug 'coxjc/VimSearch'
Plug 'wesQ3/vim-windowswap'

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
Plug 'AlessandroYorba/Sierra'
Plug 'joshdick/onedark.vim'
Plug 'w0ng/vim-hybrid'
Plug 'ayu-theme/ayu-vim'
Plug 'jacoborus/tender'

" }}}
" Git {{{

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'chemzqm/vim-easygit'

" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'jaxbot/browserlink.vim'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
"Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'neomake/neomake'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

" }}}
" Syntax highlighting{{{
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'sheerun/vim-polyglot'
"Plug 'ryanoasis/vim-devicons'
Plug 'tweekmonster/django-plus.vim'
"Plug 'reedes/vim-pencil'

" }}}

" Plug end {{{

call plug#end()

" }}}

" Basics {{{

if !WINDOWS()
    set shell=/bin/sh
endif
set shell=/usr/bin/zsh

cd ~/Workspace
"set completeopt+=noinsert
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing
set clipboard=unnamedplus
if !WINDOWS()
    set clipboard=unnamed
endif

set shortmess+=afilmnrxoOtT                     " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set nospell                                     " Spell checking off
set hidden                                      " Allow buffer switching without saving
set foldenable                                  " Enable folding
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
    let parent = $HOME
    let prefix = 'nvim'
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
" Wild menu options {{{

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
"No delay between Insert and Normal mode {{{

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
" Detect django files {{{

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
    autocmd BufRead,BufNewFile *.php set filetype=php.laravel.html
    autocmd BufRead,BufNewFile *.blade.php set filetype=blade.html
augroup END

" }}}

" }}}
" Visual settings {{{

" General {{{

set foldmethod=marker
set number
set nowrap
set linebreak
set title
set visualbell t_vb=            " turn off error beep/flash
set novisualbell                " turn off visual bell
set equalalways
"set lazyredraw
"set noshowmode                  " Dont display the current mode
set nohlsearch                  " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set scrolloff=5                 " Minimum lines to keep above and below cursor
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

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
let loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" }}}
" True color {{{

set termguicolors

" }}}
" Cursor line {{{

set cursorline

" }}}
" Statusline {{{
set statusline=
set laststatus=2
set statusline+=\ %(%{'help'!=&filetype?bufnr('%'):''}\ \ %)
set statusline+=%< " Where to truncate line
set statusline+=%{Relative_Path_CWD()}         " Current dir
set statusline+=\ \ %f " Path to the file in the buffer, as typed or relative to current directory
set statusline+=\%{&modified?'\ +':''}
set statusline+=%= " Separation point between left and right aligned items
set statusline+=\%{&readonly?'\ ':''}
set statusline+=\ %{''!=#&filetype?&filetype:'none'}   "FileType
"set statusline+=\ \ %{''.(&fenc!=''?&fenc:&enc).''}  "Encoding
"set statusline+=\%{(&bomb?\",BOM\":\"\")}\            "Encoding2
"set statusline+=\%{&ff}\                              "FileFormat (dos/unix..) 
set statusline+=\ \ %2v " Virtual column number
set statusline+=%5l             "current line
set statusline+=/%L  
"set statusline+=\ \ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline+=\ \ %{'help'!=&filetype?Current_git_branch():''}
set statusline+=\ %{strftime(\"%H:%M\ \")}

function! Current_git_branch()
    let l:branch = split(fugitive#statusline(),'[()]')
    if len(l:branch) > 1
         return remove(l:branch, 1)
    endif
    return ""
endfunction

function! Relative_Path_CWD()
    let l:path = fnamemodify(getcwd(),":~")
    return l:path
endfunction

" }}}
" Styling vertical splits {{{
if LINUX()
    set fillchars=vert:│,diff:⎼,fold:⎼
    "set fillchars=vert:┃,diff:⎼,fold:⎼
    "set fillchars=""
endif

" }}}
" Override color au {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi VertSplit guibg=NONE ctermfg=NONE ctermbg=NONE
    autocmd ColorScheme * hi link deniteMatched Statement
    autocmd ColorScheme * hi link deniteMatchedChar Type
    autocmd ColorScheme * hi! link StatusLine CursorLine
    autocmd ColorScheme * hi! link TabLineFill CursorLine
    autocmd ColorScheme * hi! link TabLineSel CursorLine
    autocmd ColorScheme * hi! link TabLine LineNr
    "autocmd ColorScheme * highlight Folded    guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight Number    guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight LineNr    guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight GitGutterAdd guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight GitGutterChange guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight GitGutterDelete guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight GitGutterChangeDelete guibg=NONE ctermbg=none
augroup END

"exec 'hi SyntasticErrorSign guifg=red ctermfg=red' .
            "\' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
            "\' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')

" }}}
" Colorscheme {{{

colorscheme base16-solarized-dark

" }}}

" }}}
" Mappings {{{

let mapleader = ","

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
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
nnoremap K <nop>

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
map <silent> <F11> :call ToggleFullScreen()<CR>

"<leader>q to close buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle between absolute and relative line numbers
nnoremap <Leader>n :call NumberToggle()<cr>

" Toggle between invisible chars
nmap <leader>l :set list!<CR>

" Ag
"nnoremap <leader>a :Ag 

" Move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Term move between splits
tnoremap <Esc><Esc> <C-\><C-n>
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

" }}}
" Functions {{{

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
    let state = 0
  else
    let state = 1
  endif
  call GuiWindowFullScreen(state)
endfunction

" }}}
" Toggle colorcolumn {{{

function! ToggleColorColumn()
  if &colorcolumn != ''
    set colorcolumn&
  else
    let &colorcolumn="80,".join(range(120,999),",")
  endif
endfunction

nnoremap <silent> <leader>co :call ToggleColorColumn()<CR>

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
" Move cursor to last position on file {{{

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session

function! ResCur()
    if line("'\"") <= line("$")
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

let NERDTreeMinimalUI = 1
let NERDTreeRespectWildIgnore = 1 
let NERDTreeAutoDeleteBuffer = 1
nnoremap <silent> <leader>e :NERDTreeFind<cr>
map <C-e> :NERDTreeToggle<CR>
let NERDTreeWinPos="right"

" }}}
" YCM {{{

" Cerrar la ventana de previsualizacion despues del completado semantico
let g:ycm_autoclose_preview_window_after_completion = 1

" }}}
" Deoplete {{{

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1

"" <C-h>, <BS>: close popup and delete backword char.

"inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"

"" <CR>: close popup and save indent.

"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function() abort
  "return deoplete#mappings#close_popup() . "\<CR>"
"endfunction

" TAB to select.
inoremap <silent><expr><Tab> pumvisible() ? "\<c-n>"
      \ : (<SID>is_whitespace() ? "\<Tab>" : deoplete#mappings#manual_complete())
inoremap <expr><S-Tab>  pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:is_whitespace()
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~? '\s'
endfunction

" }}}

" UltiSnips {{{

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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
nmap <Leader>gc :Gcommit<cr>
"let g:gitgutter_max_signs = 800  " default value 500

"Box Drawings Heavy Vertical U+25e3
if LINUX()
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '┃'
    let g:gitgutter_sign_removed_first_line = '^'
    "let g:gitgutter_sign_removed = '┃'
    "let g:gitgutter_sign_modified_removed = '┃'
endif
" }}}
" Preview file on browser {{{

nnoremap <F2>f :!firefox %<CR>
nnoremap <F2>c :!chromium-browser %<CR>
nnoremap <F2>g :!google-chrome %<CR>

" }}}
" Pytest {{{

nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>

" }}}
" Undotree {{{

nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" }}}
" NeatFoldText {{{

let g:NeatFoldTextFancy = 1

" }}}
" Zim {{{

nnoremap <leader>az :Ack!  ~/Documentos/Apuntes/<C-Left><Left>

" }}}
" Devicons {{{

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" }}}

" Denite {{{

" Change mappings.
nnoremap <leader>r :Denite file_rec<CR>
"nnoremap <leader>m :GFiles<CR>
nnoremap <leader>m :Denite buffer<CR>
nnoremap <leader>h :Denite file_mru<cr>
nnoremap <leader>f :Denite line<cr>
"nnoremap <leader>az :Denite grep -path=~/Documentos/Apuntes/<cr>
nnoremap <leader>z :Denite file_rec -path=~/Documentos/Apuntes/<cr>

if executable("ag")
    call denite#custom#var('file_rec', 'command',
	\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

" Change mappings
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#option('default', 'prompt', '>')
call denite#custom#option("default", "auto_resize", 1)

" }}}
" Neoterm {{{

let g:neoterm_position = 'horizontal'
let g:neoterm_automap_keys = ',tt'
let g:neoterm_size = 15
" hide/close terminal
nnoremap <silent> ,th :Ttoggle<cr>
" clear terminal
nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> ,tc :call neoterm#kill()<cr>

" }}}
" Ack {{{

if executable('ag')
    let g:ackprg = 'ag --vimgrep --smart-case'                                                   
endif

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" }}}

" }}}
