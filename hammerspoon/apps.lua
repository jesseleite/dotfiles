-- Each app is defined by their name, and should contain a table with the following keys:
--   id: the bundle id which can be found by running `bundle-id appname`
--   key: the key to summon the app
--   position: the starting grid position
--   focus: the focus mode position
return {
    Code = {
        id = 'com.microsoft.VSCode',
        key = 'c',
        focus = positions.center.large,
    },
    Safari = {
        id = 'com.apple.Safari',
        key = 'b', -- browser
    },
    Slack = {
        id = 'com.tinyspeck.slackmacgap',
        key = 's',
        position = positions.center.tiny,
        focus = positions.center.tiny,
    },
    Spotify = {
        id = 'com.spotify.client',
        key = 'm', -- music
        position = positions.center.tiny,
    },
    Discord = {
        id = 'com.hnc.Discord',
        position = positions.center.small,
    },
    iTerm = {
        id = 'com.googlecode.iterm2',
        key = 'i',
        position = positions.center.tiny,
    },
    Tower = {
        id = 'com.fournova.Tower3',
        key = 'g', -- git
        position = positions.center.medium,
    },
    Ray = {
        id = 'be.spatie.ray',
        key = 'r',
    },
    Mimestream = {
        id = 'com.mimestream.Mimestream',
        key = 'e' -- email
    },
    Finder = {
        id = 'com.apple.finder',
        key = 'f'
    },
    Tinkerwell = {
        id = 'de.beyondco.tinkerwell',
        key = 't',
        position = positions.center.large
    },
    TablePlus = {
        id = 'com.tinyapp.TablePlus',
        key = 'd' -- database
    },
    Things = {
        id = 'com.culturedcode.ThingsMac',
        key = 'l' -- list
    },
    Messages = {
        id = 'com.apple.MobileSMS',
        key = ',', -- next to m
        position = positions.center.mini,
        focus = positions.center.mini,
    },
    Obsidian = {
        id = 'md.obsidian',
        key = 'n' -- notes
    },
    ['1Password'] = {
        id = 'com.1password.1password',
        key = '1'
    },
}
