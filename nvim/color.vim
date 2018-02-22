" Override color au {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link LineNr TabLine
    autocmd ColorScheme * hi! link ColorColumn CursorLine
    autocmd ColorScheme * hi! link CursorColumn CursorLine
    autocmd ColorScheme * hi! link VertSplit StatusLineNC
    autocmd ColorScheme * exec 'hi User1 gui=bold' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    autocmd ColorScheme * exec 'hi User2' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
    autocmd ColorScheme * exec 'hi User3' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui')
            \' guifg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi User5' .
            \' guibg=' . synIDattr(synIDtrans(hlID('Function')), 'fg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('Normal')), 'fg', 'gui')
    autocmd ColorScheme * exec 'hi User4 gui=bold' .
            \' guibg=' . synIDattr(synIDtrans(hlID('CursorLine')), 'bg', 'gui') .
            \' guifg=' . synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'gui')
    autocmd ColorScheme * hi StatusLine gui=bold cterm=none ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi StatusLineNC gui=none cterm=none ctermbg=NONE guibg=NONE
    autocmd ColorScheme * hi LineNr                 guibg=NONE ctermbg=none
    autocmd ColorScheme * hi SignColumn             guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterAdd           guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterChange        guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterDelete        guibg=NONE ctermbg=none
    autocmd ColorScheme * hi GitGutterChangeDelete  guibg=NONE ctermbg=none
    autocmd ColorScheme * hi ALEErrorSign           guibg=NONE ctermbg=none
    autocmd ColorScheme * hi ALEWarningSign         guibg=NONE ctermbg=none
augroup END

" }}}
" Colorscheme {{{

"if LINUX()
  ""colorscheme alduin
"endif

" }}}

