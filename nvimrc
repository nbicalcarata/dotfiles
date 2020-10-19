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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-gtfo'
Plug 'wesQ3/vim-windowswap'
Plug 'pseewald/vim-anyfold'
Plug 'mhinz/vim-startify'
Plug 'justinmk/vim-dirvish'
Plug 'easymotion/vim-easymotion'
Plug 'voldikss/vim-browser-search'
Plug 'rhysd/git-messenger.vim'
Plug 'mattn/emmet-vim'
" Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
" Plug 'Xuyuanp/scrollbar.nvim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'danilamihailov/beacon.nvim'

" }}}
" Colorschemes {{{

Plug 'Soares/base16.nvim'

" }}}
" Git {{{

Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'
Plug 'shumphrey/fugitive-gitlab.vim'

" }}}
" Html {{{

" Plug 'Valloric/MatchTagAlways'

" }}}
" Snippets & AutoComplete {{{

" Plug 'w0rp/ale'
Plug 'betoharres/vim-react-ultiSnips'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
" Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" }}}
" Syntax highlighting{{{

Plug 'sheerun/vim-polyglot'

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
set wildmode=list:longest,full
set title
set novisualbell
set noequalalways
set hlsearch
set showmatch
set ignorecase
set smartcase
set inccommand=split
set listchars=tab:▸\ ,eol:¬,extends:»,precedes:«,trail:•
" set diffopt+=vertical
set autoindent
set noshowcmd
set nofixendofline
set nonumber
set mouse=a

set nospell
set hidden 
set foldmethod=marker
set foldlevel=99
set scrolloff=999
set signcolumn=yes
set list
set colorcolumn=120

set expandtab
set splitright
set splitbelow
set sessionoptions-=folds

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
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" }}}
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
" }}}
" Autocmd rules {{{
" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session

function! ResCur()
    if line("'\"") <= line('$')
        silent! normal! g`"
        return 1
    endif
endfunction

augroup TabSessionTitleGroup
  autocmd!
  autocmd SessionLoadPost * let &titlestring = substitute(fnamemodify(v:this_session, ':t'), '.vim', '', '')
augroup end

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END
" Term start in insert mode {{{

augroup TermCmd
    autocmd!
    autocmd TermOpen * setlocal winfixheight winfixwidth
    autocmd TermOpen * startinsert
augroup END

" }}}
" Quickfix below everything {{{

augroup QfBl
    autocmd!
    autocmd FileType qf wincmd J
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
    autocmd WinLeave,InsertEnter * setlocal nocursorline
augroup END

" }}}
" Open help files in right side {{{

" augroup HelpFilesRightSide
"     autocmd!
"     autocmd FileType help wincmd L
"     autocmd FileType help set bufhidden=unload
" augroup END

" }}}
" Disable list on preview window {{{

augroup DisableThingsFromWindows
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * if &previewwindow | setlocal nolist | setlocal colorcolumn= | endif
    autocmd FileType qf,help,fugitive setlocal signcolumn=no nonumber colorcolumn= nolist
    autocmd FilterWritePre * if &diff | setlocal foldcolumn=0 | endif
    autocmd TermOpen * setlocal foldcolumn=0 signcolumn=no nonumber
augroup END

" }}}
" rst rules {{{

" augroup RstRules
"     autocmd!
"     autocmd FileType rst setlocal syntax=OFF
" augroup END

" }}}
" Statusline {{{

set fillchars=vert:│,fold:-,diff:·,stlnc:─,eob:\ 

function! CWD()
    let l:path = fnamemodify(getcwd(),":t")
    return l:path
endfunction

function! ActiveStatus()
    let statusline=""
    let statusline.="\ %{tabpagenr()}/%{tabpagenr('$').'\ \ '}«"
    let statusline.="\ %{CWD().'\ '}»"
    let statusline.="%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ ':''}"
    let statusline.="\ %t"
    let statusline.="\ %h%m%r"
    let statusline.="\ %=%-14.(%l,%c%V%)\ %y\ "
    return statusline
endfunction

function! InactiveStatus()
    let statusline=""
    let statusline.="\ %t\ "
    return statusline
endfunction

augroup status
    autocmd!
    autocmd WinEnter * setlocal statusline=%!ActiveStatus()
    autocmd WinLeave,QuickFixCmdPost * setlocal statusline=%!InactiveStatus()
augroup END

set showtabline=1
set laststatus=2
set statusline=%!ActiveStatus()

" }}}
" Override color {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link VertSplit Directory
    autocmd ColorScheme * hi! link StatusLineNC Directory
    autocmd ColorScheme * hi! link StatusLine MatchParen
    autocmd ColorScheme * hi! link Pmenu CursorLine
    " autocmd ColorScheme * hi Pmenu gui=none
    autocmd ColorScheme * hi Folded gui=none
    autocmd ColorScheme * hi TabLine cterm=none gui=none
    autocmd ColorScheme * hi TabLineFill cterm=none gui=none
    autocmd ColorScheme * hi TabLineSel cterm=none gui=bold
    " autocmd ColorScheme * exec 'hi InlineDiffAdded' .
    "         \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
    "         \' guifg=' . synIDattr(synIDtrans(hlID('DiffAdd')), 'fg', 'gui')
    " autocmd ColorScheme * exec 'hi InlineDiffRemoved' .
    "         \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui') .
    "         \' guifg=' . synIDattr(synIDtrans(hlID('DiffDelete')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi InlineDiffLine' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Statement')), 'fg', 'gui')

    autocmd ColorScheme * hi! diffAdded guifg=#009900 ctermfg=2
    autocmd ColorScheme * hi! diffRemoved guifg=#ff2222 ctermfg=1
    autocmd ColorScheme * hi! diffChanged guifg=#bbbb00 ctermfg=3
    " autocmd ColorScheme * hi! link diffLine InlineDiffLine
    " autocmd ColorScheme * hi! link GitGutterAdd GitAddStripe
    " autocmd ColorScheme * hi! link GitGutterChange GitChangeStripe
    " autocmd ColorScheme * hi! link GitGutterDelete GitDeleteStripe
    autocmd ColorScheme * hi! link GitGutterAdd DiffAdd
    autocmd ColorScheme * hi! link GitGutterChange DiffChange
    autocmd ColorScheme * hi! link GitGutterDelete DiffDelete
augroup END

" }}}
" Mappings {{{

let g:mapleader = ','

nnoremap <esc><esc> :noh<cr>

" Backtick
inoremap '' `

" Yank from cursor to the end of the line
nnoremap Y y$

command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>

" Search word under cursor and show results in quickfix without moving it
nnoremap <leader>- :execute "vimgrep /" . expand('<cword>') ."/j %"<CR>

if !exists('g:vscode')
    nnoremap <leader>M :top 11sp term://$SHELL<cr>
    nnoremap <leader>m :below sp term://$SHELL<cr>
endif

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
map <Leader><space> <C-w>=

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
" netrw {{{

let g:netrw_altfile = 1
let g:netrw_banner = 0
let g:netrw_fastbrowse = 0
" let g:netrw_liststyle = 3
" let g:netrw_altv = 1
" let g:netrw_winsize = 15
" nmap <C-E> :Lexplore<CR>

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
nmap <silent><Leader>gq :GitGutterQuickFix\|copen<CR>
nmap <silent><Leader>ge :GitGutterPreviewHunk<CR>
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
let g:gitgutter_sign_removed = '▶'
" let g:gitgutter_set_sign_backgrounds = 1
" let g:gitgutter_override_sign_column_highlight = 0

" }}}
" Undotree {{{

nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

" }}}
" AnyFold {{{

let g:anyfold_fold_display = 0
let g:anyfold_fold_comments = 0

augroup FileTypeFolds
    autocmd!
    autocmd Filetype html AnyFoldActivate 
    autocmd Filetype htmldjango AnyFoldActivate 
    autocmd Filetype python AnyFoldActivate 
    autocmd Filetype vim AnyFoldActivate 
    autocmd Filetype typescript AnyFoldActivate 
    autocmd Filetype vue AnyFoldActivate 
    autocmd Filetype jsx AnyFoldActivate 
    autocmd Filetype javascript AnyFoldActivate 
augroup END

" }}}
" Grepper {{{

nnoremap <Leader>a :Ggrep! 
nnoremap <Leader>A :FzfAg 

"Start searching the word under the cursor:
nnoremap <leader>* :Ggrep! <C-R><C-W><cr>

" }}}
" Startify {{{

nnoremap <leader>S :SSave!<cr>
nnoremap <leader>O :SLoad 

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': [   '   Sessions']       },
      \ { 'type': 'files',     'header': [   '   MRU']            },
      \ ]

let g:startify_custom_header = [
            \ '                       █▀▀▄ █▀▀ █▀▀█ ▀█░█▀ ░▀░ █▀▄▀█',
            \ '                       █░░█ █▀▀ █░░█ ░█▄█░ ▀█▀ █░▀░█',
            \ '                       ▀░░▀ ▀▀▀ ▀▀▀▀ ░░▀░░ ▀▀▀ ▀░░░▀',
            \ ]

augroup StartifyAu
    autocmd!
    autocmd User Startified setlocal cursorline
augroup END

" }}}
" ale {{{

" nmap <leader>e <Plug>(ale_next_wrap)
" nmap <leader>E <Plug>(ale_previous_wrap)

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
                              \ 'coc-vetur',
                              \ 'coc-ultisnips' ]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

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

let $FZF_DEFAULT_OPTS='--reverse --margin=1,2'
let g:fzf_preview_window = ''
let g:fzf_buffers_jump = 0
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'yoffset': 0.5 } }

if !exists('g:vscode')
    tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
    nnoremap <silent><leader>d :FzfCommands<cr>
    nnoremap <silent><leader>r :FzfRegisters<cr>
    nnoremap <silent><leader>h :FzfHistory<cr>
    nnoremap <silent><leader>v :FzfBuffers<cr>
    nnoremap <silent><leader>l :FzfBLines<cr>
    nnoremap <expr><leader>f (len(system('git rev-parse')) ? ':FzfFiles' : ':FzfGFiles')."\<cr>"
    nnoremap <silent><leader>F :FzfFiles<cr>
endif

augroup fzfpopupter
    autocmd!
    autocmd FileType fzf exe 'tnoremap <buffer><nowait> <C-j> <Down>'
        \ | tnoremap <buffer><nowait> <C-k> <Up>
augroup END

" Yank history
function! s:get_registers() abort
  redir => l:regs
  silent registers
  redir END

  return split(l:regs, '\n')[1:]
endfunction

function! s:registers(...) abort
  let l:opts = {
        \ 'source': s:get_registers(),
        \ 'sink': {x -> feedkeys(matchstr(x, '\v^\S+\ze.*') . (a:1 ? 'P' : 'p'), 'x')},
        \ 'options': '--prompt="Reg> "'
        \ }
  call fzf#run(fzf#wrap(l:opts))
endfunction

command! -bang FzfRegisters call s:registers('<bang>' ==# '!')

" }}}
" Airline {{{

let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0

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
    \ 'ColorColumn': 'bg=light2 bg=similar3'}
    " \ 'Pmenu': 'fg=light3 bg=similar3'}
    " \ 'SignColumn': 'fg=contrast1 bg=black',
    " \ 'FoldColumn': 'fg=contrast1 bg=black',
    " \ 'LineNr': 'fg=similar1 bg=black',

let g:base16_transparent_background = 0

" }}}
" " polyglot {{{

" let g:polyglot_disabled = ['typescript']

" " }}}
" Colorscheme {{{

colorscheme paraiso

" }}}
" Commands {{{

function! s:attach_current()
    execute 'T abduco -a' CWD()
endfunction

command! SandboxDeployBack T source venv/bin/activate; fab sandbox_deploy
command! SandboxDeployFront T source venv/bin/activate; fab sandbox_deploy_front
command! PreProdDeployBack T source venv/bin/activate; fab preprod_deploy
command! PreProdDeployFront T source venv/bin/activate; fab preprod_deploy_front
command! ProdDeployBack T source venv/bin/activate; fab prod_deploy
command! ProdDeployFront T source venv/bin/activate; fab prod_deploy_front
command! ScraperDeploy T source venv/bin/activate; fab scraper_deploy
command! -nargs=1 ScrapyCrawl T source venv/bin/activate; cd scraper; scrapy crawl <args>
command! RunTests T source venv/bin/activate; python manage.py test
command! -nargs=* DockerManage T docker-compose -f local.yml run --rm django python manage.py <args>
command! Attach call <sid>attach_current()
command! -nargs=1 RunServer T abduco -c <c-r>=CWD()<cr> <args>


nnoremap <leader>C
\ :T abduco -c <c-r>=CWD()<cr>
\ docker-compose -f local.yml up

nnoremap <leader>R
\ :T docker-compose -f local.yml run -rm django 

" nnoremap <leader>A
" \ :T abduco -a <c-r>=CWD()<cr>

" }}}
" easymotion {{{

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'
let g:EasyMotion_prompt = '{n}>>'
let g:EasyMotion_verbose = 0

nmap s <Plug>(easymotion-overwin-f)

" }}}
" markdown-preview {{{

let g:mkdp_auto_close = 0

" }}}
" Web search {{{

nnoremap <leader>sg :Search google 

" }}}
" beacon {{{

" let g:beacon_minimal_jump = 10

" }}}
" editorconfig {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}}
" dirvish {{{

augroup dirvish_config
    autocmd!
    autocmd FileType dirvish nnoremap <buffer> + :edit %
    autocmd FileType dirvish nmap <buffer> q <Plug>(dirvish_quit)
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
augroup END

let g:dirvish_mode = ':sort ,^.*[\/],'
" let g:loaded_netrw       = 1
" let g:loaded_netrwPlugin = 1

" }}}
" scrollbar {{{

let g:scrollbar_shape = {
\ 'head': '▲',
\ 'body': '█',
\ 'tail': '▼',
\ }

augroup your_config_scrollbar_nvim
    autocmd!
    autocmd BufEnter    * silent! lua require('scrollbar').show()
    autocmd BufLeave    * silent! lua require('scrollbar').clear()

    autocmd CursorMoved * silent! lua require('scrollbar').show()
    autocmd VimResized  * silent! lua require('scrollbar').show()

    autocmd FocusGained * silent! lua require('scrollbar').show()
    autocmd FocusLost   * silent! lua require('scrollbar').clear()
augroup end

" }}}
" emmet {{{

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

" }}}
