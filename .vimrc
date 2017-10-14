syntax enable
set number
set expandtab
set shiftwidth=2
"set smartindent
set tabstop=2

filetype plugin indent on

autocmd Filetype php setlocal shiftwidth=4 tabstop=4

nmap <Leader>c :e $MYVIMRC<cr>

nmap <Leader>f :bn<cr>
nmap <Leader>d :bp<cr>
nmap <Leader>s :BD<cr>
nmap <Leader>t :NERDTreeToggle<cr>
set t_CO=256

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'qpkorr/vim-bufkill'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'rking/ag.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'acoustichero/goldenrod.vim'
Plugin 'tpope/vim-rails'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mattn/emmet-vim'
Plugin 'ntpeters/vim-better-whitespace'

call vundle#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set laststatus=2

set background=dark
colorscheme Tomorrow-Night

nmap <Leader>w :StripWhitespace<cr>
