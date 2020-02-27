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
Plug 'Shougo/neomru.vim'
Plug 'romainl/vim-cool'
Plug 'yssl/QFEnter'
Plug 'Shougo/denite.nvim'
" Plug 'junegunn/fzf', { 'do': './install --bin' }
" Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-gtfo'
Plug 'mbbill/undotree'
Plug 'wesQ3/vim-windowswap'
" Plug 'pseewald/vim-anyfold'
Plug 'mhinz/vim-startify'
Plug 'kshenoy/vim-signature'
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-vinegar'
Plug 'easymotion/vim-easymotion'

" }}}
" Colorschemes {{{

Plug 'Soares/base16.nvim'

" }}}
" Git {{{

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" }}}
" Html {{{

Plug 'Valloric/MatchTagAlways'
Plug 'alvan/vim-closetag'

" }}}
" Snippets & AutoComplete {{{

Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'

" }}}
" Syntax highlighting{{{

Plug 'sheerun/vim-polyglot'
Plug 'ianks/vim-tsx'
Plug 'posva/vim-vue'
Plug 'leafgarland/typescript-vim'

" }}}

" Plug end {{{

call plug#end()

" }}}
" }}}

filetype plugin indent on
syntax enable

" General {{{
if executable('ag')
   set grepprg=ag\ --nogroup\ --nocolor
endif
set title
set novisualbell
set equalalways
set hlsearch
set showmatch
set ignorecase
set smartcase
set inccommand=split
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
set diffopt+=vertical
set autoindent
set noshowcmd

set nospell
set hidden 
set foldmethod=marker
set foldlevel=99
set scrolloff=999
set signcolumn=yes
set list

set expandtab
set splitright
set splitbelow

match ErrorMsg /\%>120c/
let g:loaded_matchparen = 1

" }}}

set clipboard=unnamedplus
if WINDOWS()
    set clipboard=unnamed
endif

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

" }}}
" True color {{{

set termguicolors

" }}}
" Cursor line {{{

set cursorline

" }}}

set fillchars=vert:│,fold:-,diff:·,stlnc:─

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
" Autocmd rules {{{

" Term start in insert mode {{{

augroup TermInsert
    autocmd!
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

augroup DiffSettings
    autocmd!
    autocmd FilterWritePre * if &diff | setlocal foldcolumn=0 | endif
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
    autocmd VimEnter,WinEnter,BufWinEnter,InsertLeave * setlocal cursorline
    " autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    autocmd WinLeave,InsertEnter * setlocal nocursorline
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
    autocmd VimEnter,WinEnter,BufWinEnter * if &previewwindow | setlocal nolist | setlocal colorcolumn= | endif
    autocmd FileType qf,help,fugitive setlocal nonumber colorcolumn= nolist
augroup END

" }}}
" rst rules {{{

augroup RstRules
    autocmd!
    autocmd FileType rst setlocal syntax=OFF
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

function! Relative_Path_CWD()
    let l:path = fnamemodify(getcwd(),":t")
    return l:path
endfunction

set showtabline=0
set laststatus=2

set statusline=
set statusline+=\ %{tabpagenr()}/%{tabpagenr('$').'\ \ '}«
set statusline+=\ %{Relative_Path_CWD().'\ '}» 
set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}
set statusline+=\ %h%m%r

" }}}
" Override color au {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link VertSplit NonText
    autocmd ColorScheme * hi! link StatusLineNC NonText
    autocmd ColorScheme * hi! link StatusLine TabLineFill
    autocmd ColorScheme * hi Folded      gui=none cterm=none ctermbg=none guibg=none
    autocmd ColorScheme * hi TabLine     gui=none cterm=none
    autocmd ColorScheme * hi TabLineSel  gui=bold,reverse
    autocmd ColorScheme * hi TabLineFill gui=none

    autocmd ColorScheme * exec 'hi InlineDiffAdded' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('DiffAdd')), 'fg', 'gui') . ' gui=bold'
    autocmd ColorScheme * exec 'hi InlineDiffRemoved' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('DiffDelete')), 'fg', 'gui') . ' gui=bold'
    autocmd ColorScheme * exec 'hi InlineDiffLine' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Statement')), 'fg', 'gui')

    autocmd ColorScheme * hi! link diffAdded InlineDiffAdded
    autocmd ColorScheme * hi! link diffRemoved InlineDiffRemoved
    autocmd ColorScheme * hi! link diffLine InlineDiffLine
augroup END

" }}}
" Mappings {{{

let g:mapleader = ','

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" Search word under cursor and show results in quickfix without moving it
nnoremap <leader>- :execute "vimgrep /" . expand('<cword>') ."/j %"<CR>

nnoremap <leader>m :below sp term://$SHELL<cr>

" Insert source bin/activate
tnoremap <leader>va source venv/bin/activate<cr>

" Jump to tag
nnoremap <leader>T <C-]>

" Jump to previous edited buffer
nnoremap <BS> <C-^>

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

nnoremap <leader>tn :tabnew<CR>

" Next/prev tab
nnoremap <silent> <tab> gt
nnoremap <silent> <s-tab> gT

" Space to fold
nnoremap <space> za

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

" Resizing windows
nnoremap <C-up> <C-W>-
nnoremap <C-down> <C-W>+
nnoremap <C-right> 5<C-W><
nnoremap <C-left> 5<C-W>>

" Substitute
nnoremap <leader>s :%s///gI<left><left><left><left>
vnoremap <leader>s :s///gI<left><left><left><left>

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

"<leader>q to close buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

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

"set working directory to current file
command! FileDir cd %:p:h
command! TabDir tc %:p:h

"Rename buffer
nnoremap <leader>en :keepalt file<space>

" }}}
" Plugins settings

" vim-cool {{{

let g:CoolTotalMatches = 1

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
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
" let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 15
" nmap <C-E> :Lexplore<CR>

" }}}
" Denite {{{
"
augroup Denite
    autocmd!
    autocmd VimResized * call <SID>denite_detect_size()
    autocmd FileType denite call s:denite_my_settings()
    autocmd WinEnter * if &filetype =~# '^denite'
        \ |   highlight! link CursorLine Visual
        \ | endif

    autocmd WinLeave * if &filetype ==# 'denite'
        \ |   highlight! link CursorLine NONE
        \ | endif
augroup end

function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-x> denite#do_map('do_action', 'split')
  nnoremap <silent><buffer><expr> q denite#do_map('quit')
  nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

function! s:denite_detect_size() abort
    let s:denite_winheight = 20
    let s:denite_winrow = 4
    let s:denite_winwidth = &columns > 240 ? &columns / 2 : 120
    let s:denite_wincol = &columns > s:denite_winwidth ? (&columns - s:denite_winwidth) / 2 : 0
    call denite#custom#option('_', {
                \ 'wincol': s:denite_wincol,
                \ 'winheight': s:denite_winheight,
                \ 'winrow': s:denite_winrow,
                \ 'winwidth': s:denite_winwidth,
                \ })
endfunction

try
    call s:denite_detect_size()
	call denite#custom#alias('source', 'file/rec/git', 'file/rec')
    call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
    call denite#custom#option('_', { 'start_filter': v:true })
    call denite#custom#option('_', { 'split': 'floating' })
    call denite#custom#option('_', { 'prompt': '>>' })
    " call denite#custom#option('_', { 'highlight_filter_background': 'Visual' })
    " call denite#custom#option('_', 'highlight_matched_range', 'Character')
    call denite#custom#option('_', 'highlight_matched_char', 'Character')
catch
    " echomsg "Denite plugin not installed"
endtry

" Change mappings.
nnoremap <silent><leader>d :Denite 
nnoremap <silent><leader>v :Denite buffer<cr>
nnoremap <silent><leader>l :Denite line<cr>
nnoremap <silent><leader>f :Denite file_mru
\ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file'`<CR>

" }}}
" UltiSnips {{{

let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsListSnippets='<c-l>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
inoremap <c-x><c-k> <c-x><c-k>
let g:UltiSnipsSnippetDirectories = ['UltiSnips']

" }}}
" Matchtag always {{{

" Custom MatchTag syntax group with a default highlight color
"let g:mta_use_matchparen_group = 0
let g:mta_filetypes = {
            \ 'html' : 1,
            \ 'htmldjango' : 1,
            \ 'xhtml' : 1,
            \ 'xml' : 1,
            \ 'jinja' : 1,
            \ 'blade' : 1,
            \ 'php' : 1,
            \ 'javascript' : 1,
            \ 'vue' : 1,
            \}

" }}}
" Git {{{

set updatetime=100

nmap <silent><leader>gn :GitGutterNextHunk<CR>
nmap <silent><leader>gp :GitGutterPrevHunk<CR>
nmap <silent><Leader>gs :GitGutterStageHunk<CR>
nmap <silent><Leader>gr :GitGutterUndoHunk<CR>
nmap <Leader>gc :T git checkout 
nmap <Leader>gS :T git push --set-upstream origin 
nmap <Leader>gP :T git push<cr>
nmap <silent><Leader>gd :-1tabedit %<CR>:Gdiff<cr>
nmap <silent><Leader>gl :Glog<cr>
nmap <silent><Leader>gb :Gbrowse<cr>

let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_override_sign_column_highlight = 0

" }}}
" Undotree {{{

nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

" }}}
" AnyFold {{{

" let g:anyfold_activate = 1
" let g:anyfold_fold_display = 0
" let g:anyfold_fold_comments = 0

" augroup FileTypeFolds
"     autocmd!
"     autocmd Filetype * AnyFoldActivate
" augroup END

" }}}
" Grepper {{{

nnoremap <Leader>a :Ggrep! 

"Start searching the word under the cursor:
nnoremap <leader>* :Ggrep! <C-R><C-W><cr>

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

let g:startify_custom_header = [
            \ '                       █▀▀▄ █▀▀ █▀▀█ ▀█░█▀ ░▀░ █▀▄▀█',
            \ '                       █░░█ █▀▀ █░░█ ░█▄█░ ▀█▀ █░▀░█',
            \ '                       ▀░░▀ ▀▀▀ ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░░░▀',
            \ ]

augroup StartifyAu
    autocmd!
    autocmd User Startified setlocal cursorline
augroup END

let g:startify_session_autoload = 1
nnoremap <leader>S :SSave<cr>

" }}}
" ale {{{

nmap <leader>e <Plug>(ale_next_wrap)
nmap <leader>E <Plug>(ale_previous_wrap)

let g:ale_enabled = 1
let g:ale_pattern_options = {'\.min.js$': {'ale_enabled': 0}}
let g:ale_set_loclist = 0
let g:ale_set_signs = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_python_flake8_options = '--ignore=E501' 
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_javascript_eslint_use_global = 1
" let g:ale_linters = {
"             \ 'javascript': ['eslint'],
"             \ 'typescript': ['tslint'],
"             \ 'vue': ['eslint']
"             \}

" }}}
" vim-vue {{{

let g:vue_disable_pre_processors = 1

" }}}
" gutentags {{{

let g:gutentags_cache_dir = '~/.cache/gutentags'
"let g:gutentags_ctags_exclude = ["*.min.js", "*.min.css", "build", ".git", "node_modules", "db", "log"]

" }}}
" coc {{{
let g:airline#extensions#coc#enabled = 1
let g:coc_global_extensions = [ 'coc-tsserver',
                              \ 'coc-tslint',
                              \ 'coc-tslint-plugin',
                              \ 'coc-css',
                              \ 'coc-json',
                              \ 'coc-python',
                              \ 'coc-highlight',
                              \ 'coc-emmet',
                              \ 'coc-ultisnips' ]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Expand with enter (conflicts with auto-pairs)
":verbose imap <CR>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
" Term {{{

"Execute command from docker container
"To make it work, remove t option from command

"docker exec -i --user=laradock laradock_workspace_1 sh -c "cd interpos; ./vendor/bin/behat features/order.feature
"docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; npm run dev
nnoremap <leader>A :T docker exec -it --user=laradock laradock_workspace_1 sh -lc ""<left>

" }}}
" fugitive {{{

nnoremap <leader>ch :diffget //2<CR>
nnoremap <leader>cl :diffget //3<CR>
nnoremap <leader>G :vertical Gstatus<CR>

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost *grep* cwindow
augroup END

" }}}
" vim-closetag {{{

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.blade.php'

"  }}}
" Python syntax highlight {{{

let g:python_highlight_all = 1

" }}}
" vim-signature {{{

command! GM :SignatureListGlobalMarks
command! BM :SignatureListGlobalMarks

" }}}
" fzf {{{
" let $FZF_DEFAULT_OPTS='--reverse --margin=1,2'
" let g:fzf_buffers_jump = 0
" let g:fzf_command_prefix = 'Fzf'
" let g:fzf_layout = { 'window': { 'width': 0.7, 'height': 0.6, 'yoffset': 0.2, 'border': 'rounded' } }

" nnoremap <leader>d :Fzf
" nnoremap <silent><leader>r :FzfFiles<cr>
" nnoremap <silent><leader>v :FzfBuffers<cr>
" nnoremap <silent><leader>l :FzfBLines<cr>
" nnoremap <silent><leader>f :FzfCycle<cr>

" augroup EscFzf
"   au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
"   au FileType fzf tunmap <buffer> <Esc>
" augroup END

" function! s:fzf_next(idx)
"   let commands = ['FzfHistory', 'FzfGFiles']
"   execute commands[a:idx]
"   let next = (a:idx + 1) % len(commands)
"   let previous = (a:idx - 1) % len(commands)
"   execute 'tnoremap <buffer> <silent> <c-f> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.next.')<cr>'
"   execute 'tnoremap <buffer> <silent> <c-b> <c-\><c-n>:close<cr>:sleep 100m<cr>:call <sid>fzf_next('.previous.')<cr>'
" endfunction

" command! FzfCycle call <sid>fzf_next(0)

" }}}
" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

let g:airline#extensions#tabline#enabled = 0           " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tabs_label = 'T'       " can put text here like BUFFERS to denote buffers (I clear it so nothing is shown)
let g:airline#extensions#tabline#buffers_label = 'B'    " can put text here like TABS to denote tabs (I clear it so nothing is shown)
let g:airline#extensions#tabline#formatter = 'short_path'
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 1     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline

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

function! Render_Only_File(...)
  let builder = a:1
  let context = a:2
  call builder.add_section('file', '%f ')
  return 1
endfunction

try
    call airline#add_inactive_statusline_func('Render_Only_File')
catch
    " no airline
endtry

function! TabNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_c', printf(' %d/%d ', tabpagenr(), tabpagenr('$')))
    return 0
endfunction

try
    call airline#add_statusline_func('TabNumber')
catch
    " no airline
endtry

" }}}
" base16 {{{

let g:base16_color_overrides = {
    \ 'CursorLineNr': 'fg=light1 bg=similar3 bold',
    \ 'ColorColumn': 'bg=light2 bg=similar3',
    \ 'SignColumn': 'fg=contrast1 bg=black',
    \ 'FoldColumn': 'fg=contrast1 bg=black',
    \ 'LineNr': 'fg=similar1 bg=black',
    \ 'Pmenu': 'fg=light3 bg=similar3'}

" }}}
" " polyglot {{{

let g:polyglot_disabled = ['typescript']

" " }}}
" Colorscheme {{{

if LINUX()
    colorscheme default
    let g:airline_theme = 'jellybeans'
endif

" }}}
" defx {{{

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>
  \ defx#is_directory() ?
  \ defx#do_action('open') :
  \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> c
  \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
  \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
  \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> l
  \ defx#do_action('open')
  nnoremap <silent><buffer><expr> E
  \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> P
  \ defx#do_action('open', 'pedit')
  nnoremap <silent><buffer><expr> o
  \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> K
  \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
  \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M
  \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C
  \ defx#do_action('toggle_columns',
  \                'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S
  \ defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d
  \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> r
  \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> !
  \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x
  \ defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy
  \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
  \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;
  \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h
  \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~
  \ defx#do_action('cd')
  nnoremap <silent><buffer><expr> q
  \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
  \ defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *
  \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j
  \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
  \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-g>
  \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
  \ defx#do_action('change_vim_cwd')
endfunction

try
    call defx#custom#column('icon', {
          \ 'directory_icon': '▸',
          \ 'opened_icon': '▾',
          \ 'root_icon': ' ',
          \ })

	" call defx#custom#column('filename', {
	"       \ 'min_width': 60,
	"       \ })
catch
    " Defx not installed
endtry

" Floating
" nmap <silent>- :Defx -search=`expand('%:p')` -wincol=999 -winheight=999 -winwidth=65 -split=floating -toggle<CR>
" nmap <silent>- :Defx -search=`expand('%:p')`<CR>

" }}}
" Commands {{{

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
" context {{{

" let g:context_border_char = '─'
" let g:context_add_mappings = 0
" let g:context_add_autocmds = 0

" augroup context.vim
"     autocmd!
"     autocmd VimEnter     * ContextActivate
"     autocmd BufAdd       * call context#update('BufAdd')
"     autocmd BufEnter     * call context#update('BufEnter')
"     autocmd VimResized   * call context#update('VimResized')
"     autocmd CursorHold   * call context#update('CursorHold')
" augroup END

" }}}
" easymotion {{{

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
let g:EasyMotion_prompt = '{n}>> '
let g:EasyMotion_verbose = 0

nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" }}}
