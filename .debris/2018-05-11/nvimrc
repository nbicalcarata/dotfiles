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

if LINUX()
    source ~/.config/nvim/nplug.vim
    source ~/.config/nvim/general.vim
    source ~/.config/nvim/autocmd.vim
    source ~/.config/nvim/statusline.vim
    source ~/.config/nvim/color.vim
    source ~/.config/nvim/map.vim
    source ~/.config/nvim/plugins.vim
endif

if WINDOWS()
    source ~\AppData\Local\nvim\nplug.vim
    source ~\AppData\Local\nvim\general.vim
    source ~\AppData\Local\nvim\autocmd.vim
    source ~\AppData\Local\nvim\statusline.vim
    source ~\AppData\Local\nvim\color.vim
    source ~\AppData\Local\nvim\map.vim
    source ~\AppData\Local\nvim\plugins.vim
endif
