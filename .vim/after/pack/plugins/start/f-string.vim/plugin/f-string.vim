" すでにスクリプトをロードした場合は終了
" if exists('g:loaded_session')
  " finish
" endif
" let g:loaded_session = 1

" command はExコマンドを定義します
" 次の定義では :SessionList コマンドを実行すると call session#sessions() が実行されるようになります
" command! SessionList call session#sessions()

" -nargs でコマンドが受け取る引数の数を設定できます
" デフォルトは引数を受け取らないので、1つの変数を受け取れるように設定します
"
" <q-args> は引数を意味します
" command! -nargs=1 SessionCreate call session#create_session(<q-args>)
