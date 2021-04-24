set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'lspconfig'.ccls.setup{on_attach=require'completion'.on_attach}
lua require'lspconfig'.jedi_language_server.setup{on_attach=require'completion'.on_attach}
