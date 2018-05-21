" Plug {{{

" Setup directory {{{

call plug#begin('~/.local/share/nvim/plugged')

" }}}

" General {{{
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
Plug 'romainl/vim-cool'
Plug 'scrooloose/nerdtree'
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
"Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
"Plug 'Yggdroot/indentLine'
"Plug 'NovaDev94/vim-bufferline'
Plug 'ShirajG/golden-ratio'
"Plug 'yuttie/comfortable-motion.vim'
" }}}
" Colorschemes {{{
"Plug 'fenetikm/falcon'
"Plug 'ayu-theme/ayu-vim'
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

" }}}

" Plug end {{{

call plug#end()

" }}}
" }}}
