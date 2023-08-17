local wezterm = require('wezterm')

local color_schemes = {
  ['Miami Nights'] = {
    background = '#18181A',
    foreground = '#ffffff',
    cursor_bg = '#ffffff',
    cursor_border = '#00EC6E',
    ansi = { '#212121', '#ff0038', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
    brights = { '#424242', '#ff0038', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
  }
}

local config = {
  term = "wezterm",
  color_schemes = color_schemes,
  color_scheme = 'Miami Nights',
  font = wezterm.font('JetBrains Mono'),
  font_size = 16.5,
  line_height = 1.6,
  underline_position = -7,
  window_padding = {
    left = '1.5cell',
    right = '1.5cell',
    top = '0.4cell',
    bottom = '0.4cell',
  },
  window_decorations = 'RESIZE',
  window_close_confirmation = 'NeverPrompt',
  enable_tab_bar = false,
  adjust_window_size_when_changing_font_size = false,
  keys = {
    { key = 't', mods = 'SUPER', action = wezterm.action.Nop }
  },
  front_end = 'WebGpu', -- Temp: This is new default in nightly, can remove later!
}

-- This doesn't work well on a dual screen setup, and is hopefully a temporary solution to the font rendering oddities
-- shown in https://github.com/wez/wezterm/issues/4096. Ideally I'll switch to using `dpi_by_screen` at some point,
-- but for now 11pt @ 109dpi seems to be the most stable for font rendering on my 38" ultrawide LG monitor here.
wezterm.on('window-config-reloaded', function(window)
  if wezterm.gui.screens().active.name == 'LG HDR WQHD' then
    window:set_config_overrides({
      dpi = 109,
      font_size = 11,
    })
  end
end)

return config
