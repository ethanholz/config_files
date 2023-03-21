local wezterm = require("wezterm")

return {
    font = wezterm.font("Jet Brains Mono Nerd Font"),
    font_size = 13.0,
    default_prog = { "/bin/zsh" },
    color_scheme = "carbonfox",
    xcursor_theme = "Pop",
    enable_tab_bar = false,
    window_padding = {
        left = 0,
        right = 0,
        bottom = 0
    }
}
