--------------------------------------------------------------------------------
-- Force Filetypes
--------------------------------------------------------------------------------

local force_filetype = vim.api.nvim_create_augroup('force_filetype', { clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.blade.php' },
  group = force_filetype,
  callback = function ()
    vim.bo.filetype = 'php'
  end,
})

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.keymap' },
  group = force_filetype,
  callback = function ()
    vim.bo.filetype = 'devicetree'
  end,
})

-- TODO: Teej just has this in his config, but it seems hit and miss whether it works? Why?
-- vim.filetype.add {
--   extension = {
--     h = 'c',
--   },
--   pattern = {
--     ['.*.blade.php'] = 'php', -- Until we get proper blade parser
--   },
-- }
