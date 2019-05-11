set encoding=utf-8
set tabstop=4
set shiftwidth=4
set belloff=all
set helplang=ja,en


call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': './install.sh'
    \ }

call plug#end()

" オムニ補完
inoremap <C-j> <C-x><C-o>

" x でヤンクしない
nnoremap x "_x
nnoremap j gj
nnoremap k gk

tnoremap <Esc> <C-\><C-n>



" syntax on
" filetype on
" filetype indent on
" filetype plugin on


let g:LanguageClient_serverCommands = {
	\ 'haskell': ['hie-wrapper'],
	\ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
