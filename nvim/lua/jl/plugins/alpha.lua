--------------------------------------------------------------------------------
-- Alpha: A fast and fully programmable start screen greeter!
-------------------------------a-------------------------------------------------

return {
  'goolord/alpha-nvim',
  dependencies = {
    'echasnovski/mini.icons',
  },
  lazy = false,
  keys = {
    { 'i', ':enew<CR>i', ft = 'alpha', silent = true },
    { 'a', ':enew<CR>a', ft = 'alpha', silent = true },
    { '<Esc>', ':bd<CR>', ft = 'alpha', silent = true },
    { 'q', ':bd<CR>', ft = 'alpha', silent = true },
    { '<C-c>', ':bd<CR>', ft = 'alpha', silent = true },
    { '<Leader>c', ':bd<CR>', ft = 'alpha', silent = true },
    { '<Leader>v', ':bd<CR>:vsplit<CR>', ft = 'alpha', silent = true },
    { ':', ':bd<CR>:', ft = 'alpha' },
  },
  config = function ()
    local alpha = require('alpha')
    local theme = require('alpha.themes.dashboard')
    local Group = require('colorbuddy').Group
    local colors = require('colorbuddy').colors
    local icons = require('mini.icons')

    Group.new('AlphaPrimary', colors.primary)
    Group.new('AlphaSecondary', colors.secondary)
    Group.new('AlphaNormal', colors.noir_0)

    -- Manually set this total height based on number of rendered lines configured!
    local total_height = 28

    local button_spacing = 1
    local version_spacing = 0

    local pad = function (height)
      return math.ceil((vim.fn.winheight(0) - height) / 2)
    end

    if (pad(total_height) < 3) then
      total_height = total_height - 5
      button_spacing = 0
      version_spacing = 1
    end

    local iuse = {
      type = 'text',
      val = 'I USE',
      opts = {
        position = 'center',
        hl = 'AlphaSecondary',
      },
    }

    local header = {
      type = 'text',
      val = {
        [[ ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓    ▄▄▄▄   ▄▄▄█████▓ █     █░]],
        [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒   ▓█████▄ ▓  ██▒ ▓▒▓█░ █ ░█░]],
        [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░   ▒██▒ ▄██▒ ▓██░ ▒░▒█░ █ ░█]],
        [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██    ▒██░█▀  ░ ▓██▓ ░ ░█░ █ ░█]],
        [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒   ░▓█  ▀█▓  ▒██▒ ░ ░░██▒██▓]],
        [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░   ░▒▓███▀▒  ▒ ░░   ░ ▓░▒ ▒]],
        [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░   ▒░▒   ░     ░      ▒ ░ ░]],
        [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░       ░    ░   ░        ░   ░]],
        [[          ░    ░  ░    ░ ░        ░   ░         ░       ░                   ░]],
        [[                                 ░                           ░]],
      },
      opts = {
        position = 'center',
        hl = 'AlphaPrimary',
      },
    }

    local buttons = {
      type = 'group',
      val = {
        theme.button('n', '  New File', '<cmd>ene <CR>'),
        theme.button('<Leader>f', '󰈞  Git Files'),
        theme.button('<Leader>F', '󰈞  All Files'),
        theme.button('<Leader>h', '  Project History'),
        theme.button('<Leader>H', '  All History'),
        theme.button('<Leader>m', icons.get('filetype', 'diff')..'  Git Status'),
        theme.button('<Leader>e', icons.get('default', 'directory')..'  Explore Directory'),
        -- theme.button('<Leader>', '  Open last session'), -- Could be cool!
      },
      opts = {
        spacing = button_spacing,
      },
    }

    local v = vim.version()

    local version = {
      type = 'text',
      val = 'NVIM v' .. v.major .. '.' .. v.minor .. '.' .. v.patch,
      opts = {
        position = 'center',
        hl = 'AlphaSecondary',
      },
    }

    theme.config = {
      layout = {
        { type = 'padding', val = pad(total_height) },
        iuse,
        { type = 'padding', val = 1 },
        header,
        { type = 'padding', val = 1 },
        buttons,
        { type = 'padding', val = version_spacing },
        version,
      },
    }

    alpha.setup(theme.config)
  end,
}
