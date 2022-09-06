return {
  {
    name = 'Standard Dev',
    cells = {
      { '0,0 4x20', '0,0 5x20' },
      { '4,0 9x20', '5,0 13x20' },
      { '13,0 17x20', '18,0 12x20' },
      { '21,2 8x16', '21,2 8x16' },
    },
    apps = {
      Ray = { cell = 1, open = true },
      Brave = { cell = 2, open = true },
      Kitty = { cell = 3, open = true },
      Tower = { cell = 3 },
      Slack = { cell = 4 },
    },
  },
  {
    name = 'No Ray',
    cells = {
      { '0,0 10x20' },
      { '10,0 20x20' },
    },
    apps = {
      Brave = { cell = 1, open = true },
      Kitty = { cell = 2, open = true },
      Tower = { cell = 2 },
    },
  },
  {
    name = 'Code Focused',
    cells = {
      { positions.sixths.left },
      { positions.fiveSixths.right },
    },
    apps = {
      Ray = { cell = 1, open = true },
      Brave = { cell = 2, open = true },
      Kitty = { cell = 2, open = true },
      Tower = { cell = 2 },
    },
  },
}
