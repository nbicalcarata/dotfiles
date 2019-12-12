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
augroup IndentSettings
    autocmd!
    autocmd Filetype html setlocal ts=2 sw=2
    autocmd Filetype htmldjango setlocal ts=2 sw=2
    autocmd Filetype php setlocal ts=4 sw=4
    autocmd Filetype vue setlocal ts=2 sw=2
    autocmd Filetype javascript setlocal ts=2 sw=2
    autocmd Filetype blade setlocal ts=2 sw=2
    autocmd Filetype typescript setlocal ts=4 sw=4
    autocmd Filetype scss setlocal ts=4 sw=4
    autocmd Filetype vim setlocal ts=4 sw=4
    autocmd Filetype css setlocal ts=4 sw=4
    autocmd Filetype cucumber setlocal ts=2 sw=2
    autocmd Filetype json setlocal ts=2 sw=2
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
set scrolloff=999
" set signcolumn=yes:2

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

" }}}
" Styling vertical splits {{{
set fillchars=vert:│,fold:۰,diff:·,stlnc:─
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
" Autocmd rules {{{

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
" {{{

augroup TSSyntax
    autocmd!
    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
augroup END

" }}}
" PDB {{{
" pip install pdbpp

augroup SetBreakpoints
    autocmd!
    autocmd FileType python map <silent> <leader>x oimport pdb; pdb.set_trace()  # noqa: E702<esc>
    autocmd FileType python map <silent> <leader>X Oimport pdb; pdb.set_trace()  # noqa: E702<esc>
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
" rst rules {{{

augroup RstRules
    autocmd!
    autocmd FileType rst syn spell toplevel
    autocmd FileType rst setlocal spell
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

set showtabline=0
set laststatus=2

" }}}
" Mappings {{{

let g:mapleader = ','

xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine


" Quick edit vimrc
nnoremap <leader>ev :e ~/dotfiles/nvimrc<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>sg :source ~/.config/nvim/ginit.vim<cr>

if WINDOWS()
  nnoremap <leader>ev :e ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sv :source ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sg :source ~\AppData\Local\nvim\ginit.vim<cr>
endif

nnoremap <F1> <nop>
nnoremap Q <nop>

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

" Easier horizontal scrolling
map zl zL
map zh zH

" Center cursor on search results
noremap n nzz
noremap N Nzz


function! NumberToggle()
    if(&relativenumber == 1)
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

" Toggle between absolute and relative line numbers
nnoremap <Leader>n :call NumberToggle()<cr>

" Toggle between invisible chars
nmap <leader>i :set list!<CR>

"Rename buffer
nnoremap <leader>en :keepalt file<space>

" }}}

command! SandboxDeployBack T source venv/bin/activate; fab sandbox_deploy
command! SandboxDeployFront T source venv/bin/activate; fab sandbox_deploy_front
command! PreProdDeployBack T source venv/bin/activate; fab preprod_deploy
command! PreProdDeployFront T source venv/bin/activate; fab preprod_deploy_front
command! ProdDeployBack T source venv/bin/activate; fab prod_deploy
command! ProdDeployFront T source venv/bin/activate; fab prod_deploy_front
command! ScraperDeploy T source venv/bin/activate; fab scraper_deploy
command! -nargs=1 ScrapyCrawl T source venv/bin/activate; cd scraper; scrapy crawl <args>
command! RunTests T source venv/bin/activate; python manage.py test

" }}}