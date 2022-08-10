return {
  {
    name = 'Standard Dev',
    apps = {
      Ray = { '0,0 4x20', '0,0 5x20' },
      Brave = { '4,0 9x20', '5,0 12x20' },
      Kitty = { '13,0 17x20', '17,0 14x20' },
      Tower = { '13,0 17x20', '17,0 14x20' },
    },
    -- optional = {
    --   Tower,
    -- },
  },
  {
    name = 'No Ray',
    apps = {
      Brave = { '0,0 10x20' },
      Kitty = { '10,0 20x20' },
      Tower = { '10,0 20x20' },
    },
  },
  {
    name = 'Code Focused',
    apps = {
      Ray = { positions.sixths.left },
      Brave = { positions.fiveSixths.right },
      Kitty = { positions.fiveSixths.right },
      Tower = { positions.fiveSixths.right },
    }
  },
}
