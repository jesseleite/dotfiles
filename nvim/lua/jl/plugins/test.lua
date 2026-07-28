--------------------------------------------------------------------------------
-- Vim Test: Run your tests at the speed of thought
--------------------------------------------------------------------------------

local helpers = {}

return {
  'vim-test/vim-test',
  keys = {
    { '<Leader>rs', ':w<CR>:TestSuite<CR>', desc = 'Test Suite' },
    { '<Leader>rf', ':TestFile<CR>', desc = 'Test File' },
    { '<Leader>rl', ':w<CR>:TestLast<CR>', desc = 'Test Last' },
    { '<Leader>rn', ':w<CR>:TestNearest<CR>', desc = 'Test Nearest' },
    { '<Leader>rv', ':w<CR>:TestVisit<CR>', desc = 'Test Visit' },
    { '<Leader>rx', function () helpers.swap_strategy() end, desc = 'Swap Test Strategy' },
  },
  init = function ()
    -- Global defaults, preferring `herdr` strategy when inside a herdr instance
    vim.g['test#strategy'] = vim.env.HERDR_ENV and 'herdr' or 'neovim'
    vim.g['test#preserve_screen'] = 0

    -- Find a pane labelled `vim-test` in the current herdr tab
    helpers.find_herdr_test_pane = function ()
      local ok, decoded = pcall(vim.json.decode, vim.fn.system({ 'herdr', 'pane', 'list' }))
      if not ok or type(decoded) ~= 'table' or not decoded.result then
        return nil
      end
      for _, pane in ipairs(decoded.result.panes) do
        if pane.tab_id == vim.env.HERDR_TAB_ID and pane.label == 'vim-test' then
          return pane.pane_id
        end
      end
    end

    -- Set up custom strategy to run in a `vim-test` pane in the current herdr tab,
    -- splitting one to the right if it doesn't exist yet
    vim.g['test#custom_strategies'] = {
      herdr = function (cmd)
        local pane = helpers.find_herdr_test_pane()
        if pane then
          vim.fn.system({ 'herdr', 'pane', 'send-keys', pane, 'ctrl+c' })
        else
          local out = vim.fn.system({
            'herdr', 'pane', 'split', vim.env.HERDR_PANE_ID,
            '--direction', 'right', '--no-focus', '--cwd', vim.fn.getcwd(),
          })
          local ok, decoded = pcall(vim.json.decode, out)
          if not ok or type(decoded) ~= 'table' or not decoded.result then
            vim.notify('Failed to split herdr vim-test pane', vim.log.levels.ERROR)
            return
          end
          pane = decoded.result.pane.pane_id
          vim.fn.system({ 'herdr', 'pane', 'rename', pane, 'vim-test' })
        end
        vim.fn.system({ 'herdr', 'pane', 'send-text', pane, 'clear && cd ' .. vim.fn.getcwd() .. ' && ' .. cmd })
        vim.fn.system({ 'herdr', 'pane', 'send-keys', pane, 'enter' })
      end,
    }

    -- Swap between `herdr` and `neovim` strategies when inside a herdr instance
    helpers.swap_strategy = function ()
      if not vim.env.HERDR_ENV then
        print('Test Strategy: neovim (no herdr instance to swap to)')
        return
      end
      if vim.g['test#strategy'] == 'herdr' then
        vim.g['test#strategy'] = 'neovim'
        print('Test Strategy: neovim')
      else
        vim.g['test#strategy'] = 'herdr'
        print('Test Strategy: herdr into [vim-test] pane')
      end
    end

    -- Make vitest runner work when running form top level of a phoenix app
    if vim.fn.filereadable('mix.exs') == 1 and vim.fn.filereadable('assets/vitest.config.js') == 1 then
      vim.g['test#javascript#runner'] = 'vitest'
      vim.g['test#javascript#vitest#executable'] = 'assets/node_modules/.bin/vitest'
    end
  end,
}
