local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.g.mapleader = ","
vim.opt.runtimepath:prepend(lazypath)
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spelllang = "en"
-- Global options
vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.scrolloff = 8
vim.opt.splitright = true
local tab_value = 4
vim.opt.tabstop = tab_value
vim.opt.softtabstop = tab_value
vim.opt.shiftwidth = tab_value
vim.opt.expandtab = true

vim.opt.shell = "fish"
vim.opt.bg = "dark"
vim.opt.spell = false -- Enables treesitter comment spelling
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.filetype = "on"

-- Persistent undos
vim.opt.undofile = true
require("lazy").setup("plugins")
require("mappings")
require("lsp")

-- Treesitter Consistent Syntax Highlighting and indent
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "bash",
        "c",
        "dockerfile",
        "gitcommit",
        "go",
        "gomod",
        "lua",
        "python",
        "query",
        "rust",
        "toml",
        "yaml",
    },
    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true,
        extended_mode = true,
    },
    playground = {
        enable = true,
    },
    -- Potentially remove, this is not really in my roation yet
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
        },
    },
    sync_install = false,
    auto_install = false,
    ignore_install = {},
    modules = {},
})
vim.filetype.add({ extension = { mdx = "mdx", service = "systemd" } })
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("html", "superhtml")

require("treesitter-context").setup()

vim.api.nvim_create_autocmd({ "FileType" }, {
    group = vim.api.nvim_create_augroup("edit_text", { clear = true }),
    pattern = { "gitcommit", "markdown", "txt" },
    desc = "Enable spell checking and text wrapping for certain filetypes",
    callback = function()
        -- vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
vim.opt.spell = false

vim.diagnostic.config({
    update_in_insert = false,
    virtual_text = { current_line = true },
})
