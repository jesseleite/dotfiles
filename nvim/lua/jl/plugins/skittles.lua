--------------------------------------------------------------------------------
-- Rainbow Trails: Taste the rainbow!
--------------------------------------------------------------------------------

return {
  'sedm0784/vim-rainbow-trails',
  keys = {
    { '<Leader><Leader>r', ':RainbowTrailsNormalMode<CR>' },
    { '<Leader><Leader>R', ':RainbowTrailsEnterpriseMode<CR>' },
    { '<Leader><Leader>.', ':RainbowTrails!<CR>' }, -- Like my <Leader>. to clear highlights mapping
  },
  config = function ()
    local normal_mode = function ()
      vim.cmd([[
        highlight clear RainbowRed
        highlight clear RainbowOrange
        highlight clear RainbowYellow
        highlight clear RainbowGreen
        highlight clear RainbowBlue
        highlight clear RainbowIndigo
        highlight clear RainbowViolet
      ]])

      vim.cmd.RainbowTrails()
    end

    local enterprise_mode = function ()
      vim.cmd([[
        highlight RainbowRed guibg=#BDBDBD ctermbg=244
        highlight RainbowOrange guibg=#9D9D9D ctermbg=242
        highlight RainbowYellow guibg=#808080 ctermbg=240
        highlight RainbowGreen guibg=#6c6c6c ctermbg=238
        highlight RainbowBlue guibg=#585858 ctermbg=236
        highlight RainbowIndigo guibg=#444444 ctermbg=234
        highlight RainbowViolet guibg=#303030 ctermbg=232
      ]])

      vim.cmd.RainbowTrails()
    end

    vim.api.nvim_create_user_command('RainbowTrailsNormalMode', normal_mode, {})
    vim.api.nvim_create_user_command('RainbowTrailsEnterpriseMode', enterprise_mode, {})
  end,
}
