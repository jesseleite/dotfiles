#!/usr/bin/env bash
# Open the smart-open-workspace picker popup.
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"

# Placement/size come from herdr-plugin.toml [[panes]] entry for "picker".
exec "$herdr_bin" plugin pane open \
  --plugin smart-open-workspace \
  --entrypoint picker \
  --focus
