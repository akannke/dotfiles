set encoding=utf-8
set tabstop=4
set belloff=all
set helplang=ja,en


call plug#begin('~/.vim/plugged')
Plug 'vim-ruby/vim-ruby'
Plug 'vim-jp/vimdoc-ja'
Plug 'itchyny/lightline.vim'

call plug#end()

" オムニ補完
inoremap <C-j> <C-x><C-o>

" x でヤンクしない
nnoremap x "_x

tnoremap <Esc> <C-\><C-n>



" syntax on
" filetype on
" filetype indent on
" filetype plugin on





