" Override color au {{{
augroup OverrideColor
    autocmd!
    autocmd ColorScheme * hi! link LineNr TabLine
    autocmd ColorScheme * hi! link ColorColumn CursorLine
    autocmd ColorScheme * hi! link CursorColumn CursorLine
    autocmd ColorScheme * hi! link VertSplit Folded
    autocmd ColorScheme * hi! link StatusLineNC User6
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
    autocmd ColorScheme * hi StatusLine gui=none cterm=none ctermbg=none guibg=none
    autocmd ColorScheme * hi Folded     gui=none cterm=none ctermbg=none guibg=none
    if exists('g:GtkGuiLoaded')
        autocmd ColorScheme * hi Statement  gui=none
        autocmd ColorScheme * hi Type  gui=none
    endif
    "autocmd ColorScheme * hi LineNr                 guibg=none ctermbg=none
    "autocmd ColorScheme * hi SignColumn             guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterAdd           guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterChange        guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterDelete        guibg=none ctermbg=none
    "autocmd ColorScheme * hi GitGutterChangeDelete  guibg=none ctermbg=none
    "autocmd ColorScheme * hi ALEErrorSign           guibg=none ctermbg=none
    "autocmd ColorScheme * hi ALEWarningSign         guibg=none ctermbg=none
augroup END

" }}}
" Colorscheme {{{

let g:alduin_Shout_Fire_Breath = 1
"if LINUX()
  ""colorscheme alduin
"endif

" }}}

