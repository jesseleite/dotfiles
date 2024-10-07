--------------------------------------------------------------------------------
-- Mini.surround: Act on surrounding parentheses, quotes, tags, etc.
--------------------------------------------------------------------------------

-- Note: Trying this for a while as a replacement to tpope/vim-surround.
-- Still wish it had better support to preserve html attributes when
-- replacing html tag. His help doc mentions that tag handling
-- is regex-only for now. Maybe it's something we can PR?

return {
  'echasnovski/mini.surround',
  config = true,
}
