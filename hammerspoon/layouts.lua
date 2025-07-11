return {
  {
    name = 'Standard Dev',
    cells = {
      { '0,0 7x20', '0,0 7x20', '0,0 7x20' },
      { '7,0 22x20', '7,0 30x20', '7,0 16x20' },
      { '29,0 31x20', '37,0 23x20', '23,0 37x20' },
      { '42,2 16x16', '42,2 16x16', '42,2 16x16' },
      { '30,3 20x14', '39,3 16x14', '39,3 16x14' },
    },
    apps = {
      Ray = { cell = 1, open = true },
      Browser = { cell = 2, open = true },
      Linear = { cell = 2 },
      Obsidian = { cell = 2 },
      Terminal = { cell = 3, open = true },
      Tower = { cell = 3 },
      Slack = { cell = 4 },
      Discord = { cell = 5 },
    },
  },
  {
    name = 'No Ray',
    cells = {
      '0,0 24x20',
      '24,0 36x20',
    },
    apps = {
      Browser = { cell = 1, open = true },
      Terminal = { cell = 2, open = true },
      Tower = { cell = 2 },
    },
  },
  {
    name = 'Code Focused',
    cells = {
      { '0,0 7x20', positions.sixths.left },
      { '7,0 53x20', positions.fiveSixths.right },
    },
    apps = {
      Ray = { cell = 1, open = true },
      Terminal = { cell = 2, open = true },
      Browser = { cell = 2, open = true },
      Tower = { cell = 2 },
    },
  },
}
