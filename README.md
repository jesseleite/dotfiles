# Homestead After

A bunch of quality-of-life renovations to my [Laravel Homestead](http://laravel.com/docs/homestead) environment.  Don't like what's installed?  Fork and customize!  If anything, this is just a good tutorial on how to customize and automate Homestead workflow.

Everything is added via Homestead's after.sh hook.  Homestead will automatically run this script after initial provisioning.

## Improvements?

- Zsh (Autocomplete, vi mode on command line, etc.)
- Vim (More vim love, .vimrc, opp.zsh, etc.)
- Theme (Pretty, etc.)
- Paths (Added vendor/bin for access to artisan tinker, phpunit, phpspec, etc.)
- Aliases ("c" for clear, "comp" for composer, "art" for php artisan, etc.)
- Git ("gituser" user setup script alias, common git command aliases, etc.)

## Customize

- Fork this repository.
- Modify the repository link in after.sh (line 11).
- Modify anything else that doesn't boil your potatoes.

## Setup

- Put after.sh into your global ~/.homestead folder.
- Run "homestead up".
- Connect via "homestead ssh".
- Run "gituser" to setup default git user.
- Enjoy!

## Preview

![Example Image](http://puu.sh/g2ZyN/bca5b3233a.png)
