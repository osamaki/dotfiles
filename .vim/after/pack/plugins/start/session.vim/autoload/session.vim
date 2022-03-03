" 現在のパスからパスセパレータを取得しています．
" ここはそれほど重要ではないので，おまじないと考えておいてください．
" 詳しう知りたい方は :h fnamemodify() を参照してください．
let s:sep = fnamemodify('.', ':p')[-1:]

function! session#create_session(file) abort
	" SessionCreateの引数をfileで受け取れるようにします．
	" join()でセッションファイル保存先へのフルパスを生成し，mksession!でセッションファイルを作成します．
	execute 'mksession!' join([g:session_path, a:file], s:sep)

	" redrawで画面を再描画してメッセージを出力します．
	redraw
	echo 'session.vim: created'
endfunction
