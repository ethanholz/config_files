-- " File: ~/.vim/ftdetect/github_workflows.vim
-- au BufRead,BufNewFile */.github/workflows/*.yml setlocal filetype=yaml.github
-- au BufRead,BufNewFile */.github/workflows/*.yaml setlocal filetype=yaml.github
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*/.github/workflows/*.yml", "*/.github/workflows/*.yaml" },
    callback = function()
        vim.bo.filetype = "yaml.github"
    end,
})
