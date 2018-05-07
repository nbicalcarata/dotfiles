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

Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'chriskempson/base16-vim'
Plug '~/.vim/plugged/eclim'
Plug 'jiangmiao/auto-pairs'
Plug 'romainl/vim-cool'
Plug 'Shougo/denite.nvim'
Plug 'scrooloose/nerdcommenter'

function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --js-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

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

let g:CoolTotalMatches = 1

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

" youcompleteme

let g:EclimCompletionMethod = 'omnifunc'
let g:ycm_autoclose_preview_window_after_insertion = 1

"set fillchars=vert:│,fold:۰,diff:· 

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
    "autocmd ColorScheme * hi! link VertSplit CursorLine
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
    autocmd ColorScheme * hi StatusLine cterm=NONE ctermbg=NONE guibg=#2C3135
    "autocmd ColorScheme * hi Folded     gui=none cterm=none ctermbg=none guibg=none
    autocmd ColorScheme * hi LineNr                 guibg=NONE ctermbg=NONE
    autocmd ColorScheme * hi SignColumn             guibg=NONE ctermbg=NONE
    autocmd ColorScheme * hi VertSplit              guifg=#2C3135 guibg=#2C3135
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

