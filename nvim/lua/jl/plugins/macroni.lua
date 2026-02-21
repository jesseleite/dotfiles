--------------------------------------------------------------------------------
-- Macroni: Save your macros for future use, playback from keymap or Telescope
--------------------------------------------------------------------------------

return {
  'jesseleite/macroni.nvim',
  -- dev = true,
  lazy = false,
  opts = {
    macros = {
      duplicate_function = {
        desc = 'Duplicate current function',
        keymap = '<Leader><Leader>y',
        macro = 'vafygv<Esc>o<Esc>pzz^',
      },
      lua_keymap = {
        desc = 'Convert vimscript mapping to lua mapping',
        keymap = '<Leader><Leader>k',
        mode = 'v',
        macro = "Ivim.keymap.set('<Esc>la',<Space><Esc>ldwi'<Esc>f<Space>i',<Space>'<Esc>lxA')"
      },
      format_changelog = {
        desc = 'Format changelog from git log',
        macro = "^dwi-<Space><Esc>f(f#hhi.<Esc>llr[llyiwf)r]a(http://github.com/statamic/cms/issues/<Esc>pA<Space>by<Space>@",
      },
      blade_class = {
        desc = 'Convert html class to blade class',
        macro = "^/class<CR>ciw@class<Esc>lxlva\"sa?([<CR>])<CR>lci<Esc>sr\"\'i",
      },
      blade_class_split = {
        desc = 'Convert html class to blade classes and split',
        macro = "^/class<CR>ciw@class<Esc>lxlva\"sa?([<CR>])<CR>lci<Esc>sr\"'vi':s/\\%V\\s/',<Space>'/g<CR>:noh<CR>/class<CR>",
      },
      remove_bullet_points = {
        desc = 'Remove bullet points for basecamp, etc.',
        macro = ':%s/^\\s*-\\s//<CR>ggVGy',
      },
      -- to_php_shorthand_arrow_function = {},
      -- duplicate_php_method = {},
    },
  },
  config = function (_, opts)
    require('macroni').setup(opts)

    local blade_class = function ()
      vim.ui.input({ prompt = 'Would you like to split classes [y/n]? (default: y)' }, function (input)
        if input == 'n' then
          require('macroni').runSaved('convert_to_blade_class')
        else
          require('macroni').runSaved('convert_to_blade_class_and_split')
        end
      end)
    end

    -- local wat = function () require('macroni').run('i--<Space>\"wowzers<Space>how\'s<Space>thisss?<Esc>') end
    -- vim.keymap.set('n', '<Leader>k', wat, { remap = true, desc = 'Macro: Convert to blade class'})
  end,
}
