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
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'romainl/vim-cool'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/denite.nvim'
"Plug 'scrooloose/nerdcommenter'
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
Plug 'mklabs/split-term.vim'
"Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
"Plug 'Yggdroot/indentLine'
"Plug 'NovaDev94/vim-bufferline'
"Plug 'ShirajG/golden-ratio'
"Plug 'yuttie/comfortable-motion.vim'
" }}}
" Colorschemes {{{
"Plug 'fenetikm/falcon'
"Plug 'ayu-theme/ayu-vim'
Plug 'chriskempson/base16-vim'
Plug 'AlessandroYorba/Alduin'
Plug 'protesilaos/prot16-vim'
 Plug 'xolox/vim-colorscheme-switcher'
Plug 'Taverius/vim-colorscheme-manager'
Plug 'xolox/vim-misc'
Plug 'equalsraf/neovim-gui-shim'
Plug 'metalelf0/base16-black-metal-scheme'

" }}}
" Git {{{

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

"Plug 'Shougo/deoplete.nvim'
"Plug 'lifepillar/vim-mucomplete'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --js-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern' }

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
"set noequalalways
set hlsearch                  " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
"set scrolloff=5                 " Minimum lines to keep above and below cursor
set inccommand=split            " live sustitution
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•

" Formatting {{{
set autoindent
set tabstop=8
set softtabstop=4
set shiftwidth=4
augroup IndentSettings
    autocmd!
    autocmd Filetype html setlocal ts=2 sw=2
    autocmd Filetype vue setlocal ts=2 sw=2
    autocmd Filetype blade setlocal ts=2 sw=2
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
"set fillchars=vert:│,fold:۰,diff:·,stlnc:─
set fillchars=vert:│,fold:۰,diff:· 
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
" Terminal-toggle https://pastebin.com/FjdkegRH {{{

function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
        " Top split size 10, botright splits on bottom
        " topleft splits on top
            :exe "botright 10split"
        endif
        :exe "buffer " . a:termname
        :startinsert
    else
        " buffer is not loaded, create
        if a:slider
        " Top split size 10, botright splits on bottom
            :exe "botright 10split"
        endif
        :terminal
        :exe "f " a:termname
        :startinsert
        set nobuflisted
    endif
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

"call ToggleColorColumn()

"Deactivate per filetype
"autocmd FileType markdown let &colorcolumn=""

"nnoremap <silent> <leader>co :call ToggleColorColumn()<CR>

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

function! s:vinegar()
  let fname = expand('%:t')
  edit %:h
  normal! gg
  call search('\<'.fname.'\>')
endfunction
nnoremap - :<C-U>call <SID>vinegar()<CR>

" }}}
" Autocmd rules {{{

" Term start in insert mode {{{
" https://vi.stackexchange.com/a/3765/10344

"augroup TermInsert
    "autocmd!
    "autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
"augroup END

" }}}
" Quickfix below everything {{{

augroup QfBl
    autocmd!
    autocmd FileType qf wincmd J
augroup END

" }}}
" Diff settings {{{

augroup DiffSettings
    autocmd!
    autocmd FilterWritePre * if &diff | setlocal fdc=0 | endif
augroup END

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

augroup phpLaravel
    autocmd!
    " autocmd BufRead,BufNewFile *.blade.php UltiSnipsAddFiletypes php.php-laravel.html
    " autocmd BufRead,BufNewFile *.js UltiSnipsAddFiletypes js.html
    " autocmd BufRead,BufNewFile *.vue UltiSnipsAddFiletypes js.html
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
" Statusline {{{

set laststatus=2

" Simple {{{

set statusline=
set statusline+=%3* 
set statusline+=\ %n\  
set statusline+=%5* 
set statusline+=\ %f
set statusline+=\ %h%m%r
set statusline+=%<
set statusline+=%=
set statusline+=%(\ %{LinterStatus()}\ %)
set statusline+=%1* 
set statusline+=\ %{''!=#&filetype?&filetype.'\ •\ ':''}
"set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ •\ ':''}
set statusline+=%{fugitive#head()!=''?'\ '.fugitive#head().'\ •\ ':''}
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
    autocmd ColorScheme * hi! link LineNr TabLine
    autocmd ColorScheme * hi! link ColorColumn CursorLine
    autocmd ColorScheme * hi! link CursorColumn CursorLine
    autocmd ColorScheme * hi! link VertSplit Folded
    autocmd ColorScheme * hi! link StatusLineNC User6
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
    autocmd ColorScheme * hi StatusLine gui=none cterm=none ctermbg=none guibg=none
    autocmd ColorScheme * hi Folded     gui=none cterm=none ctermbg=none guibg=none
    if exists('g:GtkGuiLoaded')
"        autocmd ColorScheme * hi Statement  gui=none
"        autocmd ColorScheme * hi Type  gui=none
    endif
    "autocmd ColorScheme * hi LineNr                 guibg=none ctermbg=none
    "autocmd ColorScheme * hi SignColumn             guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterAdd           guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterChange        guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterDelete        guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterChangeDelete  guibg=none ctermbg=none
    "autocmd ColorScheme * hi ALEErrorSign           guibg=none ctermbg=none
    "autocmd ColorScheme * hi ALEWarningSign         guibg=none ctermbg=none
augroup END

" }}}
" Colorscheme {{{

let g:alduin_Shout_Fire_Breath = 1
"if LINUX()
  ""colorscheme alduin
"endif

" }}}
" Mappings {{{

let g:mapleader = ','

" To edit on tab :-tabedit %
" Toggle 'default' terminal
nnoremap <leader>ta :call ChooseTerm("terminal", 1)<CR>
" Start terminal in current pane
nnoremap <leader>tc :call ChooseTerm("term-pane", 0)<CR>

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
nnoremap <leader>b :ls<CR>:b<Space>

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
nmap <leader>c :set list!<CR>

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
"nnoremap <leader>bn :keepalt file<space>
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
let NERDTreeStatusline = ' '
nnoremap <silent> <leader>e :NERDTreeFind<cr>
map <C-e> :NERDTreeToggle<CR>

" }}}
" Denite {{{

" Change mappings.
"nnoremap <C-P> :Denite file_rec<CR>
nnoremap <leader>d :Denite 
nnoremap <leader>B :Denite buffer<cr>
nnoremap <leader>m :Denite file_old<cr>
nnoremap <leader>l :Denite line<cr>
nnoremap <leader>r :Denite register<cr>
nnoremap <leader>zz :Denite grep -path=~/Documentos/Apuntes/<cr>
nnoremap <leader>z :Denite file_rec -path=~/Documentos/Apuntes/<cr>

if WINDOWS()
    nnoremap <leader>z :Denite file_rec -path=~/Documents/Apuntes/<cr>
endif

call denite#custom#alias('source', 'file_rec/git', 'file_rec')

call denite#custom#var('file_rec/git', 'command',
            \ ['git', 'ls-files', '-co', '--exclude-standard'])
nnoremap <silent> <leader>f :<C-u>Denite
            \ `finddir('.git', ';') != '' ? 'file_rec/git' : 'file_rec'`<CR>

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
            \ 'reversed': 1 ,
            \ 'auto_resize': 1 
            \ })

"            "\ 'statusline': 0
"            "\ 'split': 'no'
call denite#custom#var('buffer', 'date_format', '')

call denite#custom#option('_', 'highlight_matched_range', 'None')
call denite#custom#option('_', 'highlight_matched_char', 'Character')

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
nmap <Leader>gP :Term git push<cr>
nmap <Leader>gd :Gvdiff<cr>
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
" Grepper {{{

nnoremap <Leader>a :Grepper<cr>

" gsW, gsi', motions
nmap as  <plug>(GrepperOperator)
xmap as  <plug>(GrepperOperator)

"Start searching the word under the cursor:
nnoremap <leader>x :Grepper -tool ag -cword -noprompt<cr>

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
" gutentags {{{

let g:gutentags_cache_dir = '~/.cache/gutentags'
"let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", ".git", "node_modules", "db", "log"]

" }}}
" mucomplete {{{

"let g:mucomplete#enable_auto_at_startup = 1
"let g:AutoPairsMapCR = 0
"imap <Plug>MyCR <Plug>(MUcompleteCR)<Plug>AutoPairsReturn
"imap <cr> <Plug>MyCR
"let g:mucomplete#chains = {
        "\ 'default' : ['path', 'keyn', 'ulti', 'omni'],
        "\ 'vim'     : ['path', 'cmd', 'keyn']
        "\ }

" }}}
" Deoplete {{{

if WINDOWS()
    let g:python3_host_prog = 'C:\Python36\python'
endif
"let g:deoplete#enable_at_startup = 1
"call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])
"let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
"let g:deoplete#ignore_sources.php = ['omni']
""let g:echodoc_enable_at_startup = 1
"let g:deoplete#omni#input_patterns = {}
"let g:deoplete#omni#input_patterns.php = '\w*|[^. \t]->\w*|\w*::\w*'
"let g:deoplete#sources#ternjs#filetypes = [
            "\ 'javascript',
            "\ 'vue'
            "\ ]
" }}}
" nvim-completion-manager and deoplete {{{

"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
nnoremap <leader>T :10Term<cr>
"Execute command from docker container
"To make it work, removed de t option from command

"docker exec -i --user=laradock laradock_workspace_1 sh -c "cd interpos; ./vendor/bin/behat features/order.feature

"docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; npm run dev
nnoremap <leader>A :Term docker exec -it --user=laradock laradock_workspace_1 sh -lc ""<left>

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
" }}}
"  golden-ratio {{{

let g:loaded_golden_ratio = 0
"let g:golden_ratio_constant = 1.3

"  }}}
"  vim-closetag {{{

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.blade.php'

"  }}}
" emmet {{{

let g:user_emmet_leader_key = '<C-y>'

" }}}
" indentline {{{

"let g:indentLine_concealcursor=0
""let g:indentLine_char='│'
"let g:indentLine_char = '┊'
"let g:indentLine_fileTypeExclude = ['text', 'help', 'startify']

" }}}
" UI settings {{{

set visualbell t_vb=            " turn off error beep/flash

" Gui font
" fc-list | grep iosevka
" Neovim-qt
if LINUX()
  "GuiFont Iosevka Term:h12
  "GuiFont! Iosevka Nerd Font:h12
  "GuiFont FantasqueSansMono Nerd Font Mono:h13
  "GuiFont LiterationMono Nerd Font Mono:h11
  "GuiFont DejaVuSansMono Nerd Font:h12
  "GuiFont DejaVuSansMonoForPowerline Nerd Font:h11
  "GuiFont! InconsolataForPowerline Nerd Font:h13
  "GuiFont Knack Nerd Font:h11
  "GuiFont TerminessTTF Nerd Font:h13
  "GuiFont UbuntuMono Nerd Font:h13
  "GuiFont FuraMonoForPowerline Nerd Font:h12
  "GuiFont Roboto Mono Nerd Font:h12
  "Guifont DejaVu Sans Mono:h11
endif

if WINDOWS()
  "Guifont! Consolas:h12
  "GuiFont! Hack NF:h11
  "call rpcnotify(1, 'Gui', 'Font', 'Iosevka NF 12')
  call rpcnotify(1, 'Gui', 'Font', 'Iosevka 12')
  "GuiFont! Iosevka NF:h12
endif

" call GuiWindowMaximized(1)

" Neovim-gtk
if exists('g:GtkGuiLoaded')
  "call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
  "call rpcnotify(1, 'Gui', 'Font', 'Iosevka Regular 12')
  "call rpcnotify(1, 'Gui', 'Font', 'Hasklig Regular 11')
  "call rpcnotify(1, 'Gui', 'Font', 'Fira Code Regular 11')
  "https://github.com/ToxicFrog/Ligaturizer
  "call rpcnotify(1, 'Gui', 'Font', 'LigaHack Regular 11')
  nnoremap <silent> <C-E> :NGToggleSidebar<cr>
endif

augroup guiau
  autocmd!
  autocmd DirChanged * call rpcnotify(0, 'Dir', getcwd())
  autocmd WinEnter * call rpcnotify(0, 'Dir', getcwd())
augroup END

command! TreeViewShow call rpcnotify(0, 'TreeView', 'ShowHide', 1)
command! TreeViewHide call rpcnotify(0, 'TreeView', 'ShowHide', 0)
command! TreeViewToggle call rpcnotify(0, 'TreeView', 'Toggle')
command! NGToggleSidebar call rpcnotify(1, 'Gui', 'Command', 'ToggleSidebar')

" }}}
