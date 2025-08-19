vim.opt_local.colorcolumn = "80"
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspAttach_Python", {}),
    callback = function(args)
        if not (args.data and args.data.client_id) then
            return
        end
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
            return
        end
        if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
        end
    end,
})
