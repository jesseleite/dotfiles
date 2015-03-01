# Homestead After

Homestead SSH is great, but it is very barebones.  I found myself spending half my time in my local terminal, and the other half in Homestead.  Why not setup Homestead so that it's ready for all of your Laravel workflow?

This after.sh script will automatically run after Homestead provisions itself, and will a bunch of quality-of-life improvements so that you can spend all of your time in the Homestead environment.

Don't like what's installed?  Fork and customize!  If anything, this is just a good tutorial on how to customize and automate Homestead workflow.

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

## Elixir Problems?

One of my main workflow gripes was with Gulp/Elixir.  If I installed Elixir ("npm install") on your local machine, I found that Gulp/Elixir would throw errors for certain tasks in the Homestead environment.  Though unrelated to this HomesteadAfter setup, it kind of defeats the purpose if you can't get all of your tools running smoothly in the Homestead environment.  If you find yourself having problems with Gulp/Elixir in Homestead, I recommend deleting your project's /node_modules folder, and running "sudo npm install" within your Homestead environment.  This solved my Gulp/Elixir problems in Homestead.
