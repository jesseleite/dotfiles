--------------------------------------------------------------------------------
-- Force Filetypes
--------------------------------------------------------------------------------
-- For file extensions that don't have proper treesitter parsers yet.
-- Maybe there's a better way to do this?

local force_filetype = vim.api.nvim_create_augroup('force_filetype', { clear = true })

-- vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
--   pattern = { '*.blade.php' },
--   group = force_filetype,
--   callback = function ()
--     vim.bo.filetype = 'html'
--   end,
-- })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
  pattern = { '*.keymap' },
  group = force_filetype,
  callback = function ()
    vim.bo.filetype = 'devicetree'
  end,
})
