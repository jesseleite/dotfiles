return {
  {
    name = 'Ultrawide Dev',
    cells = {
      {  '0,0 24x20', '0,0 24x20', '0,0 40x20' },
      {  '24,0 36x20', '12,0 48x20', '24,0 36x20' },
      {  '42,2 16x16', '42,2 16x16', '42,2 16x16' },
      {  '42,2 16x16', '42,2 16x16', '42,2 16x16' },
      {  '30,3 20x14', '30,3 20x14', '30,3 20x14' },
    },
    apps = {
      Browser = { cell = 1, open = true },
      Terminal = { cell = 2, open = true },
      Linear = { cell = 1 },
      Slack = { cell = 4 },
      Discord = { cell = 5 },
    },
  },
  {
    name = 'Laptop Dev',
    cells = {
      positions.full,
      positions.center.medium,
    },
    apps = {
      Browser = { cell = 1, open = true },
      Terminal = { cell = 1, open = true },
      Linear = { cell = 1 },
      Obsidian = { cell = 1 },
      Slack = { cell = 2 },
      Discord = { cell = 2 },
    },
  },
}
