" Plugins settings {{{

" NERDTree {{{

let g:NERDTreeMinimalUI = 1
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCascadeSingleChildDir = 0
nnoremap <silent> <leader>e :NERDTreeFind<cr>
map <silent> <C-e> :NERDTreeToggle<CR>
if LINUX()
  map <silent> <C-e> :TreeViewToggle<CR>
endif
let g:NERDTreeWinPos='left'
let g:NERDTreeQuitOnOpen=0
"let g:NERDTreeStatusline="%{Relative_Path_CWD()}"

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
let g:undotree_WindowLayout = 3
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

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
nnoremap <leader>v :Denite buffer<cr>
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
nnoremap <silent> <leader>j :<C-u>Denite 
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
      \ 'prompt': '❯'
      \ })

      "\ 'statusline' : 0
call denite#custom#var('buffer', 'date_format', '')

call denite#custom#option('_', 'highlight_matched_range', 'None')
call denite#custom#option('_', 'highlight_matched_char', 'Character')

" }}}
" Neoterm {{{
"let g:neoterm_position = 'vertical'
let g:neoterm_size = 8
let g:neoterm_automap_keys = ',tt'
let g:neoterm_autoscroll = 1
nnoremap <silent> ,tj :Ttoggle<cr>
nnoremap <silent> ,tc :call neoterm#clear()<cr>
nnoremap <silent> ,tk :call neoterm#kill()<cr>

"function! Run(cmd)
   "call neoterm#open() " Opens the neoterm window
   "call neoterm#normal('G') " Scroll to the end of the neoterm window
   "exec a:cmd
"endfunction

"nnoremap ,A :call Run('docker exec -i --user=laradock laradock_workspace_1 sh -lc "cd interpos; "')<left><left><left>
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

"let g:startify_session_remove_lines = ['neoterm']

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

if WINDOWS()
  let g:python3_host_prog = 'C:\Python36\python'
endif
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
nnoremap <leader>T :10Term<cr>

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
" AsyncRun {{{

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
"  vim-closetag {{{

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue,*.blade.php'

"  }}}
"  emmet {{{

let g:user_emmet_leader_key = '<C-y>'

"  }}}
"  indentline {{{

let g:indentLine_concealcursor=0
"let g:indentLine_char='│'
let g:indentLine_char = '┊'
let g:indentLine_fileTypeExclude = ['text', 'help', 'startify', 'nerdtree']

"  }}}
" }}}
