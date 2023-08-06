local wezterm = require('wezterm')

local color_schemes = {
  ['Miami Nights'] = {
    background = '#18181A',
    foreground = '#ffffff',
    cursor_bg = '#ffffff',
    ansi = { '#212121', '#ff0038', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
    brights = { '#424242', '#ff0038', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
  }
}

return {
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
