# HomesteadAfter
Homestead SSH is great, but is very barebones.  This after.sh script will automatically install a bunch of quality-of-life improvements so that you can do all your daily tasks right from the Homestead prompt.  Feel free to fork and customize!

![Example Image](http://puu.sh/g2Pkp/21e204270e.png)

## Improvements?
- Zsh (Autocomplete, etc.)
- Theme (Pretty, etc.)
- Paths (Added vendor/bin for access to artisan tinker, phpunit, phpspec, etc.)
- Aliases ("c" for clear, "comp" for composer, "art" for php artisan, etc.)
- Git ("gituser" user setup alias, common git command aliases, etc.)

## Setup
Put this after.sh script into your global Homestead folder.  Homestead automatically executes after.sh after provisioning.
