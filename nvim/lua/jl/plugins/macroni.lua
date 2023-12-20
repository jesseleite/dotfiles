--------------------------------------------------------------------------------
-- Macroni: Save your macros for future use, playback from keymap or Telescope
--------------------------------------------------------------------------------

return {
  'jesseleite/nvim-macroni',
  dev = true,
  lazy = false,
  opts = {
    macros = {
      to_lua_keymap = {
        desc = 'Convert vimscript mapping to lua mapping.',
        keymap = '<Leader><Leader>k',
        macro = "Ivim.keymap.set('<Esc>la',<Space><Esc>ldwi'<Esc>f<Space>i',<Space>'<Esc>lxA')<Esc>"
      },
      statamic_changelog = {
        macro = "^dwi-<Space><Esc>f(f#hhi.<Esc>llr[llyiwf)r]a(http://github.com/statamic/cms/issues/<Esc>pA<Space>by<Space>@<Esc>",
      },
      -- to_php_shorthand_arrow_function = {},
      -- duplicate_php_method = {},
    },
  },
}
