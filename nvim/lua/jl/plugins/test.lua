--------------------------------------------------------------------------------
-- Vim Test: Run your tests at the speed of thought
--------------------------------------------------------------------------------

local helpers = {}

return {
  'vim-test/vim-test',
  dependencies = {
    'jgdavey/tslime.vim',
  },
  keys = {
    { '<Leader>rs', ':w<CR>:TestSuite<CR>', desc = 'Test Suite' },
    { '<Leader>rf', ':TestFile<CR>', desc = 'Test File' },
    { '<Leader>rl', ':w<CR>:TestLast<CR>', desc = 'Test Last' },
    { '<Leader>rn', ':w<CR>:TestNearest<CR>', desc = 'Test Nearest' },
    { '<Leader>rv', ':w<CR>:TestVisit<CR>', desc = 'Test Visit' },
    { '<Leader>rx', function () helpers.swap_strategy() end, desc = 'Swap Test Strategy' },
  },
  init = function ()
    -- Global defaults
    vim.g['test#strategy'] = 'neovim'
    vim.g['test#preserve_screen'] = 0

    -- Custom runner executables
    vim.g['test#php#phpunit#executable'] = 'vendor/bin/phpunit'

    -- Set up `tslime` strategy to run in a tmux session called `runner`
    vim.g.tslime = {
      session = 'runner',
      window = '1',
      pane = '1',
    }

    -- Set up custom transformation for `tslime` strategy to prepare shell for running tests
    vim.g['test#custom_transformations'] = {
      cd_and_scroll = function(cmd)
        vim.fn.system('tmux send-keys -t runner C-c')
        return 'cd ' .. vim.fn.getcwd() .. ' && ' .. cmd
      end
    }

    -- Swap between default `neovim` and `tslime` strategy
    helpers.swap_strategy = function (opts)
      opts = opts or {}
      if vim.g['test#strategy'] == 'neovim' then
        vim.g['test#strategy'] = 'tslime'
        vim.g['test#transformation'] = 'cd_and_scroll'
        if opts.silent ~= true then
          print('Test Strategy: tslime into [runner] session')
        end
      else
        vim.g['test#strategy'] = 'neovim'
        vim.g['test#transformation'] = nil
        if opts.silent ~= true then
          print('Test Strategy: neovim')
        end
      end
    end

    -- Automatically swap to tslime strategy if runner session is attached
    if vim.fn.match(vim.fn.system('tmux ls | grep attached'), 'runner:') >= 0 then
      helpers.swap_strategy({silent = true})
    end
  end,
}
