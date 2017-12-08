if exists("elixir_test_prod") | finish | endif
let elixir_test_prod=1

" プロダクト/テストファイルに対応するテスト/プロダクトファイルを開くコマンド
command! ExTestProd :call tpo#OpenTestOrProdunctFile(expand("%:p"), 'ex', 'exs', 'test', 'test')
nnoremap <silent> <Plug>(elixir-test-prod-open) :ExTestProd<CR>
