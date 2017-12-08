" Version: 1.0
" Author: gim_kondo
" Description:
" 	This is utility for using vimgrep.
" 	<Space>vc   : grep the word on cursor
" 	<Space>vC   : same to '<Space>vc', but this work just on files that has same extention
" 	:VimgrepExt : same to '<Space>vc', but this work just on files that has passe extention
" Create: 2013 Oct 25

nmap <Space>v [vimgrep]
" grep cursor word
nnoremap <silent> [vimgrep]c :vimgrep <cword> **/*<CR>
" grep cursor word just on files that have same exetention
nnoremap <silent> [vimgrep]C :call VimGrepOnCursorWithCurExt()<CR>
" grep cursor word just on files that have exetentions passed as parameters
command! -nargs=+ VimgrepExt call VimGrepOnCursorWithPassedExt(<q-args>)
" grep cursor word just on cpp files
command! VimgrepCpp call VimGrepOnCursorWithPassedExt('hpp', 'h', 'cpp', 'cc', 'inl')

" vimgrep just on files that have have same exetention
function! VimGrepOnCursorWithCurExt()
	silent execute ('vimgrep <cword> **/*.' . expand("%:e"))
endfunction

" vimgrep just on files that have exetention passed
function! VimGrepOnCursorWithPassedExt(...)
	let l:ext = ''
	let l:hasExt = 0
	for var in a:000
		if l:hasExt == 0
			let l:ext = '**/*.' . var
			let l:hasExt = 1
		else
			let l:ext = l:ext . ' **/*.' . var
		endif
	endfor
	" execute vim grep
	if l:hasExt == 0
		silent execute ('vimgrep <cword> **/*')
	else
		silent execute ('vimgrep <cword> ' . l:ext)
	endif
endfunction
