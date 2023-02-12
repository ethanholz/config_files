require("dap-go").setup()
require("dapui").setup()
vim.o.completeopt = "menuone,noinsert,noselect"
local lspkind = require("lspkind")
local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
-- require("luasnip.loaders.from_vscode").lazy_load()
cmp.setup({
    formatting = {
        format = lspkind.cmp_format(),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end),
        ["<S-TAB>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "nvim_lsp_lua" },
        { name = "luasnip" },
        { name = "crates" },
        { name = "buffer" },
        { name = "path" },
    }),
    -- ghost_text = true,
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end


local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- A table of servers used for setting up LSP
local servers = {
    "ccls",
    "bashls",
    "marksman",
    "pyright",
    "solc",
    {
        "eslint",
        exec = "vscode-eslint-language-server"
    },
    {
        "tsserver",
        exec = "typescript-language-server"
    },
    {
        "astro",
        exec = "astro-ls"
    },
    {
        "sumneko_lua",
        exec = "lua-language-server",
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = "LuaJIT",
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global and `awesome`
                    globals = { "vim", "use", "beautiful", "awful" },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                hint = {
                    enable = true,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    { "vimls", exec = "vim-language-server" },
    { "vuels", exec = "vls" },
    { "salt_ls", exec = "salt_lsp_server" },
    { "dockerls", exec = "docker-langserver" },
    { "arduino_langauge_server", exec = "arduino-langauge-server" },
    {
        "golangci_lint_ls",
        exec = "golangci-lint-langserver",
        init_options = {
            command = {
                "golangci-lint",
                "run",
                "--enable",
                "gofumpt",
                "--enable",
                "golint",
                "--out-format",
                "json",
                "--issues-exit-code=1",
            },
        },
    },
    {
        "gopls",
        settings = {
            gopls = {
                gofumpt = true,
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                codelenses = { test = true },
            },
        },
    },
}

-- Only install servers that exist + use custom options
for _, server in ipairs(servers) do
    local exec = ""
    local lsp = ""
    local setup = { capabilities = capabilities }
    if type(server) == "table" then
        lsp = server[1]
        if server.enable ~= nil and server.continue then
            goto continue
        end
        if server.exec ~= nil then
            exec = server.exec
        else
            exec = lsp
        end
        if server.settings ~= nil then
            setup["settings"] = server.settings
        end
        if server.init_options ~= nil then
            setup["init_options"] = server.init_options
        end
    else
        lsp = server
        exec = server
    end

    local result = tonumber(vim.api.nvim_exec([[echo executable("]] .. exec .. [[")]], true))
    if result ~= 0 then
        nvim_lsp[lsp].setup(setup)
    end
    ::continue::
end

local rust_opts = {
    server = {
        capabilities = capabilities,
        ["rust-analyzer"] = {
            procMacro = {
                enable = false,
            },
        },
    },
}
require("rust-tools").setup(rust_opts)
require("trouble").setup({})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local helpers = require("null-ls.helpers")

null_ls.setup({
    -- you can reuse a shared lspconfig on_attach callback here
    debug = true,
    sources = {
        -- formatting.rustfmt,
        formatting.black,
        code_actions.gomodifytags
    },
})

-- Setup custom linter for salt with null-ls
local salt_lint = {
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    filetypes = { "sls" },
    generator = null_ls.generator({
        command = "salt-lint",
        args = { "--nocolor", "--json", "$FILENAME" },
        to_stdin = true,
        from_stderr = true,
        format = "json",
        check_exit_code = function(code, stderr)
            local success = code == 0
            if not success then
                print(stderr)
            end
            return success
        end,
        on_output = helpers.diagnostics.from_json({
            attributes = {
                row = "linenumber",
                code = "id",
                message = "message",
                severity = "severity",
            },
            severities = {
                LOW = helpers.diagnostics.severities.warning,
                HIGH = helpers.diagnostics.severities.error,
            },
        }),
    }),
}

null_ls.register(salt_lint)

-- vim.api.nvim_create_autocmd('DiagnosticChanged', {
--     pattern = { "*.go" },
--     callback = function(args)
--         local diagnostics = args.data.diagnostics
--         vim.pretty_print(vim.diagnostic.get()[1])
--     end,
-- })
