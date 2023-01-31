local ok, lualine = pcall(require, "lualine")
if ok then
    local ho, harpoon_mark = pcall(require, "harpoon.mark")
    local lualine_config = {}
    if ho then
        local function hook()
            local harpoon_number = harpoon_mark.get_index_of(vim.fn.bufname())
            if harpoon_number then
                return "ﯠ " .. harpoon_number
            else
                return "ﯡ "
            end
        end

        lualine_config["sections"] = {
            lualine_y = {
                hook
            }
        }

        -- local lualine_config = {
        --     sections = {
        --         lualine_y = {
        --             hook,
        --         },
        --     },
        -- }
    end

    lualine.setup(lualine_config)

    vim.opt.cmdheight = 0
    vim.opt.laststatus = 3
end
