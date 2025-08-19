return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                terraform = { "tofu_fmt" },
                astro = { "biome" },
                svelte = { "biome" },
                typescript = { "biome" },
                javascript = { "biome" },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
    },
}
