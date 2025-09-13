--------------------------------------------------------------------------------
-- Mini.bracketed: Pairs of handy next/prev bracket mappings (ie. ]q, etc.)
--------------------------------------------------------------------------------

return {
  'nvim-mini/mini.bracketed',
  opts = {
    -- These were recently merged to Neovim, but not yet tagged.
    -- When these are tagged, I'll probably delete this plugin!
    -- See: https://github.com/neovim/neovim/pull/28525
    quickfix   = { suffix = 'q', options = {} },
    location   = { suffix = 'l', options = {} },
    buffer     = { suffix = 'b', options = {} },

    -- Already works in current Neovim version!
    -- But we'll leave enabled because ]D and [D (for first/last) also hasn't been tagged yet.
    diagnostic = { suffix = 'd', options = {} },

    -- Not interested in these, just disable them!
    comment    = { suffix = '', options = {} },
    conflict   = { suffix = '', options = {} },
    file       = { suffix = '', options = {} },
    indent     = { suffix = '', options = {} },
    jump       = { suffix = '', options = {} },
    oldfile    = { suffix = '', options = {} },
    treesitter = { suffix = '', options = {} },
    undo       = { suffix = '', options = {} },
    window     = { suffix = '', options = {} },
    yank       = { suffix = '', options = {} },
  },
}
