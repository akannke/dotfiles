set encoding=utf-8
set tabstop=4
set expandtab
set shiftwidth=4
set belloff=all
set helplang=ja,en
set modifiable
set wildmode=longest:full,full
set autoindent
set smartindent
set hidden
set mouse=a
set nobackup
set nowritebackup

filetype plugin indent on


let mapleader = "\<Space>"

" x でヤンクしない
nnoremap x "_x
nnoremap j gj
nnoremap k gk
nnoremap L $
nnoremap 0 ^

" クリップボードからコピペ
noremap <A-y> "+y
noremap <A-p> "+p
tnoremap <A-p> <C-\><C-n>"+pa

" バッファの移動
nnoremap <silent> <Up> :<C-u>bprev<CR>
nnoremap <silent> <Down> :<C-u>bnext<CR>
nnoremap <silent> ( :<C-u>bprev<CR>
nnoremap <silent> ) :<C-u>bnext<CR>
" バッファを閉じる
nnoremap <silent> <A-b> :bd<CR>

" 一時ファイルを作成して開く、OpenTempfileコマンドを定義
command! Tempfile :edit `=tempname()`

" pythonのパスを指定
" let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog = system('echo -n $(which python3)')

" ===== vim spector =====
let g:vimspector_enable_mappings = 'HUMAN'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'pbogut/fzf-mru.vim'
Plug 'itchyny/vim-haskell-indent'
" Plug 'simeji/winresizer'
Plug 'thinca/vim-quickrun'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
" Plug 'Rykka/riv.vim'
Plug 'thesis/vim-solidity'
" Plug 'sirtaj/vim-openscad'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug '907th/vim-auto-save'
" Plug 'puremourning/vimspector'
Plug 'sheerun/vim-polyglot'
Plug 'sainnhe/gruvbox-material'
Plug 'vyperlang/vim-vyper'
Plug 'pearofducks/ansible-vim'
Plug 'tpope/vim-fugitive'
Plug 'caenrique/nvim-toggle-terminal'  " ターミナルを切り替える
Plug 'jiangmiao/auto-pairs'
call plug#end()
" ============= colorscheme =========
if has('termguicolors')
    set termguicolors
endif
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

" ============= fzf ============
nnoremap [Fzf] <Nop>
nmap <Leader>f [Fzf]
nnoremap [Fzf]f :<C-u>Files<CR>
nnoremap [Fzf]: :<C-u>History:<CR>
nnoremap [Fzf]h :<C-u>History<CR>
nnoremap [Fzf]c :<C-u>Commands<CR>
nnoremap [Fzf]m :<C-u>Maps<CR>
nnoremap [Fzf]b :<C-u>Buffers<CR>


" ============ vim-auto-save ===========
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 0

" easy motion
" 大文字小文字を区別しない
let g:EasyMotion_smartcase = 1
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-bd-jk)
map <Leader>k <Plug>(easymotion-overwin-line)

" ============ vim-quickrunの設定 ==============
let g:quickrun_no_default_key_mappings = 1
nmap <leader>n <Plug>(quickrun)
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': '10new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ }

let g:quickrun_config = {}
let g:quickrun_config.haskell = {
      \ 'command' : 'runghc',
      \ 'exec': ['%c %o %s'],
      \ 'cmdopt': '-Wall'
      \ }

tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Windowの切り替え. Alt+hjklで移動
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" 最後にアクティブだったWindowに戻る
tnoremap <A-o> <C-\><C-n><C-w>p
nnoremap <A-o> <C-w>p
" ウィンドウ拡大、縮小
noremap <A-.> <C-w>>
noremap <A-,> <C-w><
" 高さを増やす
noremap <A-;> <C-w>+

" ================= coc.nvim =========================

let g:coc_global_extensions = [
      \ 'coc-html', 'coc-css', 'coc-tsserver', 'coc-explorer', 'coc-docker', 'coc-git']

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,scala setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction
nmap <leader>a  <Plug>(coc-codeaction-line)
xmap <leader>a  <Plug>(coc-codeaction-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ディレクトリツリーを表示
nmap <space>e :CocCommand explorer --sources=buffer+,file+<CR>

" coc-pairsで改行時にカーソルを適切な位置に移動
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc-metalsの設定
nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

augroup SetFileType
  autocmd!
  autocmd BufRead,BufNewFile *.sbt,*.sc set filetype=scala
augroup end

" Make sure `"codeLens.enable": true` is set in your coc config
nnoremap <leader>l :<C-u>call CocActionAsync('codeLensAction')<CR>

" ================= vim-airline =========================
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#ignore_bufadd_pat = 'defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
let g:airline_powerline_fonts = 0

" ================= coc-solidity ====================
set runtimepath^=~/coc-solidity/packages/coc-solidity

" ================= Ansible settings ====================
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible

" ================= nvim-toggle-terminal ====================
nnoremap <silent> <M-t> :ToggleTerminal<Enter>
tnoremap <silent> <M-t> <C-\><C-n>:ToggleTerminal<Enter>
let g:open_in_insert_mode = 0

" 括弧補完
" inoremap { {}<Left>
" inoremap " ""<Left>
" inoremap < <><Left>
" inoremap ( ()<left>
" ウィンドウを閉じずにバッファを閉じる
noremap <silent> <Leader>b :bp<Bar>sp<Bar>bn<Bar>bd<CR>
inoremap <silent> <C-l> <ESC>f)i
