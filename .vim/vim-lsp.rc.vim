" vimrc
" vim-lspの各種オプション設定
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1

" デバッグ用設定
" let g:lsp_log_verbose = 1  " デバッグ用ログを出力
" let g:lsp_log_file = expand('~/.cache/tmp/vim-lsp.log')  " ログ出力のPATHを設定

" g:python3_host_prog にはpythonのパスを設定．
" 'cmd': { server_info -> [expand(s:pyls_path)] } というふうに使うらしい．
" let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'

augroup MyLSP
	autocmd!
	if (executable('pyls'))
		" pylsの起動定義
		augroup LspPython
			autocmd!
			autocmd User lsp_setup call lsp#register_server({
		  \ 'name': 'pyls',
		  \ 'cmd': { server_info -> ['pyls'] },
		  \ 'whitelist': ['python'],
		  \ 'workspace_config': {'pyls': {'plugins': {
		  \   'pycodestyle': {'enabled': v:true},
		  \   'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},}}}
		  \ })
			autocmd FileType python call s:configure_lsp()
		augroup END
	endif
augroup END

" 言語ごとにServerが実行されたらする設定を関数化
function! s:configure_lsp() abort
	setlocal omnifunc=lsp#complete   " オムニ補完を有効化
	" LSP用にマッピング
	nnoremap <buffer> <C-]> :<C-u>LspDefinition<CR>
	nnoremap <buffer> <Leader>d :<C-u>LspDefinition<CR>
	nnoremap <buffer> <Leader>D :<C-u>LspReferences<CR>
	nnoremap <buffer> <Leader>s :<C-u>LspDocumentSymbol<CR>
	nnoremap <buffer> <Leader>S :<C-u>LspWorkspaceSymbol<CR>
	nnoremap <buffer> <Leader>f :<C-u>LspDocumentFormat<CR>
	vnoremap <buffer> <Leader>F :LspDocumentRangeFormat<CR>
	nnoremap <buffer> <Leader>K :<C-u>LspHover<CR>
	nnoremap <buffer> <F1> :<C-u>LspImplementation<CR>
	nnoremap <buffer> <Leader>r :<C-u>LspRename<CR>

	" nnoremap <LocalLeader>a :<C-u>LspDocumentDiagnostics<CR>

endfunction
let g:lsp_diagnostics_enabled = 0  " 警告やエラーの表示はALEに任せるのでOFFにする
