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
" Plug {{{

" Setup directory {{{

if LINUX()
    call plug#begin('~/.local/share/nvim/plugged')
endif

if WINDOWS()
    call plug#begin('~\AppData\Local\nvim\plugged')
endif

" }}}

" General {{{
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'plytophogy/vim-virtualenv'
" Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'romainl/vim-cool'
" Plug 'justinmk/vim-sneak'
Plug 'yssl/QFEnter'
" Plug 'scrooloose/nerdtree'
" Plug 'Shougo/denite.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-gtfo'
Plug 'mbbill/undotree'
Plug 'nbicalcarata/vim-zim'
Plug 'joanrivera/vim-zimwiki-syntax'
Plug 'wesQ3/vim-windowswap'
Plug 'pseewald/vim-anyfold'
"Plug 'kevinkjt2000/tmuxline.vim'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-grepper'
"Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
" Plug 'Yggdroot/indentLine'
"Plug 'NovaDev94/vim-bufferline'
"Plug 'ShirajG/golden-ratio'
"Plug 'yuttie/comfortable-motion.vim'
Plug 'kshenoy/vim-signature'
Plug 'majutsushi/tagbar'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'chrisbra/Colorizer'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-vinegar'
Plug 'gcmt/taboo.vim'
" Plug 'raghur/fruzzy', {'do': { -> fruzzy#install()}}
" Plug 'davidhalter/jedi-vim'

" Javascript
" Plug 'pangloss/vim-javascript'
" Plug 'othree/javascript-libraries-syntax.vim'

" }}}
" Colorschemes {{{
" Plug 'fenetikm/falcon'
"Plug 'ayu-theme/ayu-vim'
Plug 'atelierbram/Base2Tone-vim' 
Plug 'chriskempson/base16-vim'
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'AlessandroYorba/Alduin'
Plug 'protesilaos/prot16-vim'
" Plug 'AlessandroYorba/Alduin'
" Plug 'protesilaos/prot16-vim'
" Plug 'xolox/vim-colorscheme-switcher'
" Plug 'Taverius/vim-colorscheme-manager'
Plug 'xolox/vim-misc'
Plug 'equalsraf/neovim-gui-shim'
" Plug 'metalelf0/base16-black-metal-scheme'
" Plug 'UncleBill/prism.vim'

" }}}
" Git {{{

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
" Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

" Plug 'Shougo/deoplete.nvim'
" Plug 'lifepillar/vim-mucomplete'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --js-completer
  endif
endfunction

" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern' }
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" }}}
" Syntax highlighting{{{

Plug 'sheerun/vim-polyglot'
Plug 'janko-m/vim-test'
Plug 'StanAngeloff/php.vim'
"Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'

" }}}

" Plug end {{{

call plug#end()

" }}}
" }}}

filetype plugin indent on
syntax enable

" General {{{
"set path+=**
set runtimepath+=~/neovim-qt/src/gui/runtime
if executable('ag')
   set grepprg=ag\ --nogroup\ --nocolor
endif
set number
"set background=dark
set wrap
set linebreak
set title
set visualbell t_vb=            " turn off error beep/flash
set novisualbell                " turn off visual bell
set equalalways
" set noequalalways
set hlsearch                  " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
"set scrolloff=5                 " Minimum lines to keep above and below cursor
set inccommand=split            " live sustitution
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
set nofixendofline
" Performance
set noshowcmd noruler
set lazyredraw
set regexpengine=1
set diffopt+=vertical
set autoread

set autoindent
" set tabstop=8
" set softtabstop=4
" set shiftwidth=4
augroup IndentSettings
    autocmd!
    autocmd Filetype html setlocal ts=2 sw=2
    autocmd Filetype htmldjango setlocal ts=2 sw=2
    autocmd Filetype php setlocal ts=4 sw=4
    autocmd Filetype vue setlocal ts=2 sw=2
    autocmd Filetype blade setlocal ts=2 sw=2
    autocmd Filetype typescript setlocal ts=4 sw=4
    autocmd Filetype scss setlocal ts=4 sw=4
    autocmd Filetype vim setlocal ts=4 sw=4
    autocmd Filetype css setlocal ts=4 sw=4
    autocmd Filetype cucumber setlocal ts=2 sw=2
augroup END
set expandtab
set nojoinspaces                " Prevents inserting two spaces after
set splitright                  " Puts new vsplit windows to the right
set splitbelow                  " Puts new split windows to the bottom
let g:loaded_matchparen = 1
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

" }}}

"set spell spelllang=es
"set spellfile=~/.local/share/nvim/site/spell/es.utf-8.add
"set completeopt-=preview
set t_md=
set completeopt+=menuone
set completeopt+=noselect
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
" set list
set foldenable                                  " Enable folding
set foldmethod=marker
set foldcolumn=0
set foldlevel=99                                " Folds open at start
set conceallevel=2

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
set wildignore+=tags

" }}}
" True color {{{

set termguicolors

" }}}
" Cursor line {{{

set cursorline
"set guicursor=n-v-c:hor20,i-ci-ve:ver25,r-cr:hor20,o:hor50
set guicursor=i-ci-ve:ver25
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175

"let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" }}}
" Styling vertical splits {{{
"https://github.com/vim-airline/vim-airline-themes/issues/48
set fillchars=vert:│,fold:۰,diff:·,stlnc:─
" set fillchars=vert:█,fold:۰,diff:·,stlnc:─
" set fillchars=vert:│,fold:۰,diff:· 
" }}}
" Backup and undo {{{

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
" Functions {{{
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
    let &colorcolumn='80,'.join(range(120,999),',')
    " let &colorcolumn=join(range(120,999), ',')
  endif
endfunction

"call ToggleColorColumn()

"Deactivate per filetype
"autocmd FileType markdown let &colorcolumn=""

nnoremap <leader>co :call ToggleColorColumn()<CR>

" }}}
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

function! Relative_Path_CWD()
    let l:path = fnamemodify(getcwd(),":t")
    return l:path
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" }}}
" Vinegar alternative {{{

" function! s:vinegar()
"   let fname = expand('%:t')
"   edit %
"   normal! gg
"   call search('\<'.fname.'\>')
" endfunction
" nnoremap - :<C-U>call <SID>vinegar()<CR>

" }}}
" Autocmd rules {{{

" Term start in insert mode {{{
" https://vi.stackexchange.com/a/3765/10344

augroup TermInsert
    autocmd!
    " autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
    " autocmd BufEnter term://* startinsert
    autocmd TermOpen * startinsert
augroup END

" }}}
" Quickfix below everything {{{

augroup QfBl
    autocmd!
    autocmd FileType qf wincmd J
augroup END

" }}}
" Diff settings {{{

" augroup DiffSettings
"     autocmd!
"     autocmd FilterWritePre * if &diff | setlocal fdc=0 | endif
" augroup END

" }}}
" Move cursor to last position on file {{{

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
augroup FirstLineCommit
    autocmd!
    autocmd FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" }}}
" Omnicompletion {{{

augroup OmniCompletion
    autocmd!
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript,vue set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    " autocmd FileType htmldjango set omnifunc=htmldjangocomplete#CompleteDjango
    "autocmd FileType php set omnifunc=phpcomplete#CompletePHP
augroup END

" }}}
" Only show cursorline in the current window {{{

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    " autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline
    " autocmd WinLeave * setlocal nocursorcolumn
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

augroup DisableThingsFromWindows
    autocmd!
    autocmd WinEnter * if &previewwindow | setlocal nolist | setlocal colorcolumn= | endif
    autocmd FileType qf,help setlocal nonumber colorcolumn=
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
" PHP with html syntax {{{

" augroup phpLaravel
"     autocmd!
    " autocmd BufRead,BufNewFile *.blade.php UltiSnipsAddFiletypes php.php-laravel.html
    " autocmd BufRead,BufNewFile *.js UltiSnipsAddFiletypes js.html
    " autocmd BufRead,BufNewFile *.vue UltiSnipsAddFiletypes js.html
" augroup END

" }}}
" Sync syntax from start to all buffers {{{

" augroup syncSyntax
"   autocmd!
"   autocmd BufEnter * :syntax sync fromstart
" augroup END

" }}}
" Term settings {{{

augroup termSettings
    autocmd!
    autocmd TermOpen * setlocal foldcolumn=0 signcolumn=no nonumber
augroup END

" }}}
" }}}
" Statusline {{{

set laststatus=2

" Simple {{{

set statusline=
set statusline+=%3* 
" set statusline+=\ %n\  
set statusline+=\ %{Relative_Path_CWD()}\ 
set statusline+=%5* 
set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ \•':''}
set statusline+=\ %f
set statusline+=\ %h%m%r
set statusline+=%<
set statusline+=%=
" set statusline+=%(\ %{LinterStatus()}\ %)
set statusline+=%1* 
set statusline+=\ %{''!=#&filetype?&filetype.'\ •\ ':''}
"set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ •\ ':''}
" set statusline+=%{fugitive#head()!=''?'\ '.fugitive#head().'\ •\ ':''}
 set statusline+=%{LinterStatus()!=''?'\ '.LinterStatus().'\ •\ ':''}
set statusline+=%(%4l\,%3c%)\ 

" }}}
" Separators {{{

let left_sep=''
let right_sep=''

" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
"let g:airline_symbols.readonly = ''
"let g:airline_symbols.linenr = '☰'
"let g:airline_symbols.maxlinenr = ''

" }}}
" Airline style {{{

""https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/

"let g:mode ={
        "\ '__' : '-', 'n'  : 'N',
        "\ 'i'  : 'I', 'R'  : 'R',
        "\ 'v'  : 'V', 'V'  : 'V',
        "\ 'c'  : 'C', '' : 'V',
        "\ 's'  : 'S', 'S'  : 'S',
        "\ '' : 'S', 't'  : 'T',
    "\}

"set statusline=
"set statusline+=%1*
"set statusline+=%(\ %{g:mode[mode()]}\ %)
"set statusline+=%(%{&paste?'P\ ':''}%)
"set statusline+=%2*
"set statusline+=%{left_sep}
"set statusline+=%3*
"set statusline+=%{fugitive#head()!=''?'\ \ \ '.fugitive#head().'\ ':''}
"set statusline+=%4*
"set statusline+=%{left_sep}
"set statusline+=%5*
"set statusline+=\ %<
"set statusline+=%t
"set statusline+=\ 
"set statusline+=%{&modified?'[+]':''}
"set statusline+=%{&readonly?'':''}
"set statusline+=%=
"set statusline+=\ %{''!=#&filetype?&filetype:''}
"set statusline+=%{right_alt_sep}
"set statusline+=\ 
"set statusline+=%4*
"set statusline+=%{right_sep}
"set statusline+=%3*
"set statusline+=%(\ %{LinterStatus()}%)
"set statusline+=\ 
"set statusline+=%2*
"set statusline+=%{right_sep}
"set statusline+=%1*
"set statusline+=%(%<\ %4l\,%3c%)\ 

" }}}
" }}}
" Override color au {{{
augroup OverrideColor
    autocmd!
    " autocmd ColorScheme * hi! link LineNr TabLine
    autocmd ColorScheme * hi! link VertSplit NonText
    " autocmd ColorScheme * hi! link StatusLineNC User6
    autocmd ColorScheme * hi! link StatusLineNC NonText
    autocmd ColorScheme * hi! link StatusLine Folded
    " autocmd ColorScheme * hi! link ALEErrorSign DiffDelete
    " autocmd ColorScheme * hi! link ALEWarning SignCursorLineNr
    autocmd ColorScheme * exec 'hi User1' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    autocmd ColorScheme * exec 'hi User2' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi User3' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    autocmd ColorScheme * exec 'hi User4' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui')
            \' guifg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi User5' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui')
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi User6' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
    " autocmd ColorScheme * hi StatusLineNC gui=none cterm=none ctermbg=none guibg=none
    autocmd ColorScheme * hi Folded     gui=none cterm=none ctermbg=none guibg=none
    " autocmd ColorScheme * hi Cursor     ctermfg=15 ctermbg=15 guifg=#FFFFFF guibg=#FFFFFF
    " autocmd ColorScheme * hi DiffAdd    term=bold ctermfg=0 ctermbg=2 guifg=#2b2b2b guibg=#a5c261
    " autocmd ColorScheme * hi DiffDelete term=bold ctermfg=0 ctermbg=1 gui=bold guifg=#2b2b2b guibg=#da4939
    " autocmd ColorScheme * hi DiffChange term=bold ctermfg=0 ctermbg=4 guifg=#2b2b2b guibg=#6d9cbe
    " autocmd ColorScheme * hi DiffText   term=reverse cterm=bold ctermfg=0 ctermbg=4 gui=bold guifg=#2b2b2b guibg=#6d9cbe


    " if exists('g:GtkGuiLoaded')
    "    autocmd ColorScheme * hi Statement  gui=none
    "    autocmd ColorScheme * hi Type  gui=none
    "    autocmd ColorScheme * hi NonText  gui=none
    "    autocmd ColorScheme * hi DiffDelete  gui=none
    "    autocmd ColorScheme * hi DiffText  gui=none
    "    autocmd ColorScheme * hi Bold gui=none
    " endif

    " autocmd ColorScheme * hi LineNr                 guibg=none ctermbg=none
    " autocmd ColorScheme * hi SignColumn             guibg=none ctermbg=none
    " autocmd ColorScheme * hi GitGutterAdd           guibg=none ctermbg=none
    " autocmd ColorScheme * hi GitGutterChange        guibg=none ctermbg=none
    " autocmd ColorScheme * hi GitGutterDelete        guibg=none ctermbg=none
    " autocmd ColorScheme * hi GitGutterChangeDelete  guibg=none ctermbg=none
    " autocmd ColorScheme * hi ALEErrorSign           guifg=red guibg=none ctermbg=none
    " autocmd ColorScheme * hi ALEWarningSign         guifg=yellow guibg=none ctermbg=none
augroup END

let g:gonvim_draw_split = 0

" }}}
" Colorscheme {{{

let g:jellybeans_overrides = {
\    'CursorLine': { 'guibg': '232323' },
\}

let g:alduin_Shout_Fire_Breath = 1
if LINUX()
  colorscheme base16-default-dark
  " colorscheme base16-ia-dark
  " colorscheme base16-atlas
  " colorscheme base16-material-palenight
  " colorscheme Base2Tone_DrawbridgeDark
endif

" }}}
" Mappings {{{

let g:mapleader = ','

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" Insert source bin/activate
tnoremap <leader>va source venv/bin/activate<cr>

" Jump to tag
nnoremap <leader>T <C-]>

" To edit on tab :-tabedit %

" edit file in current directory
"nnoremap <leader>e :e %

" create directory
"nnoremap <leader>m :!mkdir %

" Jump to previous edited buffer
nnoremap <BS> <C-^>

" Substitution on visual selection
xnoremap <leader>vs y:%s/<C-r>"//g<Left><Left>

" Find files
"nnoremap <leader>f :find *

" Find buffer
"nnoremap <leader>b :buffer *
nnoremap <leader>B :ls<CR>:b<Space>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Space to fold
"nnoremap <space> za

" Quick edit vimrc
nnoremap <leader>ev :e ~/dotfiles/nvimrc<cr>
nnoremap <leader>en :e ~/dotfiles/nvim/nplug.vim<cr>
nnoremap <leader>eg :e ~/dotfiles/nvim/general.vim<cr>
nnoremap <leader>ea :e ~/dotfiles/nvim/autocmd.vim<cr>
nnoremap <leader>es :e ~/dotfiles/nvim/statusline.vim<cr>
nnoremap <leader>ec :e ~/dotfiles/nvim/color.vim<cr>
nnoremap <leader>em :e ~/dotfiles/nvim/map.vim<cr>
nnoremap <leader>ep :e ~/dotfiles/nvim/plugins.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>sg :source ~/.config/nvim/ginit.vim<cr>

if WINDOWS()
  nnoremap <leader>ev :e ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>en :e ~\AppData\Local\nvim\nplug.vim<cr>
  nnoremap <leader>eg :e ~\AppData\Local\nvim\general.vim<cr>
  nnoremap <leader>ea :e ~\AppData\Local\nvim\autocmd.vim<cr>
  nnoremap <leader>es :e ~\AppData\Local\nvim\statusline.vim<cr>
  nnoremap <leader>ec :e ~\AppData\Local\nvim\color.vim<cr>
  nnoremap <leader>em :e ~\AppData\Local\nvim\map.vim<cr>
  nnoremap <leader>ep :e ~\AppData\Local\nvim\plugins.vim<cr>
  nnoremap <leader>sv :source ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sg :source ~\AppData\Local\nvim\ginit.vim<cr>
endif

nnoremap <F1> <nop>
nnoremap Q <nop>

" Bind nohl
" Removes highlight of your last search
"noremap <C-n> :nohl<CR>
"vnoremap <C-n> :nohl<CR>
"inoremap <C-n> :nohl<CR>

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
nmap <leader>i :set list!<CR>

" Ag
"nnoremap <leader>a :Ag

" Move between splits
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

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
nnoremap <leader>en :keepalt file<space>

" }}}
" Plugins settings

" phpcd {{{

let g:phpcd_autoload_path = '.autoload.php'

" }}}
" YouCompleteMe {{{

let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:EclimPhpValidate = 0

" }}}
" tmuxline {{{

"let g:tmuxline_powerline_separators = 0
"let g:tmuxline_separators = {
"    \ 'left' : '▚',
"    \ 'left_alt': '▖',
"    \ 'right' : '▞',
"    \ 'right_alt' : '▗',
"    \ 'space' : ' '}

" }}}
" vim-cool {{{

let g:CoolTotalMatches = 1

" }}}
" Bufferline {{{

let g:bufferline_echo = 0
let g:bufferline_separator = ' '
let g:bufferline_rotate = 1

" }}}
" NERDTree {{{

let NERDTreeMinimalUI = 1
let NERDTreeRespectWildIgnore = 1 
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
" let NERDTreeStatusline = ''
" nnoremap <silent> <leader>e :NERDTreeFind<cr>
" map <C-e> :NERDTreeToggle<CR>

" }}}
" netrw {{{

let g:netrw_altfile = 1
" Use the NERDtree style
let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 15
" nmap <C-E> :Lexplore<CR>

" }}}
" Denite {{{

" Change mappings.
"nnoremap <C-P> :Denite file_rec<CR>
" nnoremap <leader>d :Denite 
" nnoremap <leader>b :Denite buffer<cr>
" nnoremap <leader>m :Denite file_old<cr>
" nnoremap <leader>l :Denite line<cr>
" nnoremap <leader>r :Denite register<cr>
" nnoremap <leader>zz :Denite grep -path=~/Documentos/Apuntes/<cr>
" nnoremap <leader>z :Denite file_rec -path=~/Documentos/Apuntes/<cr>

" if WINDOWS()
"     nnoremap <leader>z :Denite file_rec -path=~/Documents/Apuntes/<cr>
" endif

" call denite#custom#alias('source', 'file_rec/git', 'file_rec')

" call denite#custom#var('file_rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])
" nnoremap <silent> <leader>f :<C-u>Denite 
"             \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

" Change mappings
" call denite#custom#map(
"             \ 'insert',
"             \ '<C-j>',
"             \ '<denite:move_to_next_line>',
"             \ 'noremap'
"             \)
" call denite#custom#map(
"             \ 'insert',
"             \ '<C-k>',
"             \ '<denite:move_to_previous_line>',
"             \ 'noremap'
"             \)

" call denite#custom#option('default', {
"             \ 'prompt': '❯',
"             \ 'reversed': 1,
"             \ 'auto_resize': 1,
"             \ 'highlight-mode-insert': 'Search'
"             \ })

" "            "\ 'statusline': 0
" "            "\ 'split': 'no'
" call denite#custom#var('buffer', 'date_format', '')

" call denite#custom#option('_', 'highlight_matched_range', 'None')
" call denite#custom#option('_', 'highlight_matched_char', 'Character')

" }}}
" ctrlp {{{

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_map = '<leader>f'
let g:ctrlp_switch_buffer = ''
nnoremap <leader>b :CtrlPBuffer<enter>
nnoremap <leader>l :CtrlPLine<enter>

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

set updatetime=100

nmap <leader>gn <Plug>GitGutterNextHunk
nmap <leader>gp <Plug>GitGutterPrevHunk
nmap <Leader>gs <Plug>GitGutterStageHunk
nmap <Leader>gr <Plug>GitGutterUndoHunk
nmap <Leader>gc :T git checkout 
nmap <Leader>gS :T git push --set-upstream origin 
nmap <Leader>gP :T git push<cr>
nmap <Leader>gd :Gdiff<cr>
nmap <Leader>g+ :T git stash<CR>
nmap <Leader>g- :T git stash pop<CR>
"let g:gitgutter_max_signs = 800  " default value 500

"Box Drawings Heavy Vertical U+25e3
if LINUX()
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '┃'
    let g:gitgutter_sign_removed_first_line = '▔'
    "let g:gitgutter_sign_removed_first_line = '^'
    "let g:gitgutter_sign_removed = '▁'
    "http://www.utf8-chartable.de/unicode-utf8-table.pl?start=9472&unicodeinhtml=dec
endif
if WINDOWS()
    let g:gitgutter_sign_added = '┃'
    let g:gitgutter_sign_modified = '┃'
    "let g:gitgutter_sign_modified = '▶'
    "let g:gitgutter_sign_modified = '●'
    let g:gitgutter_sign_removed_first_line = '▔'
    "let g:gitgutter_sign_removed = '▁'
endif

" }}}
" Vimtest {{{

nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <sdilent><Leader>tm <Esc>:Pytest method<CR>

nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

let g:test#strategy = 'neovim'

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
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

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
" AnyFold {{{

"let g:anyfold_activate=1
let g:anyfold_fold_display=0
let g:anyfold_fold_comments=1

augroup FileTypeFolds
    autocmd!
    autocmd Filetype python AnyFoldActivate
    " autocmd Filetype javascript let b:anyfold_activate=0
    " autocmd Filetype jsx let b:anyfold_activate=0
    autocmd Filetype php AnyFoldActivate
    autocmd Filetype bash AnyFoldActivate
    autocmd Filetype java AnyFoldActivate
    autocmd Filetype cs AnyFoldActivate
    autocmd Filetype html AnyFoldActivate
    autocmd Filetype vue AnyFoldActivate
    autocmd Filetype html,blade,vue,help setlocal foldcolumn=0
augroup END

" }}}
" CtrlSF {{{

nnoremap <Leader>F :CtrlSF 

" }}}
" Grepper {{{

nnoremap <Leader>a :GrepperAg 

" gsW, gsi', motions
" nmap as  <plug>(GrepperOperator)
" xmap as  <plug>(GrepperOperator)

"Start searching the word under the cursor:
nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>
" }}}
" Startify {{{

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': [   '   Sessions']       },
      \ { 'type': 'files',     'header': [   '   MRU']            },
      \ { 'type': 'dir',       'header': [   '   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': [   '   Bookmarks']      },
      \ { 'type': 'commands',  'header': [   '   Commands']       },
      \ ]

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

" }}}
" ale {{{

nmap <leader>e <Plug>(ale_next_wrap)
nmap <leader>E <Plug>(ale_previous_wrap)

let g:ale_enabled = 1
let g:ale_set_signs = 0
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}
let g:ale_set_loclist = 0
" let g:ale_change_sign_column_color = 1
let g:ale_python_pylint_options = '--load-plugins pylint_django'
" let g:ale_python_pylint_use_global = 1
" let g:ale_python_pylint_executable = '/home/adrian/Workspace/scaapp/bin/pylint'
let g:ale_python_mypy_options = '--ignore-missing-imports'

let g:ale_javascript_eslint_use_global = 1
"let g:ale_open_list = 1
" let g:ale_linters = {
"             \ 'javascript': ['eslint'],
"             \ 'typescript': ['tslint'],
"             \ 'vue': ['eslint']
"             \}

" }}}
" vim-vue {{{

let g:vue_disable_pre_processors = 1

" }}}
" vim-gtfo {{{

"let g:gtfo#terminals = { 'unix': 'tilix' }

" }}}
" gutentags {{{

let g:gutentags_cache_dir = '~/.cache/gutentags'
"let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", ".git", "node_modules", "db", "log"]

" }}}
" mucomplete {{{

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#no_popup_mappings = 1
" let g:AutoPairsMapCR = 0
" imap <Plug>MyCR <Plug>(MUcompleteCR)<Plug>AutoPairsReturn
" imap <cr> <Plug>MyCR
let g:mucomplete#chains = {
        \ 'default' : ['path', 'keyn', 'ulti', 'omni'],
        \ 'vim'     : ['path', 'cmd', 'keyn']
        \ }

" }}}
" Python with virtualenv support {{{
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
" }}}
" Deoplete {{{

if WINDOWS()
    let g:python3_host_prog = 'C:\Python36\python'
endif
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
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
" nvim-completion-manager and deoplete {{{

" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}
" coc {{{
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-python', 'coc-highlight', 'coc-emmet' ] 

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" }}}
" sneak {{{

" let g:sneak#label = 1

" map f <Plug>Sneak_s
" map F <Plug>Sneak_S

" }}}
" color-switcher {{{

let g:colorscheme_switcher_keep_background = 1
let g:colorscheme_switcher_exclude_builtins = 1
let g:colorscheme_manager_global_last = 1
" let g:colorscheme_switcher_exclude = ['base16-atelier-cave-light', 'base16-atelier-dune-light', 'base16-atelier-estuary-light', 'base16-atelier-forest-light', 'base16-atelier-heath-light', 'base16-atelier-lakeside-light', 'base16-atelier-plateau-light', 'base16-atelier-savanna-light', 'base16-atelier-seaside-light', 'base16-atelier-sulphurpool-light', 'base16-classic-light', 'base16-default-light',  'base16-google-light', 'base16-grayscale-light', 'base16-gruvbox-light-hard', 'base16-gruvbox-light-medium', 'base16-gruvbox-light-soft', 'base16-harmonic-light', 'base16-mexico-light', 'base16-one-light', 'base16-solarized-light', 'base16-summerfruit-light', 'base16-unikitty-light', 'base16-material-lighter', 'base16-brushtrees', 'base16-cupcake', 'base16-cupertino', 'base16-brushtrees-dark', 'base16-tomorrow', 'base16-shapeshifter']

let g:alduin_Shout_Fire_Breath = 1

" }}}
" Term {{{

"Execute command from docker container
"To make it work, removed de t option from command

"docker exec -i --user=laradock laradock_workspace_1 sh -c "cd interpos; ./vendor/bin/behat features/order.feature

"docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; npm run dev
nnoremap <leader>A :T docker exec -it --user=laradock laradock_workspace_1 sh -lc ""<left>

" }}}
" fugitive {{{

" nnoremap <leader>G :Gstatus<cr>
nnoremap <Leader>G :belowright :20Gstatus<CR>

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

" }}}
"  Macros {{{
"  Command :reg show macro content, and register
"
"  Prices table csv, public price must be removed first
"  kyypf"di"lf"di"lf"di"0jwvf,hxkf"pj0wxvf,hxkf"f"f"pj0wxvf,hxk$hhhhpjdd
"
" }}}
"  golden-ratio {{{

" let g:loaded_golden_ratio = 0
"let g:golden_ratio_constant = 1.3

"  }}}
"  vim-closetag {{{

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.blade.php'

"  }}}
" emmet {{{

let g:user_emmet_install_global = 0

" augroup EmmetExpansion
"     autocmd!
"     autocmd FileType htmldjango,html,blade,vue EmmetInstall |
"                 \ imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" augroup END

" }}}
" indentline {{{

"let g:indentLine_concealcursor=0
""let g:indentLine_char='│'
"let g:indentLine_char = '┊'
"let g:indentLine_fileTypeExclude = ['text', 'help', 'startify']

" }}}
" Python syntax highlight {{{

let g:python_highlight_all = 1

" }}}
" vim-signature {{{

nnoremap <leader>gm :SignatureListGlobalMarks<cr>
nnoremap <leader>M :SignatureListBufferMarks<cr>

" }}}
" narrow {{{

let g:nrrw_rgn_wdth = 40

" }}}
" Fruzzy {{{

" let g:fruzzy#usenative = 1
" call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

" }}}
" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#tabs_label = 'T'
let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#themes#base16#constant = 1
" let g:airline_base16_improved_contrast = 1

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

" function! AirlineInit()
"   call airline#parts#define_raw('time', '%{strftime("%c"}')
"   let g:airline_section_y = airline#sections#create_right(['ffenc', 'time'])
" endfunction

" autocmd VimEnter * call AirlineInit()

" function! GetSessionName()
"   let l:sname = fnamemodify(v:this_session, ':t')
"   return l:sname
" endfunction

" function! AirlineInit()
"   call airline#parts#define_function('session', 'GetSessionName')
"   let g:airline_section_y = airline#section#create(['session'])
" endfunction

function! Render_Only_File(...)
  let builder = a:1
  let context = a:2
  call builder.add_section('file', '%t ')
  " return 0   " the default: draw the rest of the statusline
  " return -1  " do not modify the statusline
  return 1   " modify the statusline with the current contents of the builder
endfunction

call airline#add_inactive_statusline_func('Render_Only_File')

" autocmd VimEnter * call AirlineInit()
" autocmd User AirlineAfterInit call AirlineInit()

" }}}
" Prism {{{

let g:prism_count_tab = 1
let g:prism_dir_changed_pattern = ['window', 'global']

" }}}
" terminal color {{{

" let g:terminal_color_0  = '#000000'
" let g:terminal_color_1  = '#cc0000'
" let g:terminal_color_2  = '#4e9a06'
" let g:terminal_color_3  = '#c4a000'
" let g:terminal_color_4  = '#3465a4'
" let g:terminal_color_5  = '#75507b'
" let g:terminal_color_6  = '#0b939b'
" let g:terminal_color_7  = '#d3d7cf'
" let g:terminal_color_8  = '#555753'
" let g:terminal_color_9  = '#ef2929'
" let g:terminal_color_10 = '#8ae234'
" let g:terminal_color_11 = '#fce94f'
" let g:terminal_color_12 = '#729fcf'
" let g:terminal_color_13 = '#ad7fa8'
" let g:terminal_color_14 = '#00f5e9'
" let g:terminal_color_15 = '#eeeeec'
" let g:terminal_color_background = g:terminal_color_0
" let g:terminal_color_foreground = g:terminal_color_7

" }}}