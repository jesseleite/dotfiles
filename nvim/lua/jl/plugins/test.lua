--------------------------------------------------------------------------------
-- Vim Test: Run your tests at the speed of thought
--------------------------------------------------------------------------------

local swap_strategy = function ()
  if vim.g['test#strategy'] == 'neovim' then
    vim.g['test#strategy'] = 'tslime'
    print('Test Strategy: tslime into [runner] session')
  else
    vim.g['test#strategy'] = 'neovim'
    print('Test Strategy: neovim')
  end
end

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
    { '<Leader>rx', swap_strategy, desc = 'Swap Test Strategy' },
  },
  init = function ()
    vim.g['test#preserve_screen'] = 0

    vim.g.tslime = {
      session = 'runner',
      window = '1',
      pane = '1',
    }

    if vim.fn.match(vim.fn.system('tmux ls | grep attached'), 'runner:') > 0 then
      vim.g['test#strategy'] = 'tslime'
    else
      vim.g['test#strategy'] = 'neovim'
    end

    vim.g['test#php#phpunit#executable'] = 'vendor/bin/phpunit'
  end,
}
