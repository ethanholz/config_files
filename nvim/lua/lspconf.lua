vim.o.completeopt = "menuone,noinsert,noselect"
require'lspconfig'.ccls.setup {on_attach = require'completion'.on_attach}
-- require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.jedi_language_server.setup {}

require'trouble'.setup {}
require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 800,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true
    }
}

