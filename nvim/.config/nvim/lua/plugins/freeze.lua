return {
    {
        "charm-and-friends/freeze.nvim",
        opts = {
            command = "freeze",
            open = true,
            output = function()
                return "./" .. os.date("%Y-%m-%d") .. "_freeze.png"
            end,
            theme = "rose-pine-moon",
        },
    },
}
