# ------------------------------------------------------------------------------
# Paths for go development
# ------------------------------------------------------------------------------

# Note: We can check all of Go's env vars by running `go env`

# Note: Relying on GOPATH isn't recommended for modern go development anymore
# Since Go 1.11, use go modules conventions instead!
# export GOPATH=$HOME/.go

# Make GOBIN hidden, for utils like errcheck, etc.
export GOBIN=$HOME/.go/bin

# Ensure GOMODCACHE also gets stored in custom .go dir
export GOMODCACHE=$HOME/.go/pkg/mod

# Add our custom GOBIN to runtime path
PATH=$HOME/.go/bin:$PATH


# ------------------------------------------------------------------------------
# Aliases and functions for go development
# ------------------------------------------------------------------------------

# alias gt="go test ./..."
