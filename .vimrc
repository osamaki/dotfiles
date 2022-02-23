" pythonの実行パスの設定
" システムのデフォルトのパスが設定される
" let g:python3_host_prog = system("which python3")
"
" let g:python3_host_prog = system("pipenv --py")
"
" let g:python3_host_prog = "/home/ozaki/.local/share/virtualenvs/Moonshot-IhqM7bBh/bin/python"
" 
" できるけど起動が超遅くなる
if $PIPENV_ACTIVE
 	" let g:python3_host_prog = substitute(system("pipenv --venv"), "\n", "", "") . "/bin/python"
	let g:python3_host_prog = system("pipenv --py")
	" echo "in pipenv. path:" . g:python3_host_prog
else
	let g:python3_host_prog = system("which python3")
	" echo "not in pipenv. path:" . g:python3_host_prog
endif

"--------------------------
" 表示設定
"--------------------------
set number
set title
colorscheme darkblue
set background=dark
" 現在の行を強調表示
set cursorline
" ステータスラインを常に表示
set laststatus=2
set ruler
set showcmd
set autoindent
set smartindent
set showmatch
set matchtime=1
"対応するやつハイライトするペアに　追加
set matchpairs& matchpairs+=<:>
set noexpandtab
set tabstop=4
set shiftwidth=4
augroup fileTypeIndent
    autocmd!
    autocmd Filetype html,javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
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

nnoremap <silent><C-n> :NERDTreeToggle<CR>

" Leaderの割り当て変更
let mapleader = "\<Space>"
let maplocalleader = ","


" load matchit
source $VIMRUNTIME/macros/matchit.vim


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
" source ~/Repositories/dotfiles/.vim/vim-lsp.rc.vim


" jediの自動補完のキーを変更
let g:jedi#completions_command = "<C-N>"


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
" deinのhook_addに書いた
" se rtp+=~linuxbrew/.linuxbrew/opt/fzf
