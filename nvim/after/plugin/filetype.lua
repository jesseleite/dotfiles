--------------------------------------------------------------------------------
-- Force Filetypes
--------------------------------------------------------------------------------

vim.filetype.add {
  extension = {
    h = 'c',
  },
  pattern = {
    ['.*.blade.php'] = 'php', -- Until we get proper blade parser
  },
}
