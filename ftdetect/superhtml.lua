vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.shtml" },
    callback = function()
        vim.bo.filetype = "superhtml"
    end,
})
vim.filetype.add({ extension = {
    shtml = "superhtml",
} })
