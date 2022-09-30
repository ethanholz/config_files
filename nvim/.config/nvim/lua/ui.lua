-- vim.cmd("colorscheme nightfox")
-- Only availble on latest nvim nightly at this time
vim.cmd.colorscheme("carbonfox")
-- vim.cmd.colorscheme("oxocarbon")
local palettes = require("nightfox.palette").load("carbonfox")
require("better-comment").Setup({
    tags = {
        {
            name = "TODO",
            fg = palettes.white["bright"],
            bg = palettes.blue["dim"],
            bold = true,
            virtal_text = "",
        },
        {
            name = "FIX",
            fg = palettes.white["bright"],
            bg = palettes.red["dim"],
            bold = true,
            virtual_text = "",
        },
        {
            name = "WARNING",
            fg = "#FFA500",
            bg = "",
            bold = false,
        },
        {
            name = "!",
            fg = palettes.red["bright"],
            bg = "",
            bold = true,
            virtual_text = "",
        },
    },
})

require("indent_blankline").setup({
    show_end_of_line = true,
    buftype_exclude = { "help", "terminal" },
    filetype_exclude = { "markdown" },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("make")

local function hook()
    local harpoon_number = require("harpoon.mark").get_index_of(vim.fn.bufname())
    if harpoon_number then
        return "ﯠ " .. harpoon_number
    else
        return "ﯡ "
    end
end

require("lualine").setup({
    sections = {
        lualine_y = {
            hook,
        },
    },
})
-- Used to enable nicer diagnostic lines
-- vim.diagnostic.config({
-- 	virtual_text = false,
-- })
