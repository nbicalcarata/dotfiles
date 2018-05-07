" Mappings {{{

let g:mapleader = ','

" To edit on tab :-tabedit %
" Toggle 'default' terminal
nnoremap <leader>ta :call ChooseTerm("terminal", 1)<CR>
" Start terminal in current pane
nnoremap <leader>tc :call ChooseTerm("term-pane", 0)<CR>

" edit file in current directory
"nnoremap <leader>e :e %

" create directory
"nnoremap <leader>m :!mkdir %

" Jump to previous edited buffer
nnoremap <BS> <C-^>

" Substitution on visual selection
xnoremap <leader>vs y:%s/<C-r>"//g<Left><Left>

" Find files
"nnoremap <leader>f :find *

" Find buffer
"nnoremap <leader>b :buffer *
nnoremap <leader>b :ls<CR>:b<Space>

" Copy to clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>y "+y
nnoremap <leader>yy "+yy

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Space to fold
"nnoremap <space> za

" Quick edit vimrc
nnoremap <leader>ev :e ~/dotfiles/nvimrc<cr>
nnoremap <leader>en :e ~/dotfiles/nvim/nplug.vim<cr>
nnoremap <leader>eg :e ~/dotfiles/nvim/general.vim<cr>
nnoremap <leader>ea :e ~/dotfiles/nvim/autocmd.vim<cr>
nnoremap <leader>es :e ~/dotfiles/nvim/statusline.vim<cr>
nnoremap <leader>ec :e ~/dotfiles/nvim/color.vim<cr>
nnoremap <leader>em :e ~/dotfiles/nvim/map.vim<cr>
nnoremap <leader>ep :e ~/dotfiles/nvim/plugins.vim<cr>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>
nnoremap <leader>sg :source ~/.config/nvim/ginit.vim<cr>

if WINDOWS()
  nnoremap <leader>ev :e ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>en :e ~\AppData\Local\nvim\nplug.vim<cr>
  nnoremap <leader>eg :e ~\AppData\Local\nvim\general.vim<cr>
  nnoremap <leader>ea :e ~\AppData\Local\nvim\autocmd.vim<cr>
  nnoremap <leader>es :e ~\AppData\Local\nvim\statusline.vim<cr>
  nnoremap <leader>ec :e ~\AppData\Local\nvim\color.vim<cr>
  nnoremap <leader>em :e ~\AppData\Local\nvim\map.vim<cr>
  nnoremap <leader>ep :e ~\AppData\Local\nvim\plugins.vim<cr>
  nnoremap <leader>sv :source ~\AppData\Local\nvim\init.vim<cr>
  nnoremap <leader>sg :source ~\AppData\Local\nvim\ginit.vim<cr>
endif

nnoremap <F1> <nop>
nnoremap Q <nop>

" Bind nohl
" Removes highlight of your last search
"noremap <C-n> :nohl<CR>
"vnoremap <C-n> :nohl<CR>
"inoremap <C-n> :nohl<CR>

" Resizing windows
nnoremap <C-up> <C-W>-
nnoremap <C-down> <C-W>+
nnoremap <C-right> 5<C-W><
nnoremap <C-left> 5<C-W>>

" Substitute
nnoremap <leader>s :%s///g<left><left><left>
vnoremap <leader>s :s///g<left><left><left>

" Select current line (no indentation)
nnoremap vv ^vg_

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

" Fullscreen mode for neovim-qt
map <silent> <F11> :call ToggleFullScreen()<CR>

"<leader>q to close buffer without closing the window
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle between absolute and relative line numbers
nnoremap <Leader>n :call NumberToggle()<cr>

" Toggle between invisible chars
nmap <leader>c :set list!<CR>

" Ag
"nnoremap <leader>a :Ag

" Move between splits
"nnoremap <C-H> <C-W><C-H>
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>

" Term move between splits
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
"tnoremap <C-w> <C-\><C-n><C-w>c

"set working directory to current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>td :tc %:p:h<CR>:pwd<CR>

" Save as sudo
"cmap w!! w !gksudo tee > /dev/null %

"Rename buffer
"nnoremap <leader>bn :keepalt file<space>
" }}}
