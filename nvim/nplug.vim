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

call plug#begin('~/.local/share/nvim/plugged')

" }}}

" General {{{
Plug 'justinmk/vim-dirvish'
Plug 'Shougo/denite.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'justinmk/vim-gtfo'
Plug 'mbbill/undotree'
Plug 'nbicalcarata/vim-zim'
Plug 'joanrivera/vim-zimwiki-syntax'
Plug 'wesQ3/vim-windowswap'
Plug 'pseewald/vim-anyfold'
Plug 'kevinkjt2000/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-grepper'
Plug 'mklabs/split-term.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'NovaDev94/vim-bufferline'
"Plug 'ShirajG/golden-ratio'
" }}}
" Colorschemes {{{

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

Plug 'Shougo/deoplete.nvim'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'carlitux/deoplete-ternjs', { 'do': 'sudo npm install -g tern' }

" }}}
" Syntax highlighting{{{

Plug 'sheerun/vim-polyglot'
Plug 'janko-m/vim-test'
Plug 'StanAngeloff/php.vim'
"Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue'

" }}}

" Plug end {{{

call plug#end()

" }}}
" }}}
