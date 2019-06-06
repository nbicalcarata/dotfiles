silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win16') || has('win32') || has('win64'))
endfunction

filetype plugin indent on
syntax on

set nocompatible
set noswapfile
set laststatus=2
set tabstop=8
set shiftwidth=4
set softtabstop=4      
set cursorline
set number
set wrap
set hlsearch
set showmatch
set ignorecase
set smartcase
set noerrorbells visualbell t_vb=
set belloff=all
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
set completeopt-=preview
set wildignorecase
set wildmode=list:longest,full

call plug#begin('~/.vim/plugged')

"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"Plug 'chriskempson/base16-vim'
"Plug '~/.vim/plugged/eclim'
"Plug 'jiangmiao/auto-pairs'
"Plug 'romainl/vim-cool'
"Plug 'Shougo/denite.nvim'
"Plug 'scrooloose/nerdcommenter'

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
" Plug 'fenetikm/falcon'
"Plug 'ayu-theme/ayu-vim'
Plug 'atelierbram/Base2Tone-vim' 
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

call plug#end()

let g:mapleader = ','

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

set shortmess+=c   " Shut off completion messages
" vim-cool {{{

let g:CoolTotalMatches = 1

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
"nnoremap <leader>o :Denite outline<cr>
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
            \ 'reversed': 1,
            \ 'auto_resize': 1,
	    \ 'statusline': v:false
            \ })

            "\ 'statusline': 0
            "\ 'split': 'no'
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
" }}}
" youcompleteme {{{
"
let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_autoclose_preview_window_after_insertion = 1

" }}}
set fillchars=vert:│,fold:۰,diff:· 
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

let g:ale_python_pylint_options = '--load-plugins pylint_django'

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

" Statusline
set statusline=
set statusline+=%3* 
set statusline+=\ %n\  
set statusline+=%5* 
set statusline+=\ %f
set statusline+=\ %h%m%r
set statusline+=%<
set statusline+=%=
set statusline+=%1* 
set statusline+=\ %{''!=#&filetype?&filetype.'\ •\ ':''}
"set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ •\ ':''}
set statusline+=%(%4l\,%3c%)\ 

augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link LineNr TabLine
    autocmd ColorScheme * hi! link ColorColumn CursorLine
    autocmd ColorScheme * hi! link CursorColumn CursorLine
    autocmd ColorScheme * hi! link VertSplit Folded
    autocmd ColorScheme * hi! link StatusLineNC VertSplit
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
    autocmd ColorScheme * hi StatusLine cterm=NONE ctermbg=NONE guibg=NONE
    " autocmd ColorScheme * hi StatusLine cterm=NONE ctermbg=NONE guibg=#2C3135
    autocmd ColorScheme * hi Folded     gui=none cterm=none ctermbg=none guibg=NONE 
    " autocmd ColorScheme * hi LineNr                 guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * hi SignColumn             guibg=NONE ctermbg=NONE
    " autocmd ColorScheme * hi VertSplit              guifg=#2C3135 guibg=#2C3135
    "autocmd ColorScheme * hi GitGutterAdd           guibg=NONE ctermbg=NONE
    "autocmd ColorScheme * hi GitGutterChange        guibg=NONE ctermbg=NONE
    "autocmd ColorScheme * hi GitGutterDelete        guibg=NONE ctermbg=NONE
    "autocmd ColorScheme * hi GitGutterChangeDelete  guibg=NONE ctermbg=NONE
    "autocmd ColorScheme * hi ALEErrorSign           guibg=NONE ctermbg=NONE
    "autocmd ColorScheme * hi ALEWarningSign         guibg=NONE ctermbg=NONE
augroup END

" Only show cursorline in the current window {{{

augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    "autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
    autocmd WinLeave * setlocal nocursorline
    "autocmd WinLeave * setlocal nocursorcolumn
augroup END

" Quick edit vimrc {{{

nnoremap <leader>ev :e ~/dotfiles/vimrc<cr>
nnoremap <leader>eg :e ~/dotfiles/gvimrc<cr>

" }}}
