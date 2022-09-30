local helper = {}

function helper.is_wsl()
    local output = vim.fn.systemlist("uname -r")
    return not not string.find(output[1] or "", "WSL")
end

return helper
