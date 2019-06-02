set encoding=utf-8
set tabstop=4
set shiftwidth=4
set belloff=all
set helplang=ja,en
set hidden


call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go'
Plug 'autozimu/LanguageClient-neovim', {
			\ 'branch': 'next',
			\ 'do': './install.sh'
			\ }
Plug 'junegunn/fzf'
Plug 'itchyny/vim-haskell-indent'
Plug 'simeji/winresizer'
Plug 'thinca/vim-quickrun'

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
call plug#end()

" オムニ補完
inoremap <C-j> <C-x><C-o>

" x でヤンクしない
nnoremap x "_x
nnoremap j gj
nnoremap k gk
nnoremap L $

let g:quickrun_config = {
			\ "_" : {
			\ "outputter/buffer/split" : ':rightbelow 8sp'
			\ }
			\}

tnoremap <Esc> <C-\><C-n>

filetype plugin indent on

let g:LanguageClient_serverCommands = {
			\ 'haskell': ['hie-wrapper', '-d', '-l', '/tmp/hie.log'],
			\ }

let mapleader = "\<Space>"

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>lk :call LanguageClient#textDocument_hover()<CR>
map <Leader>lg :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>lb :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>

" python-language-server用の設定
" デバッグ用設定
let g:lsp_log_verbose = 1  " デバッグ用ログを出力
let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定

" 言語用Serverの設定
augroup MyLsp
	autocmd!
	" pip install python-language-server
	if executable('pyls')
		" Python用の設定を記載
		" workspace_configで以下の設定を記載
		" - pycodestyleの設定はALEと重複するので無効にする
		" - jediの定義ジャンプで一部無効になっている設定を有効化
		autocmd User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': { server_info -> ['pyls'] },
					\ 'whitelist': ['python'],
					\ 'workspace_config': {'pyls': {'plugins': {
					\   'pycodestyle': {'enabled': v:false},
					\   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
					\})
		autocmd FileType python call s:configure_lsp()
	endif
augroup END
" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
	setlocal omnifunc=lsp#complete   " オムニ補完を有効化
	" LSP用にマッピング
	nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
	nnoremap <buffer> gd :<C-u>LspDefinition<CR>
	nnoremap <buffer> gD :<C-u>LspReferences<CR>
	nnoremap <buffer> gs :<C-u>LspDocumentSymbol<CR>
	nnoremap <buffer> gS :<C-u>LspWorkspaceSymbol<CR>
	nnoremap <buffer> gQ :<C-u>LspDocumentFormat<CR>
	vnoremap <buffer> gQ :LspDocumentRangeFormat<CR>
	nnoremap <buffer> K :<C-u>LspHover<CR>
	nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
	nnoremap <buffer> <F2> :<C-u>LspRename<CR>
endfunction
let g:lsp_diagnostics_enabled = 0  " 警告やエラーの表示はALEに任せるのでOFFにする

