return {
  {
    name = 'Code and Browser',
    apps = {
      Safari = { positions.halves.left,  '0,0 12x20',  positions.thirds.left,     '0,0 6x20' },
      Code =   { positions.halves.right, '12,0 18x20', positions.twoThirds.right, '6,0 24x20' }
    },
  },
  {
    name = 'Code and Ray',
    apps = {
      Ray =    { positions.sixths.left, positions.thirds.left },
      Safari = { positions.fiveSixths.right, positions.twoThirds.right },
      Code =   { positions.fiveSixths.right, positions.twoThirds.right },
    }
  },
  {
    name = 'Code, Ray, Browser',
    apps = {
      Safari = { '4,0 11x20',  '0,0 10x8' },
      Code =   { '15,0 15x20', positions.twoThirds.right },
      Ray =    { '0,0 4x20',   '0,8 10x12' }
    }
  }
}
