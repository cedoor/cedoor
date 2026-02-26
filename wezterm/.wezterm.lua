local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("FiraCode Nerd Font", { weight = "Regular" })
config.font_size = 14.0

-- Transparent glassy look
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Gruvbox Dark is a classic, warm theme
config.color_scheme = 'Gruvbox dark, pale (base16)'

-- Flat, simple tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

-- Padding and cursor style
config.window_padding = {
  left = 12,
  right = 12,
  top = 8,
  bottom = 8,
}
config.default_cursor_style = "BlinkingBar"

return config
