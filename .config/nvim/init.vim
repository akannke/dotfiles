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
set foldmethod=indent
set foldlevel=100
set noequalalways
set number
set equalalways

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
nnoremap <silent> ( :<C-u>bprev<CR>
nnoremap <silent> ) :<C-u>bnext<CR>
" バッファを閉じる
nnoremap <silent> <A-b> :bd<CR>

" 一時ファイルを作成して開く、OpenTempfileコマンドを定義
command! Tempfile :edit `=tempname()`

" pythonのパスを指定
" venvでneovim用の仮想環境を作成して設定する
let s:python3_dir = $HOME . '/.vim/python3'
if !isdirectory(s:python3_dir)
  call system('python -m venv ' . s:python3_dir)
  " nvr, neovimをインストール
  call system('source ' . s:python3_dir . '/bin/activate && pip install neovim neovim-remote')
endif
let g:python3_host_prog = s:python3_dir . '/bin/python'

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
Plug 'jonathanfilip/vim-lucius'
Plug 'ulwlu/elly.vim'
Plug 'rakr/vim-two-firewatch'
Plug 'AlessandroYorba/Despacio'
Plug 'cocopon/iceberg.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'dense-analysis/ale'
Plug 'dstein64/vim-win' " windowのサイズを変えずにバッファのみ入れ替える
Plug 'rhysd/clever-f.vim'
Plug 'Yggdroot/indentLine'
Plug 'moll/vim-bbye'
Plug 'preservim/nerdtree'
" Plug 'github/copilot.vim'
" ============= colorschemes =========
Plug 'KeitaNakamura/neodark.vim'
call plug#end()
" ============= colorscheme =========
if has('termguicolors')
  set termguicolors
endif
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'medium'
colorscheme gruvbox-material

" ============= fzf ============

"" 後方に貼り付け
command! FzfPaste :call s:FzfPaste()
function! s:FzfPaste()
  let reg = execute(":reg")
  let regs = split(reg, "\n")
  call remove(regs, 0)
  call fzf#run({'source': regs, 'sink': funcref('s:write'), 'down': '25%'})
endfunction

func! s:write(s) abort
  execute ':norm ' . strcharpart(a:s,5,2) . 'p'
endfunc

" Setting fd as the default source for fzf
let $FZF_DEFAULT_COMMAND = 'fd --type f'

nnoremap [Fzf] <Nop>
nmap <Leader>f [Fzf]
nnoremap [Fzf]f :<C-u>Files<CR>
nnoremap [Fzf]: :<C-u>History:<CR>
nnoremap [Fzf]h :<C-u>History<CR>
nnoremap [Fzf]c :<C-u>Commands<CR>
nnoremap [Fzf]m :<C-u>Maps<CR>
nnoremap [Fzf]b :<C-u>Buffers<CR>
nnoremap [Fzf]j :<C-u>Buffers<CR>
nnoremap [Fzf]p :<C-u>FzfPaste<CR>
nnoremap [Fzf]s :<C-u>Snippets<CR>

" ============ vim-auto-save ===========
let g:auto_save_silent = 1
let g:auto_save_in_insert_mode = 0

" easy motion
" 大文字小文字を区別しない
let g:EasyMotion_smartcase = 1
" 1を1と!にマッチするようにする
let g:EasyMotion_use_smartsign_jp = 1
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-overwin-f)
nmap m <Plug>(easymotion-overwin-f2)


" ============ vim-quickrunの設定 ==============
let g:quickrun_no_default_key_mappings = 1
nmap <leader>n <Plug>(quickrun)
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'outputter/buffer/opener': '10new',
      \ 'outputter/buffer/into': 1,
      \ 'outputter/buffer/close_on_empty': 1,
      \ 'tempfile': '%{expand("%:p:h") . "/" . system("echo -n $(uuidgen)")}',
      \ }

" let g:quickrun_config.haskell = {
"       \ 'command' : 'runghc',
"       \ 'exec': ['%c %o %s'],
"       \ 'cmdopt': '-Wall'
"       \ }

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
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-tsserver',
      \ 'coc-explorer',
      \ 'coc-docker',
      \ 'coc-git',
      \ 'coc-go',
      \ 'coc-rust-analyzer',
      \ 'coc-json',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ 'coc-pyright',
      \ 'coc-snippets'
      \ ]

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
" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

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

nmap <silent> <Leader>j <Plug>(coc-diagnostic-next-error)
nmap <silent> <Leader>k <Plug>(coc-diagnostic-prev-error)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" less frequently used commands
nnoremap [Coc] <Nop>
nmap <Leader>i [Coc]
nnoremap [Coc]l :<C-u>CocList snippets<CR>
nnoremap [Coc]e :<C-u>CocCommand snippets.editSnippets<CR>

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
nmap <leader>a  <Plug>(coc-codeaction)
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
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ディレクトリツリーを表示
nmap <space>e :CocCommand explorer --sources=buffer+,file+<CR>
nmap <C-e> :CocCommand explorer --sources=buffer+,file+<CR>

" coc-pairsで改行時にカーソルを適切な位置に移動
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" coc-metalsの設定
nmap <Leader>m <Plug>(coc-metals-expand-decoration)

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
let g:airline#extensions#tabline#buffers_label = '' " 右上の文字
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " 同じファイル名の時にパスを表示
let g:airline#extensions#tabline#fnamemod = ':t'
" let g:airline#extensions#tabline#fnametruncate = 0
" let g:airline#extensions#tabline#buffer_min_count = 0
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#overflow_marker = '…'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''

" ================= coc-solidity ====================
set runtimepath^=~/coc-solidity/packages/coc-solidity

" ================= Ansible settings ====================
au BufRead,BufNewFile */ansible/*.yml set filetype=yaml.ansible

" ================= nvim-toggle-terminal ====================
nnoremap <silent> <Leader>t :ToggleTerminal<Enter>
" tnoremap <silent> <Leader>t <C-\><C-n>:ToggleTerminal<Enter>
let g:open_in_insert_mode = 0

" 括弧補完
" inoremap { {}<Left>
" inoremap " ""<Left>
" inoremap < <><Left>
" inoremap ( ()<left>
" ウィンドウを閉じずにバッファを閉じる
noremap <silent> <Leader>b :<C-u>Bdelete<CR>
inoremap <silent> <C-l> <ESC>f)i

" ==================== auto-pairs ====================
let g:AutoPairsMapCR = 0
let g:AutoPairsMultilineClose = 0

let g:ale_linters = {
      \ 'solidity': ['solhint'],
      \ }
" linterを指定したときのみaleを有効化する
let g:ale_linters_explicit = 1

" User Commands
command PathCopy let @g = expand('%')
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" ========== vim-win ==========
" swap buffer
" map <leader>wh <plug>WinWinsh<ESC>
" map <leader>wj <plug>WinWinsj<ESC>
" map <leader>wk <plug>WinWinsk<ESC>
" map <leader>wl <plug>WinWinsl<ESC>

" ========== nvr ==========
if has('nvim')
  let $GIT_EDITOR = 'nvr -cc split --remote-wait'
endif

" ==================== coc-git ====================
nmap [c <Plug>(coc-git-prevchunk)
nmap ]c <Plug>(coc-git-nextchunk)

" ==================== indentLine ====================
let g:indentLine_fileTypeExclude = ['markdown']

augroup gvim_command
  autocmd!
  " フォーカスが外れたらノーマルモードに戻る
  autocmd FocusLost * call feedkeys("\<esc>")
augroup END
