# ------------------------------------------------------------------------------
# General aliases and functions
# ------------------------------------------------------------------------------

# Ensure xterm-256color when ssh'ing, for terminal environments like `wezterm` and `xterm-kitty`
# Backspace doesn't work properly without this
alias ssh='env TERM=xterm-256color ssh'

alias c="clear"
alias o="open ."
alias rm="trash"
alias rf="trash -rf"
alias sizes='du -sh -c *'

# Copy pwd to clipboard
alias cwd="pwd && pwd | pbcopy && echo 'Copied to clipboard 📁'"

# Run any command from anywhere, without leaving current working directory.
#
# Usage: `in [target] [command]`
# Target: `shtuff` target (if available), else `z` argument
# Example: `in sand art make:model -a SomeModel`
function in() {(
  z $1
  eval ${@:2}
)}

# Download youtube video.
# Offers better results than `-f best`, by combining the best available video with the best available audio (requires ffmpeg).
alias ytdl="youtube-dl -f bestvideo+bestaudio"

# Ping until internet is connected/re-connected
internet() {
    disconnected=false

    while ! ping 8.8.8.8 -c 1 &> /dev/null; do
        echo '❌ No internet connection.'
        disconnected=true
        sleep 1;
    done;

    # Show notification only if it was ever disconnected, so you
    # can leave the command running in the background.
    if $disconnected; then
        osascript -e 'display notification "Connection restored ✅" with title "Internet"'
    fi

    echo '✅ Connected to internet.'
}
