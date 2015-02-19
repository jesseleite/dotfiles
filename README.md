# HomesteadAfter
Homestead SSH is great, but is very barebones.  This after.sh script will automatically install a bunch of quality-of-life improvements so that you can do all your daily tasks right from the Homestead prompt.  Feel free to fork and customize!

## Improvements?
- Zsh (Autocomplete, etc.)
- Theme (Pretty, etc.)
- Paths (Added vendor/bin for access to artisan tinker, phpunit, phpspec, etc.)
- Aliases ("c" for clear, "comp" for composer, "art" for php artisan, etc.)
- Git ("gituser" user setup script alias, common git command aliases, etc.)

## Setup
- Put after.sh into your global Homestead folder.
- "homestead up"

Homestead automatically executes after.sh after provisioning.  The after.sh script will pull everything else in and setup the Homestead environment.

## Preview
![Example Image](http://puu.sh/g2ZyN/bca5b3233a.png)
