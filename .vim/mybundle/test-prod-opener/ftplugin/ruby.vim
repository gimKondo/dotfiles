if exists("ruby_spec_prod") | finish | endif
let ruby_spec_prod=1

" プロダクト/specファイルに対応するspec/プロダクトファイルを開くコマンド
command! RubySpecProd :call tpo#OpenTestOrProdunctFile(expand("%:p"), 'rb', 'rb', 'spec', 'spec')
nnoremap <silent> <Plug>(ruby-spec-prod-open) :RubySpecProd<CR>
