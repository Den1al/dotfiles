local wezterm = require("wezterm")

local custom = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
custom.background = "#373A40"

return {
  color_schemes = {
    ["OLEDppuccin"] = custom,
  },
  color_scheme = "OLEDppuccin",
  enable_tab_bar = false,
  font_size = 16.0,
  font = wezterm.font("JetBrains Mono"),
  window_decorations = "RESIZE",
  keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
      key = "LeftArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
      key = "RightArrow",
      mods = "OPT",
      action = wezterm.action({ SendString = "\x1bf" }),
    },
  },
  mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
}
