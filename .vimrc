" pythonの実行パスの設定
" if $PIPENV_ACTIVE
  " カレントディレクトリに応じて取得しようとするので別のパスの仮想環境にいるとうまく動かない
  " 起動が超遅くなる
  " let g:python3_host_prog = system("pipenv --py")
" else
  " システムのデフォルトのパスが設定される
  " 起動が超遅くなる
  " let g:python3_host_prog = system("which python3")
" endif
"
" let g:python3_host_prog = "/home/ozaki/.local/share/virtualenvs/Moonshot-IhqM7bBh/bin/python"

" let g:python3_host_prog = $PYTHON3_HOST_PROG

if exists("$VIRTUAL_ENV")
  let g:python3_host_prog = $VIRTUAL_ENV . "/bin/python"
  let s:python_version = system('python --version | grep -oE "\d.\d+[^.]"')[:-2]
  let $PYTHONPATH = $VIRTUAL_ENV . "/lib/python" . s:python_version . "/site-packages/:" . $PYTHONPATH
endif


"dein Scripts-----------------------------
" dein.vim settings {{{
" install dir {{{
if has('nvim')
  let s:dein_dir = expand('~/.cache/dein/nvim')
else
  let s:dein_dir = expand('~/.cache/dein/vim')
endif

let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" }}}

" dein installation check {{{
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif

  execute 'set runtimepath^=' . s:dein_repo_dir
endif
" }}}

" begin settings {{{
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " .toml file
  if has('nvim')
    let s:rc_dir = expand('~/.nvim')
  else
    let s:rc_dir = expand('~/.vim')
  endif

  if !isdirectory(s:rc_dir)
    call mkdir(s:rc_dir, 'p')
  endif

  let s:toml = s:rc_dir . '/dein.toml'
  let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'


  " read toml and cache
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
" }}}
"End dein Scripts-------------------------


" lspの設定ファイル実行
source ~/Repositories/dotfiles/.vim/vim-lsp.rc.vim


" jediの自動補完のキーを変更
let g:jedi#completions_command = "<C-N>"


"--------------------------
" 表示設定
"--------------------------
set number
set title
colorscheme gruvbox
set background=dark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
" 現在の行を強調表示
set cursorline
" ステータスラインを常に表示
set laststatus=2
" カーソルの前後何行を画面内に確保するか
set scrolloff=5
set ruler
set showcmd
set autoindent
set smartindent
set showmatch
set matchtime=1
"対応するやつハイライトするペアに　追加
set matchpairs& matchpairs+=<:>
set noexpandtab
" タブを見た目上何文字文に展開するか？
set tabstop=4
" vimが挿入するインデントの見た目上の幅？
set shiftwidth=4
" タブを '>...'、末尾のスペースを '_' で表示
set listchars=tab:>.,trail:_
set list
retab!
syntax on

"--------------------------
" 検索
"--------------------------
set hlsearch
set incsearch

" バッファを切り替える時にいちいち保存しなくて良くなる
set hidden
set noautochdir
set wildmenu
if !has('nvim')
  set clipboard=unnamed,autoselect
endif
set backspace=indent,eol,start
set fileencodings=utf-8,cp932
" clipboardから貼るときに邪魔になるautoindentなどを無効化
set pastetoggle=<f5>
"esc-何々　の待ち時間（ms）
set ttimeoutlen=1
"折りたたみの情報の保存先？
set viewdir=~/.vim/view
".swpの保存先
set directory=~/tmp
"~の保存先
set backupdir=~/tmp
"undoの保存
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif

" キーマッピング
" ノーマルモードでひらがなで入力してもインサートモードに入れる
nnoremap あ a
nnoremap い i
" Emacs Move
imap <C-a>  <Home>
imap <C-e>  <End>


nnoremap <silent><C-n> :NERDTreeToggle<CR>

" Leaderの割り当て変更
let mapleader = "\<Space>"
let maplocalleader = ","


" load matchit
source $VIMRUNTIME/macros/matchit.vim


"autocmdの多重読み込み防止？
augroup vimrc
  autocmd!
augroup END

"折りたたみ関連
au BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
au BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
"jsonの折りたたみ設定 なんかできない
"au FileType json setlocal foldmethod=indent foldlevel=1

".vimrcを保存するとリロード
au BufWritePost ~/.vimrc source ~/.vimrc

"escでインサート抜けると
if has('mac')
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
endif

" templateの保存先
let g:sonictemplate_vim_template_dir = ['~/.vim/template']

" fzf
nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>h :History<CR>


let g:toggle_window_size = 0
function! ToggleWindowSize()
  if g:toggle_window_size == 1
    exec "normal \<C-w>="
    let g:toggle_window_size = 0
  else
    :resize
    :vertical resize
    let g:toggle_window_size = 1
  endif
endfunction
nnoremap M :call ToggleWindowSize()<CR>


autocmd QuickFixCmdPost *grep* cwindow


let g:previm_open_cmd = 'open -a "Google Chrome"'
