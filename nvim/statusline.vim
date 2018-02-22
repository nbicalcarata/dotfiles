" Statusline {{{

set laststatus=2
"let left_sep='▓▒░'
"let right_sep='░▒▓'
let left_sep='▚'
let left_second_sep='▖'
let right_sep='▞'
let right_second_sep='▗'
let right_alt_sep=''

"let left_sep = '▶'
"let right_sep = '◀'
"let right_alt_sep = '«'

let g:mode ={
        \ '__' : '-', 'n'  : 'N',
        \ 'i'  : 'I', 'R'  : 'R',
        \ 'v'  : 'V', 'V'  : 'V',
        \ 'c'  : 'C', '' : 'V',
        \ 's'  : 'S', 'S'  : 'S',
        \ '' : 'S', 't'  : 'T',
    \}

set statusline=%!ActiveStatus()

function! ActiveStatus()
  let l:statusline=""
  let l:statusline.="%1*"
  let l:statusline.="%(\ %{g:mode[mode()]}\ %)"
  let l:statusline.="%5*"
  let l:statusline.="%{left_sep}"
  let l:statusline.="%2*"
  let l:statusline.="%(%{&paste?'\ p\ ':''}%)"
  let l:statusline.="%{fugitive#head()!=''?'\ \ ⎇\ '.fugitive#head().'\ ':''}"
  let l:statusline.="%3*"
  let l:statusline.="%{left_second_sep}"
  let l:statusline.="%4*"
  let l:statusline.="\ %<"
  let l:statusline.="%f"
  let l:statusline.="\ "
  let l:statusline.="%#warningmsg#"
  let l:statusline.="%{&modified?'[+]':''}"
  let l:statusline.="%{&readonly?'':''}"
  let l:statusline.="%4*"
  let l:statusline.="%="
  let l:statusline.="\ %{''!=#&filetype?&filetype:'none'}"
  "let l:statusline.="\ "
  let l:statusline.="%{right_alt_sep}"
  let l:statusline.="%(%{(&bomb\|\|'^$\|utf-8'!~#&fileencoding?'\ '.&fileencoding.(&bomb?'-bom':''):'').('unix'!=#&fileformat?'\ '.&fileformat:'')}%)"
  "let l:statusline.="%(\ %{&modifiable?(&expandtab?'et\ ':'noet\ ').&shiftwidth:''}%)"
  let l:statusline.="%{g:asyncrun_status!=''?'\ \ │\ '.asyncrun_status:''}"
  let l:statusline.="\ "
  let l:statusline.="%3*"
  let l:statusline.="%{right_second_sep}"
  let l:statusline.="%2*"
  let l:statusline.="%(\ %{LinterStatus()}%)"
  let l:statusline.="\ "
  let l:statusline.="%5*"
  let l:statusline.="%{right_sep}"
  let l:statusline.="%1*"
  let l:statusline.="%(%<\ %4l\,%3c%)\ "
  "let statusline.="%(\ %{strftime(\'%H:%M\')}%)\ "
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="%f\ "
  return statusline
endfunction

augroup status
  autocmd!
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END

function! Relative_Path_CWD()
    let l:path = fnamemodify(getcwd(),":t")
    return l:path
endfunction

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✔' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" }}}
