vim.cmd.colorscheme("carbonfox")

local ok, lualine = pcall(require, "lualine")
if ok then
    local function hook()
        local harpoon_number = require("harpoon.mark").get_index_of(vim.fn.bufname())
        if harpoon_number then
            return "ﯠ " .. harpoon_number
        else
            return "ﯡ "
        end
    end

    local lualine_config = {
        sections = {
            lualine_y = {
                hook,
            }
        },
    }




    lualine.setup(lualine_config)

    vim.o.cmdheight = 0
end
