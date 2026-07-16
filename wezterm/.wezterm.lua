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

local opencode_hunk_tabs = {}

config.keys = {
  { key = "d", mods = "CMD", action = wezterm.action_callback(function(_, pane)
    local tab_id = pane:tab():tab_id()

    local tool_panes = opencode_hunk_tabs[tab_id]

    if tool_panes then
      opencode_hunk_tabs[tab_id] = nil
      local cwd = tool_panes.opencode:get_current_working_dir()
      local shell_pane = tool_panes.opencode:split {
        direction = "Right",
        cwd = cwd and cwd.file_path or nil,
      }

      wezterm.run_child_process {
        wezterm.executable_dir .. "/wezterm",
        "cli",
        "kill-pane",
        "--pane-id",
        tostring(tool_panes.hunk_id),
      }
      wezterm.run_child_process {
        wezterm.executable_dir .. "/wezterm",
        "cli",
        "kill-pane",
        "--pane-id",
        tostring(tool_panes.opencode_id),
      }
      shell_pane:activate()
      return
    end

    local cwd = pane:get_current_working_dir()

    local hunk_pane = pane:split {
      direction = "Right",
      cwd = cwd and cwd.file_path or nil,
      args = { "zsh", "-ic", "exec hunk diff" },
    }

    pane:send_text("opencode\n")
    pane:activate()
    opencode_hunk_tabs[tab_id] = {
      opencode = pane,
      opencode_id = pane:pane_id(),
      hunk_id = hunk_pane:pane_id(),
    }
  end)},
  { key = "LeftArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "RightArrow", mods = "CMD|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
}

return config
