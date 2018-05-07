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
set statusline+=%{fugitive#head()!=''?'\ \ '.fugitive#head().'\ •\ ':''}
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
