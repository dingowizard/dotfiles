" no compatibility mode
set nocp
set ruler
set cursorline
hi CursorLine cterm=NONE ctermbg=black
set hlsearch
set incsearch
set lazyredraw
set showmatch
syntax enable
set encoding=utf8
set ai
set si
set wrap
set lbr
set number
set showcmd
inoremap fd <Esc>

" change cursor shape depending on mode
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" set right cursor shape on entering vim
autocmd VimEnter * :normal :startinsert :stopinsert
