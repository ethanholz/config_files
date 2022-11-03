require("dap-go").setup()
require("dapui").setup()
vim.o.completeopt = "menuone,noinsert,noselect"
local lspkind = require("lspkind")
local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
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
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
    ghost_text = true,
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
local formatting_attach = function(client, bufnr)
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end
local go_formatting_attach = function(_, _)
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = {
    "pyright",
    "vimls",
    "ansiblels",
    "dockerls",
    "bashls",
    "solc",
    "eslint",
    "marksman",
    "gopls",
    "ccls",
    "golangci_lint_ls",
    "sumneko_lua",
}
for _, lsp in ipairs(servers) do
    -- Handles setup for only adding language servers for those that are installed
    local exec = lsp
    if exec == "dockerls" then
        exec = "docker-langserver"
    end
    if exec == "golangci_lint_ls" then
        exec = "golangci-lint"
    end
    if exec == "sumneko_lua" then
        exec = "lua-language-server"
    end
    local result = vim.api.nvim_exec([[echo executable("]] .. exec .. [[")]], true)
    if tonumber(result) ~= 0 then
        if lsp == "gopls" then
            nvim_lsp[lsp].setup({
                capabilities = capabilities,
                on_attach = go_formatting_attach,
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
            })
        elseif lsp == "golanci_lint_ls" then
            nvim_lsp[lsp].setup({
                capabilities = capabilities,
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
            })
        elseif lsp == "sumneko_lua" then
            nvim_lsp[lsp].setup({
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { "vim", "use", "beautiful", "awful" },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        hint = {
                            enable = true,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                capabilities = capabilities,
                on_attach = formatting_attach,
            })
        else
            nvim_lsp[lsp].setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    if lsp == "pyright" then
                        formatting_attach(client, bufnr)
                    end
                end,
            })
        end
    end
end

local rust_opts = {
    server = {
        on_attach = formatting_attach,
        ["rust-analyzer"] = {
            procMacro = {
                enable = false,
            },
        },
    },
}
require("rust-tools").setup(rust_opts)
require("trouble").setup({})

local formatting = require("null-ls").builtins.formatting
require("null-ls").setup({
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = formatting_attach,
    debug = true,
    sources = {
        formatting.stylua.with({
            args = {
                "--search-parent-directories",
                "--stdin-filepath",
                "$FILENAME",
                "--indent-type",
                "Spaces",
                "-",
            },
        }),
        formatting.rustfmt,
        formatting.black,
    },
})
