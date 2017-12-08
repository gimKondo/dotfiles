
" プロダクト/テストファイルに対応するテスト/プロダクトファイルを開く
" src_path: ターゲットファイルパス
" ext_prod: プロダクトファイルの拡張子
" ext_test: テストファイルの拡張子
" test_dir: テストファイルのディレクトリ名
" suffix: テストファイル名のサフィックス
function! tpo#OpenTestOrProdunctFile(src_path, ext_prod, ext_test, test_dir, suffix)
  let l:ext_name = fnamemodify(a:src_path, ':e')
  if l:ext_name != a:ext_prod && l:ext_name != a:ext_test
    echo 'invalid target file'
    return
  endif

  " ファイル名が_testで終わるならテストファイルと判断
  let l:file_body = fnamemodify(a:src_path, ':t:r')
  let l:base_name_pos = match(l:file_body, '_' . a:suffix . '$')
  if l:base_name_pos == -1
    " プロダクトファイルなら対応するテストファイルを検索
    let l:base_name = l:file_body . '_' . a:suffix . '.' . a:ext_test
    let l:search_dir = '/**/' . a:test_dir . '/**'
  else
    " テストファイルなら対応するプロダクトファイルを検索
    " let l:base_name = l:file_body . '.' . a:ext_prod
    let l:base_name = strpart(l:file_body, 0, l:base_name_pos)
    let l:search_dir = '/**'
  endif

  let l:root_dir = s:GitRootDir(a:src_path)
  if l:root_dir == ''
    echo 'not found root directory'
    return
  endif

  let l:trg_path = findfile(l:base_name, l:root_dir . l:search_dir)
  if l:trg_path == ''
    echo 'not found file(' . l:base_name . ')'
  else
    execute("vs " . expand(l:trg_path))
  endif
endfunction

" gitのルートディレクトリを取得
function! s:GitRootDir(src)
  let l:src_dir = fnamemodify(a:src, ':h')
  let l:git_dir = finddir('.git', l:src_dir . ';')
  if l:git_dir == ''
    return ''
  else
    return l:git_dir . '/..'
  endif
endfunction
