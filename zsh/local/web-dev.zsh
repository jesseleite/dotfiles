# Package managers
alias comp="composer"
alias n="npm run"

# Reinstall dependencies
alias deps="comp install && rm -rf node_modules && npm install && npm run dev"

# Testing
alias t="phpunit --exclude-group slow"
alias ta="phpunit"

# Browse valet site.
alias b="valet open"
