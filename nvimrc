" Identify plataform {{{

silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win16') || has('win32') || has('win64'))
endfunction

" }}}

" Dein {{{

" Setup directories {{{

let g:dein#cache_directory = $HOME . '/.cache/dein'
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state($HOME . '/.cache/dein')
  call dein#begin($HOME . '/.cache/dein')
  call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

" }}}

  " General {{{
  "call dein#add('equalsraf/neovim-gui-shim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('dhruvasagar/vim-vinegar')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('justinmk/vim-gtfo')
  call dein#add('mbbill/undotree')
  "call dein#add('Harenome/vim-neatfoldtext')
  call dein#add('Shougo/neomru.vim')
  call dein#add('kassio/neoterm')
  call dein#add('Shougo/denite.nvim')
  call dein#add('nbicalcarata/vim-zim')
  call dein#add('joanrivera/vim-zimwiki-syntax')
  call dein#add('wesQ3/vim-windowswap')
  call dein#add('pseewald/vim-anyfold')
  call dein#add('kevinkjt2000/tmuxline.vim')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('mhinz/vim-startify')
  call dein#add('mhinz/vim-grepper')
  call dein#add('mklabs/split-term.vim')
  call dein#add('skywind3000/asyncrun.vim')
  call dein#add('tpope/vim-surround')
  "call dein#add('ShirajG/golden-ratio')
" }}}
  " Colorschemes {{{

  call dein#add('chriskempson/base16-vim')
  call dein#add('AlessandroYorba/Alduin')
  call dein#add('protesilaos/prot16-vim')
  call dein#add('miyakogi/seiya.vim')
  call dein#add('xolox/vim-colorscheme-switcher')
  call dein#add('Taverius/vim-colorscheme-manager')
  call dein#add('xolox/vim-misc')
  call dein#add('equalsraf/neovim-gui-shim')
  call dein#add('metalelf0/base16-black-metal-scheme')

  " }}}
  " Git {{{

  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('cohama/agit.vim')
  " }}}
  " Html {{{

  call dein#add('Valloric/MatchTagAlways')
  call dein#add('chrisgillis/vim-bootstrap3-snippets')
  call dein#add('mattn/emmet-vim')

  " }}}
  " Snippets & AutoComplete {{{
  
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('w0rp/ale')
  call dein#add('SirVer/ultisnips')
  call dein#add('honza/vim-snippets')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('ludovicchabant/vim-gutentags')
  call dein#add('majutsushi/tagbar')
  call dein#add('carlitux/deoplete-ternjs', { 'build': 'npm install -g tern' })
  call dein#add('epilande/vim-es2015-snippets')
  call dein#add('epilande/vim-react-snippets')

  " }}}
  " Syntax highlighting{{{

  call dein#add('sheerun/vim-polyglot')
  call dein#add('janko-m/vim-test')
  call dein#add('StanAngeloff/php.vim')
  "call dein#add('mxw/vim-jsx')
  call dein#add('posva/vim-vue')

  " }}}

" Dein end {{{

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

" }}}

" Install not installed plugins on startup.
"if dein#check_install()
  "call dein#install()
"endif

" }}}

" Basics {{{

"set shell=/bin/sh

"cd ~/Dropbox/Workspace
"set spell spelllang=es
"set spellfile=~/.local/share/nvim/site/spell/es.utf-8.add
set completeopt-=preview
set completeopt+=noinsert
set mouse=a                                     " Automatically enable mouse usage
set mousehide                                   " Hide the mouse cursor while typing
set clipboard=unnamedplus
if WINDOWS()
    set clipboard=unnamed
endif
set shortmess+=cafilmnrxoOtT                     " Abbrev. of messages (avoids 'hit enter')
"set shortmess+=c                     " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Unix / Windows compatibility
set virtualedit=onemore                         " Allow for cursor beyond last character
set nospell                                     " Spell checking off
set hidden                                      " Allow buffer switching without saving
set foldenable                                  " Enable folding
set foldmethod=marker
set foldcolumn=4
set foldlevel=99                                " Folds open at start
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
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END

" }}}
" Only show cursorline in the current window {{{

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    "autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline
    "autocmd WinLeave * setlocal nocursorcolumn
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
" rst rules {{{

augroup RstRules
    autocmd!
    autocmd FileType rst syn spell toplevel
    autocmd FileType rst setlocal spell
augroup END

" }}}
" NerdTreeExit {{{

augroup NerdTreeExit
    autocmd!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" }}}
" PHP with html syntax {{{

augroup phpLaravel
    autocmd!
    autocmd BufRead,BufNewFile *.blade.php UltiSnipsAddFiletypes php.php-laravel.html
    autocmd BufRead,BufNewFile *.js UltiSnipsAddFiletypes js.html
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
augroup END

" }}}
" Sync syntax from start to all buffers {{{

augroup syncSyntax
  autocmd!
  autocmd BufEnter * :syntax sync fromstart
augroup END

" }}}
" Term settings {{{

augroup termSettings
    autocmd!
    autocmd TermOpen * setlocal foldcolumn=0 signcolumn=no nonumber
augroup END

" }}}
" }}}
" Visual settings {{{

" General {{{
set number
"set numberwidth=10
set background=dark
set wrap
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
set inccommand=split            " live sustitution

if LINUX()
    set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
endif

" }}}
" Formatting {{{

filetype plugin indent on
set autoindent
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
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
set guicursor=n-v-c:hor20,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}
" Ruler {{{

"set rulerformat=%40(%{&filetype}\──%{fugitive#head()}\──%{strftime('%H:%M\')}\─┤%{LineNoIndicator()}\├─%03c%%\─%{LinterStatus()}%)
"set rulerformat=%50(\\ %{fugitive#head()}\ %3p%%\ ☰\ \ %04l/%L\ \ :%03c\ %(\\ %{LinterStatus()}\ \%)%)

" }}}
" Statusline {{{
set laststatus=2

"let g:mode ={
        "\ '__' : '-', 'n'  : 'N',
        "\ 'i'  : 'I', 'R'  : 'R',
        "\ 'v'  : 'V', 'V'  : 'V',
        "\ 'c'  : 'C', '' : 'V',
        "\ 's'  : 'S', 'S'  : 'S',
        "\ '' : 'S', 't'  : 'T',
    "\}
    
set statusline=%!ActiveStatus()

function! ActiveStatus()
  let statusline=""
  let statusline.="%1*"
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%'):''}\ %)"
  let statusline.="%2*"
  let statusline.=""
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
  let statusline.="%3*"
  let statusline.=""
  let statusline.="%4*"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="%3*"
  let statusline.="\ "
  let statusline.="%2*"
  let statusline.=""
  let statusline.="%1*"
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="%(%{'help'!=&filetype?'\ \ '.bufnr('%').'\ \ ':'\ '}%)"
  let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':'\ '}"
  let statusline.="\ %<"
  let statusline.="%f"
  let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ \ ':''}"
  let statusline.="%="
  let statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  let statusline.="%(\ %{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  let statusline.="%(\ \ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let statusline.="\ \ "
  let statusline.="\ %2v"
  let statusline.="\ %3p%%\ "
  return statusline
endfunction

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User3 guibg=#222222 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="dark") | hi User4 guibg=#222222 guifg=#d0d0d0 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User1 guibg=#afd700 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User2 guibg=#005f00 guifg=#afd700 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User3 guibg=#707070 guifg=#005f00 | endif
  "autocmd ColorScheme kalisi if(&background=="light") | hi User4 guibg=#707070 guifg=#d0d0d0 | endif
augroup END

"set statusline=
"set statusline+=%(\ %{g:mode[mode()]}%)
"set statusline+=%(%{&paste?'\ p\ ':''}%)
"set statusline+=%(\ \ %{fugitive#head()}%)
"set statusline+=%#keyword#
"set statusline+=%(\ %<%F%)
"set statusline+=%#warningmsg#
"set statusline+=\ %h%m%r%w
"set statusline+=%=
"set statusline+=%#comment#
"set statusline+=%(\ \ %{&filetype}%)
"set statusline+=%(%<\ %4l\,%3c%)
"set statusline+=%#function#
"set statusline+=%(\ \ %{LinterStatus()}%)
"set statusline+=%#comment#
"set statusline+=%(\ \ %{strftime(\"%H:%M\")}%)
"set statusline+=%(\ %{g:asyncrun_status}%)
"set statusline+=\ 

"function! Relative_Path_CWD()
    "let l:path = fnamemodify(getcwd(),":t")
    "return l:path
"endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" }}}
" Styling vertical splits {{{
if LINUX()
    "set fillchars=vert:│,fold:۰,diff:·,stl:─,stlnc:─
    set fillchars=vert:│,fold:۰,diff:·
    "set fillchars=vert:┃,diff:⎼,fold:⎼
    "set fillchars=""
endif

if WINDOWS()
    "set fillchars=vert:│,fold:۰,diff:·,stl:─,stlnc:─
    set fillchars=vert:│,fold:۰,diff:·
endif

" }}}
" Override color au {{{
augroup OverrideColor
    autocmd!
    "autocmd ColorScheme * hi! link VertSplit LineNr
    "autocmd ColorScheme * hi! link StatusLineNC VertSplit
    "autocmd Colorscheme * hi! link EndOfBuffer LineNr
    "autocmd ColorScheme * hi! link TabLineFill FoldColumn
    "autocmd ColorScheme * hi! link TabLine LineNr
    "autocmd ColorScheme * hi! link CursorLineNr CursorLine
    "autocmd ColorScheme * hi! link CursorColumn CursorLine
    "autocmd ColorScheme * hi! link Folded LineNr
    "autocmd ColorScheme * hi! link Comment LineNr
    "autocmd ColorScheme * hi! link StatusLine CursorLine
    "autocmd ColorScheme * hi FoldColumn             guibg=black ctermbg=black
    "autocmd ColorScheme * hi SignColumn             guibg=black ctermbg=black
    "autocmd ColorScheme * hi GitGutterAdd           guibg=black ctermbg=black
    "autocmd ColorScheme * hi GitGutterChange        guibg=black ctermbg=black
    "autocmd ColorScheme * hi GitGutterDelete        guibg=black ctermbg=black
    "autocmd ColorScheme * hi GitGutterChangeDelete  guibg=black ctermbg=black
    "autocmd ColorScheme * hi ALEErrorSign           guibg=black ctermbg=black
    "autocmd ColorScheme * hi ALEWarningSign         guibg=black ctermbg=black
    "autocmd ColorScheme * hi LineNr                 guibg=black ctermbg=black
    autocmd ColorScheme * hi VertSplit                 guibg=none ctermbg=none
    autocmd ColorScheme * hi StatusLine gui=none,bold cterm=none,bold ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi User1 guibg=black guifg=grey
    autocmd ColorScheme * hi User2 guibg=grey guifg=black
    autocmd ColorScheme * hi User3 guibg=none guifg=grey
    autocmd ColorScheme * hi user4 guibg=none guifg=white
    "autocmd ColorScheme * hi StatusLineNC gui=none,bold cterm=none,bold ctermbg=NONE guibg=NONE
augroup END

"exec 'hi SyntasticErrorSign guifg=red ctermfg=red' .
            "\' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
            "\' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')

" }}}
" Colorscheme {{{

"if LINUX()
  ""colorscheme alduin
"endif

" }}}

" }}}
" Mappings {{{

" During insert, kj escapes, `^ is so that the cursor doesn't move
"inoremap kj <Esc>`^
"inoremap jk <Esc>`^

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
nnoremap <leader>sg :source ~/.config/nvim/ginit.vim<cr>

if WINDOWS()
  nnoremap <leader>ev :e ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sv :source ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sg :source ~\AppData\Local\nvim\ginit.vim<cr>
endif

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
nnoremap <leader>s :%s///g<left><left><left>
vnoremap <leader>s :s///g<left><left><left>

" Select current line (no indentation)
nnoremap vv ^vg_

"Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

"Same for 0, home, end, etc
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

" Center cursor on search results
noremap n nzz  
noremap N Nzz

" Fullscreen mode for neovim-qt
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

"set working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>td :tc %:p:h<CR>:pwd<CR>

" Save as sudo
"cmap w!! w !gksudo tee > /dev/null %

"Rename buffer
nnoremap <leader>bn :keepalt file<space>

" }}}
" Functions {{{

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
  if g:GuiWindowFullScreen == 1
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
    "let &colorcolumn=80
    "let &colorcolumn='80,'.join(range(120,999),',')
    let &colorcolumn=join(range(120,999), ',')
  endif
endfunction

call ToggleColorColumn()

"Deactivate per filetype
"autocmd FileType markdown let &colorcolumn=""

"nnoremap <silent> <leader>co :call ToggleColorColumn()<CR>

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
"nnoremap <silent> <leader>e :NERDTreeFind<cr>
"map <silent> <C-e> :NERDTreeToggle<CR>
let g:NERDTreeWinPos='left'
let g:NERDTreeQuitOnOpen=0
"let g:NERDTreeStatusline="⎼%{Relative_Path_CWD()}"

if WINDOWS()
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
endif

" }}}
" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsListSnippets='<c-l>'
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
    \ 'javascript' : 1,
    \ 'vue' : 1,
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
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  let g:gitgutter_sign_removed_first_line = '▔'
  "let g:gitgutter_sign_removed_first_line = '^'
  "let g:gitgutter_sign_removed = '▁'
  "http://www.utf8-chartable.de/unicode-utf8-table.pl?start=9472&unicodeinhtml=dec
endif
if WINDOWS()
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  "let g:gitgutter_sign_modified = '▶'
  "let g:gitgutter_sign_modified = '●'
  let g:gitgutter_sign_removed_first_line = '▔'
  "let g:gitgutter_sign_removed = '▁'
endif

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

let g:test#strategy = 'asyncrun'

function! DockerTransform(cmd) abort
  let l:docker_project = fnamemodify(getcwd(),":t")
  let l:forward_slashes = a:cmd
  let l:forward_slashes = substitute(l:forward_slashes, "\\", "\/", "g")
  "docker exec -it containerName sh -c "cd /var/www && /bin/bash"
  return "docker exec -it --user=laradock laradock_workspace_1 sh -c ".shellescape('cd '.docker_project.'; '.forward_slashes)
endfunction

let g:test#custom_transformations = {'docker': function('DockerTransform')}
let g:test#transformation = 'docker'

"Ejemplo
"vagrant ssh --command "cd /home/vagrant/project; ./vendor/bin/phpunit

"function! VagrantTransform(cmd) abort
  "let l:vagrant_project = fnamemodify(getcwd(),":t")
  "return "cd ~/Homestead && ssh -tt $(vagrant ssh-config | awk 'NR>1 {print \" -o \"$1\"=\"$2}') localhost ".shellescape('cd /home/vagrant/sitios/'.vagrant_project.'; '.a:cmd)
  "return "cd ~/Homestead && ssh -tt vagrant@192.168.10.10 ".shellescape('cd /home/vagrant/sitios/'.vagrant_project.'; '.a:cmd)
"endfunction
"let g:test#custom_transformations = {'vagrant': function('VagrantTransform')}
"let g:test#transformation = 'vagrant'

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

nnoremap <leader>gz :GrepperAg  ~/Documentos/Apuntes/<C-Left><Left>
if WINDOWS()
  nnoremap <leader>gz :GrepperAg  ~\Documentos\Apuntes\<C-Left><Left>
endif

"Zim files keymaps
",wH   Create Zim header on a buffer
",wb   Bold a range
",wi   Italicize a range
",wh   Highlight a range
",ws   Strikw a range
",wh   Header 1 to 5
"<f8>  Change * to *

" }}}
" Devicons {{{

"let g:WebDevIconsUnicodeDecorateFolderNodes = 0
"let g:DevIconsEnableFoldersOpenClose = 0
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" }}}
" AnyFold {{{

"let g:anyfold_activate=1
let g:anyfold_fold_display=0
let g:anyfold_fold_comments=1

augroup FileTypeFolds
    autocmd!
    autocmd Filetype python let b:anyfold_activate=1
    autocmd Filetype javascript let b:anyfold_activate=0
    autocmd Filetype jsx let b:anyfold_activate=0
    autocmd Filetype php let b:anyfold_activate=1
    autocmd Filetype bash let b:anyfold_activate=1
    autocmd Filetype java let b:anyfold_activate=1
    autocmd Filetype cs let b:anyfold_activate=1
    autocmd Filetype html let b:anyfold_activate=1
    autocmd Filetype vue let b:anyfold_activate=1
    autocmd Filetype html,blade,vue,help setlocal foldcolumn=0
augroup END

" }}}
" Denite {{{

" Change mappings.
"nnoremap <C-P> :Denite buffer file_rec<CR>
"nnoremap <leader>j :Denite buffer file_rec<CR>
"nnoremap <C-P> :Denite file_rec<CR>
nnoremap <leader>D :Denite 
nnoremap <leader>m :Denite file_mru<cr>
nnoremap <leader>f :Denite line<cr>
nnoremap <leader>o :Denite outline<cr>
nnoremap <leader>r :Denite register<cr>
nnoremap <leader>zz :Denite grep -path=~/Documentos/Apuntes/<cr>
nnoremap <leader>z :Denite file_rec -path=~/Documentos/Apuntes/<cr>

if WINDOWS()
  nnoremap <leader>z :Denite file_rec -path=~/Documents/Apuntes/<cr>
endif

call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command',
\ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <leader>j :<C-u>Denite buffer
\ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

if executable('ag')
   set grepprg=ag\ --nogroup\ --nocolor
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

call denite#custom#option('default', {
      \ 'prompt': '❯',
      \ 'auto_resize': 1,
      \ 'reversed': 1
      \ })

call denite#custom#var('buffer', 'date_format', '')

" }}}
" Neoterm {{{
let g:neoterm_position = 'vertical'
let g:neoterm_size = 55
let g:neoterm_automap_keys = ',tt'
let g:neoterm_autoscroll = 1
nnoremap <silent> ,tj :Ttoggle<cr>
nnoremap <silent> ,tc :call neoterm#clear()<cr>
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
" Startify {{{

set sessionoptions-=help,blank,folds
"set sessionoptions=blank,curdir,folds,help,tabpages,winpos

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

function! KillTerm()
    bufdo if bufname("%")=~"term://*" | bd! | endif
    "bufdo if bufname("%")=~"neoterm-1$" | bd! | endif
endfunction

"bufdo if bufname("%")=~?'.exe$' | bdel | endif
"bufdo if bufname("%")=~'' | bd! | endif

function! CleanNoNameEmptyBuffers()
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
    if !empty(buffers)
        exe 'bd '.join(buffers, ' ')
    else
        echo 'No buffer deleted'
    endif
endfunction

"nnoremap <silent> ,C :call CleanNoNameEmptyBuffers()<CR>
"nnoremap <leader>kt :call KillTerm()<cr>
nnoremap <leader>S :SSave<cr>


let g:startify_session_before_save = [
        \ 'echo "Cleaning up before saving.."',
        \ 'silent! NERDTreeClose'
        \ ]

let g:startify_session_remove_lines = ['neoterm']

" }}}
" Tagbar {{{

"let g:tagbar_left = 1
let g:tagbar_width = 31
nmap <leader>tb :TagbarToggle<CR>

" }}}
" ale {{{

nmap <silent> <C-s>k <Plug>(ale_previous_wrap)
nmap <silent> <C-s>j <Plug>(ale_next_wrap)

let g:ale_javascript_eslint_use_global = 1
"let g:ale_open_list = 1
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'vue': ['eslint']
      \}

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" }}}
" vim-vue {{{

let g:vue_disable_pre_processors = 1

" }}}
" vim-gtfo {{{

"let g:gtfo#terminals = { 'unix': 'tilix' }

" }}}
" Set gnome-terminal color with dconf-cli, linux mint 18.1 {{{
" Based on https://antonioshadji.github.io/switch-terminal-colors-at-night/
" To make it work enable  transparency in terminal settings.
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
    "silent! SeiyaEnable
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
"nnoremap <leader>co :colorscheme  <bar>:call SetTermBackground()<bar>:Tmuxline vim_statusline_3<C-Left><C-Left><C-Left><left>
nnoremap <leader>co :colorscheme  <bar>:call SetTermBackground()<C-Left><C-Left><left>

" }}}
" Seiya {{{

if LINUX()
  "let g:seiya_auto_enable=1
  let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']
endif

" }}}
" gutentags {{{

let g:gutentags_cache_dir = '~/.cache/gutentags'
"let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", ".git", "node_modules", "db", "log"]

" }}}
" Deoplete {{{

let g:deoplete#enable_at_startup = 1
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources.php = ['omni']
"let g:echodoc_enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.php = '\w*|[^. \t]->\w*|\w*::\w*'
let g:deoplete#sources#ternjs#filetypes = [
                \ 'javascript',
                \ 'vue'
                \ ]
" }}}
" vim-jsx {{{

"let g:jsx_ext_required = 0

" }}}
" nvim-completion-manager and deoplete {{{

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}
" color-switcher {{{

let g:colorscheme_switcher_keep_background = 1
let g:colorscheme_switcher_exclude_builtins = 1
let g:colorscheme_manager_global_last = 1
let g:colorscheme_switcher_exclude = ['base16-atelier-cave-light', 'base16-atelier-dune-light', 'base16-atelier-estuary-light', 'base16-atelier-forest-light', 'base16-atelier-heath-light', 'base16-atelier-lakeside-light', 'base16-atelier-plateau-light', 'base16-atelier-savanna-light', 'base16-atelier-seaside-light', 'base16-atelier-sulphurpool-light', 'base16-classic-light', 'base16-default-light',  'base16-google-light', 'base16-grayscale-light', 'base16-gruvbox-light-hard', 'base16-gruvbox-light-medium', 'base16-gruvbox-light-soft', 'base16-harmonic-light', 'base16-mexico-light', 'base16-one-light', 'base16-solarized-light', 'base16-summerfruit-light', 'base16-unikitty-light', 'base16-material-lighter', 'base16-brushtrees', 'base16-cupcake', 'base16-cupertino', 'base16-brushtrees-dark', 'base16-tomorrow', 'base16-shapeshifter']

let g:alduin_Shout_Fire_Breath = 1

" }}}
" split-term {{{

let g:disable_key_mappings = 1
nnoremap <leader>T :Term<cr>

" }}}
" fugitive {{{

nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>G :Gstatus<cr>

" }}}
"  Macros {{{
"  Command :reg show macro content, and register
"
"  Prices table csv, public price must be removed first
"  kyypf"di"lf"di"lf"di"0jwvf,hxkf"pj0wxvf,hxkf"f"f"pj0wxvf,hxk$hhhhpjdd
"
"  }}}
"  AsyncRun {{{

noremap <leader>ta :call asyncrun#quickfix_toggle(8)<cr>

augroup QuickfixStatus
	au! BufWinEnter quickfix setlocal
		\ statusline=%t\ [%{g:asyncrun_status}]\ %{exists('w:quickfix_title')?\ '\ '.w:quickfix_title\ :\ ''}\ %=%-15(%l,%c%V%)\ %P
augroup END

" Auto toggle the quickfix window
augroup AutoToggleQFWindow
au! User AsyncRunStop
            \ if g:asyncrun_status=='failure' |
            \   execute('call asyncrun#quickfix_toggle(8, 1)') |
            \ else |
            \   execute('call asyncrun#quickfix_toggle(8, 0)') |
            \ endif
augroup END

"if LINUX()
   ""let g:asyncrun_exit = "silent call system('afplay ~/.vim/notify.wav &')"
"endif

"if WINDOWS()
  ""let g:asyncrun_exit = 'silent !start playwav.exe "C:/Windows/Media/Windows Error.wav" 200'
   "let g:asyncrun_exit = 'silent !start '.$HOME.'\dotfiles\notification.exe'
"endif

"Execute command from docker container
"To make it work, removed de t option from command

"docker exec -i --user=laradock laradock_workspace_1 sh -c "cd interpos; ./vendor/bin/behat features/order.feature

"docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; npm run dev
nnoremap <leader>A :AsyncRun docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; "<left>

"  }}}
"  golden-ratio {{{

let g:golden_ratio_constant = 1.3

"  }}}
" }}}
