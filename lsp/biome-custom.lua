---@brief
--- https://biomejs.dev
---
--- Toolchain of the web. [Successor of Rome](https://biomejs.dev/blog/annoucing-biome).
---
--- ```sh
--- npm install [-g] @biomejs/biome
--- ```

return {
    cmd = function(dispatchers, config)
        local util = require("lspconfig.util")
        local cwd = vim.fn.getcwd()
        local root_files = { "biome.json", "biome.jsonc" }
        root_files = util.insert_package_json(root_files, "biome", cwd)
        local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = cwd, upward = true })[1])
        local local_cmd = root_dir .. "/node_modules/.bin/biome"
        return vim.lsp.rpc.start({ local_cmd, "lsp-proxy" }, dispatchers)
    end,
    filetypes = {
        "astro",
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
    },
    workspace_required = true,
    root_dir = function(_, on_dir)
        local util = require("lspconfig.util")
        -- To support monorepos, biome recommends starting the search for the root from cwd
        -- https://biomejs.dev/guides/big-projects/#use-multiple-configuration-files
        local cwd = vim.fn.getcwd()
        local root_files = { "biome.json", "biome.jsonc" }
        root_files = util.insert_package_json(root_files, "biome", cwd)
        local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = cwd, upward = true })[1])
        on_dir(root_dir)
    end,
}
