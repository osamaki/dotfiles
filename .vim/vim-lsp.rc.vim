" vimrc
" vim-lspの各種オプション設定
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
" ハイライト．できてるか？
let g:lsp_diagnostics_signs_enabled = 0
" highlight link LspWarningHighlight Error


" デバッグ用設定
" let g:lsp_log_verbose = 2  " デバッグ用ログを出力
" let g:lsp_log_file = expand('~/vim-lsp.log')  " ログ出力のPATHを設定
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')


" writeするとなぜかvimが固まる
augroup MyLSP
	autocmd!
	if (executable('pyls'))
		" pylsの起動定義
		augroup LspPython
			autocmd!
			
			let s:pyls_path = fnamemodify(g:python3_host_prog, ':h') . '/'. 'pyls'

			autocmd User lsp_setup call lsp#register_server({
		  \ 'name': 'pyls',
		  \ 'cmd': { server_info -> [expand(s:pyls_path)] },
		  \ 'whitelist': ['python'],
		  \ 'workspace_config': {
		  \   'pyls': {
		  \	    'configurationSources': ['flake8'],
		  \	    'plugins': {
		  \		  'flake8': {'enabled': v:true},
          \       'pyflakes': {'enabled': v:false},
          \       'pycodestyle': {'enabled': v:false},
          \       'yapf': {'enabled': v:true},
		  \       'jedi_definition': {'follow_imports': v:true, 'follow_builtin_imports': v:true},
		  \	    }
		  \   }
		  \	}})
			autocmd FileType python call s:configure_lsp()
		augroup END
	endif
augroup END


" 言語ごとにServerが実行されたらする設定を関数化
" Todo:
" 	rename to make it clear it is for python
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
	nnoremap <buffer> <Leader>a :<C-u>LspDocumentDiagnostics<CR>

	" signature helpを無効化
	let g:lsp_signature_help_enabled = 0
	" ソースコード見てこっちかと思ったが効かなかった
	" call lsp#ui#vim#signature_help#_disable()

    let g:lsp_format_sync_timeout = 1000

endfunction
" let g:lsp_diagnostics_enabled = 0  " diagnostics(警告やエラーの表示？)はALEに任せるのでOFFにする
" ALEのREADMEでは let g:ale_disable_lsp = 1 にしてALEの方を無効にするのを勧めている
" vim-lsp-ale という plugin では diagnostics は vim-slp で，エラーはALEで対処？している

" let g:lsp_document_highlight_enabled = 0  HelpSignatureを無効化できるかと思ったけどできなかった


" vim-slp-settingsを使っている場合，こんな感じで設定する
"	let g:lsp_settings = {
"  \  'pylsp-all': {
"  \    'workspace_config': {
"  \      'pylsp': {
"  \        'configurationSources': ['flake8'],
"  \      }
"  \    }
"  \  }
"  \}
