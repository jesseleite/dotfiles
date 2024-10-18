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
      convert_to_blade_class_directive = {
        macro = "^/class<CR>ciw@class<Esc>lxlva\"sa?([<CR>])<CR>lci<Esc>sr\"'vi':s/\\%V\\s/',<Space>'/g<CR>:noh<CR>/class<CR>",
        keymap = '<Leader><Leader><Leader>c', -- TODO: think of better mapping for this?
      },
      -- to_php_shorthand_arrow_function = {},
      -- duplicate_php_method = {},
    },
  },
}
