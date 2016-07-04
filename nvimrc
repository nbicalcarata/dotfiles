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

let basedir = '.config/nvim'

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

Plug 'adambiggs/tmuxline.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'justinmk/vim-gtfo'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'
Plug 'mbbill/undotree'
Plug 'Harenome/vim-neatfoldtext'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/vimshell.vim'
Plug 'kassio/neoterm'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

"}}}
" Colorschemes {{{

Plug 'nbicalcarata/vim-womprat'
Plug 'nbicalcarata/vim-airline-womprat'
Plug 'nbicalcarata/vim-airline-dieciseis'
Plug 'nanotech/jellybeans.vim'
Plug 'sickill/vim-monokai'
Plug 'nbicalcarata/Muon'
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'AlessandroYorba/Alduin'
Plug 'whatyouhide/vim-gotham'
Plug 'AlessandroYorba/Sierra'
Plug 'joshdick/onedark.vim'
Plug 'joshdick/airline-onedark.vim'

" }}}
" Git {{{

Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'
Plug 'chemzqm/unite-git-log'
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

Plug 'sheerun/vim-polyglot'

" }}}

" }}}
" Plug end {{{

call plug#end()

" }}}

" Basics {{{

if !WINDOWS()
    set shell=/bin/sh
endif

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

" Setting up the directories {{{

set noswapfile
set backup                                     " Backups are nice ...
if has('persistent_undo')
    set undofile                                " So is persistent undo ...
    set undolevels=10000                        " Maximum number of changes that can be undone
    set undoreload=10000                        " Maximum number lines to save for undo
endif

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
" Vimfiler rules {{{

augroup VimfilerRules
    autocmd!
    autocmd FileType vimfiler setlocal nonumber     " no line number
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

" }}}
" PHP with html syntax {{{
  
augroup phpLaravel
    autocmd!
    autocmd BufRead,BufNewFile *.php set filetype=php.laravel.html
    autocmd BufRead,BufNewFile *.blade.php set filetype=blade.html
augroup END

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
set noea
set lazyredraw
"set noshowmode                  " Dont display the current mode
set nohlsearch                  " Highlight search matches
set showmatch                   " show matching brackets/parenthesis
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set scrolloff=5                 " Minimum lines to keep above and below cursor

if LINUX()
    set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
endif

" }}}
" Formatting {{{

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

let g:alduin_Shout_Fire_Breath = 1
"let g:jellybeans_use_lowcolor_black = 0
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

colorscheme onedark

" }}}
" Cursor line {{{

set cursorline
hi Search cterm=NONE ctermfg=black
"hi CursorLineNr   cterm=bold

" }}}
" Statusline {{{

set statusline=%<%f\                     " Filename
set statusline+=\ \ 
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
"set statusline+=\ \ 
set statusline+=\ %{&ff}/%Y            " Filetype
set statusline+=\ \ 
set statusline+=\ %{getcwd()}          " Current dir
set statusline+=%=%-14.(\ %l,%c%V%)\ %p%%  " Right aligned file nav info
set statusline+=%#NeotermTestRunning#%{neoterm#test#status('running')}%*
set statusline+=%#NeotermTestSuccess#%{neoterm#test#status('success')}%*
set statusline+=%#NeotermTestFailed#%{neoterm#test#status('failed')}%*

" }}}
" Styling vertical splits {{{
if LINUX()
    "set fillchars=vert:│,diff:⎼,fold:⎼
    "set fillchars=vert:┃,diff:⎼,fold:⎼
endif

augroup OverrideColor
    autocmd!
    autocmd ColorScheme * highlight VertSplit guibg=NONE cterm=NONE ctermbg=NONE
    "autocmd ColorScheme * highlight Folded    guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight Number    guibg=NONE ctermbg=none
    "autocmd ColorScheme * highlight LineNr    guibg=NONE ctermbg=none
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
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
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

" Term move between splits
tnoremap <C-e> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l
tnoremap <C-w>c <C-\><C-n><C-w>c

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
" Vimfiler {{{
let g:vimfiler_as_default_explorer = 1
nnoremap <leader>e :VimFilerExplorer -project<CR>
nnoremap <silent>- :<c-u>VimFilerBufferDir -simple<CR>

" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

" }}}
" Airline {{{
let g:replace_separators = 0
let g:airline_powerline_fonts = 1
let g:tmuxline_preset = 'full'
"let g:airline_theme = 'tomorrow'
let g:airline_theme = 'behelit'
let g:airline#extensions#tabline#enabled = 1            " Activar tabline
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#branch#empty_message = '*'
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tmuxline#enabled = 1
let g:tmuxline_preset = 'full'
let g:airline#extensions#tmuxline#snapshot_file = "~/dotfiles/snapshot_tmuxline"
let g:airline_skip_empty_sections = 1

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

nnoremap <C-@> :<C-u>Unite<CR>
" file_rec/async 
" https://github.com/Shougo/unite.vim/issues/1079
nnoremap <leader>m :<C-u>UniteWithProjectDir -buffer-name=files_rec file_rec/async:!<CR>
nnoremap <leader>a :<C-u>UniteWithProjectDir grep -buffer-name=grep<CR>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffers buffer bookmark<CR>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=search line<cr>

let g:unite_source_codesearch_ignore_case = 1
let g:unite_prompt='> '
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_selecta'])
""call unite#custom#source('file,file/new,file_mru,buffer,file_rec',
    ""\ 'matchers', 'matcher_fuzzy')
let g:unite_data_directory='~/.config/nvim/cache/unite'
let g:unite_source_history_yank_enable=1

if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts='-i -r --line-numbers --nocolor --nogroup -S'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_rec_async_command =
        \ ['ag', '--follow', '--nogroup', '--nocolor', '--hidden', '-g', '']
endif

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor -S --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command = ['pt', '--nogroup', '--nocolor', '-S', '-g', '.']
endif

call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'silent': 1
\ })

function! s:unite_settings()
   " Enable navigation with control-j and control-k in insert mode
   imap <buffer> <Esc>   <Plug>(unite_exit)
   imap <buffer> <c-j>   <Plug>(unite_select_next_line)
   imap <buffer> <c-k>   <Plug>(unite_select_previous_line)
 endfunction

 " Custom mappings for the unite buffer
 autocmd FileType unite call s:unite_settings()

"function! s:EscapeUnite()
    "augroup CloseUniteBuffer
        "autocmd!
        "autocmd InsertEnter <buffer>
            "\ let b:close = 0 |
            "\ let g:udt = &updatetime |
            "\ set updatetime=3

        "autocmd InsertLeave <buffer>
            "\ let b:close = 1

        "autocmd BufLeave,CursorHold <buffer>
            "\ let &updatetime = g:udt |
            "\ unlet g:udt

        "autocmd CursorHold <buffer>
            "\ if b:close | close | endif
    "augroup END
"endfunction

"augroup EscapeUnite
    "autocmd!
    "autocmd FileType unite call s:EscapeUnite()
"augroup END

" settings for neomru
let g:neomru#file_mru_limit = 10
let g:neomru#file_mru_ignore_pattern = 'COMMIT_EDITMSG'

if WINDOWS()
endif

" }}}
" FZF {{{

let g:fzf_nvim_statusline = 0
"nnoremap <C-p> :<C-u>Files<CR>
"nnoremap <leader>r :<C-u>ProjectFiles<CR>
"nnoremap <leader>b :<C-u>Buffers<CR>
"nnoremap <leader>m :<C-u>History<cr>
"nnoremap <leader>f :<C-u>Lines<cr>

function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=235
  highlight fzf2 ctermfg=23 ctermbg=235
  highlight fzf3 ctermfg=237 ctermbg=235
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

" }}}
" UltiSnips {{{

let g:UltiSnipsExpandTrigger="<c-e>"
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
nmap <Leader>gc :Gcommit<cr>

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
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1

" }}}
" NeatFoldText {{{

let g:NeatFoldTextFancy = 1

" }}}
" Vimshell {{{
 
let g:vimshell_prompt_expr ='escape(fnamemodify(getcwd(), ":~").">", "\\[]()?! ")." "'
let g:vimshell_prompt_pattern = '^\%(\f\|\\.\)\+> '

" }}}

" }}}
