local wezterm = require('wezterm')

local color_schemes = {
  miami_nights = {
    background = '#18181A',
    foreground = '#ffffff',
    cursor_bg = '#ffffff',
    cursor_border = '#00EC6E',
    ansi = { '#212121', '#FA2E62', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
    brights = { '#424242', '#FA2E62', '#00EC6E', '#FFE981', '#47BAC0', '#E4609B', '#47BAC0', '#ffffff' },
  },
  oxide = {
    background = '#070e11',
    foreground = '#ffffff',
    cursor_bg = '#ffffff',
    cursor_border = '#00d992',
    ansi = { '#1D2526', '#FA2E62', '#00d992', '#ffb717', '#00C1D9', '#fa5e86', '#90a7f8', '#ffffff' },
    brights = { '#3A4649', '#FA2E62', '#00d992', '#ffb717', '#00C1D9', '#fa5e86', '#90a7f8', '#ffffff' },
  }
}

local to_tmux_prefix = function (key)
  return wezterm.action.Multiple({
    wezterm.action.SendKey({ mods = 'CTRL', key = 'b' }),
    wezterm.action.SendKey({ key = key }),
  })
end

local config = {
  term = "wezterm",
  color_schemes = color_schemes,
  color_scheme = 'miami_nights',
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
    { mods = 'CTRL', key = '\\', action = wezterm.action.ShowDebugOverlay },
    { mods = 'CMD', key = 't', action = to_tmux_prefix('c') },
    { mods = 'CMD', key = 'k', action = to_tmux_prefix('s') },
    { mods = 'CMD', key = 'r', action = to_tmux_prefix('r') },
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

-- Important for screencasting...
wezterm.on('window-config-reloaded', function(window)
  if wezterm.gui.screens().active.name == '24GL600F' then
    local dpi = 92
    local font_size = 13

    -- For 1280x720 HiDPI specifically, which will have height of 1440
    if wezterm.gui.screens().active.height == 1440 then
      dpi = 144
      font_size = 15.5
    end

    window:set_config_overrides({
      dpi = dpi,
      font_size = font_size,
      line_height = 1.6,
      underline_position = -12,
      window_padding = {
        top = '0.7cell',
        bottom = '0.3cell',
      },
    })
  end
end)

return config
