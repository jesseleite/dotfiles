#!/usr/bin/env bash
# fzf over open herdr workspaces + frecent zoxide dirs.
# Workspaces focus; zoxide paths create a new workspace.
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"
plugin_root="$(cd "$(dirname "$0")" && pwd)"
self="$plugin_root/picker.sh"
preview_script="$plugin_root/preview.sh"

# Persist MRU across opens. Herdr has no last-opened API, so we track it in
# the plugin state dir (always set when Herdr launches plugin processes).
state_dir="${HERDR_PLUGIN_STATE_DIR:-}"
mru_file=""
if [[ -n "$state_dir" ]]; then
  mkdir -p "$state_dir"
  mru_file="$state_dir/workspace-mru"
fi

# Same glyphs/colors as joshmedeski/sesh (icon/icon.go):
#   tmux sessions →  blue (34)
#   zoxide dirs   →  cyan (36)
icon_ws=$'\033[34m\033[39m'
icon_dir=$'\033[36m\033[39m'

die_pause() {
  printf '%s\n' "$1" >&2
  read -r -n1 -p 'Press any key to close…' </dev/tty || true
  exit 1
}

require_bins() {
  command -v zoxide >/dev/null 2>&1 || die_pause 'smart-open-workspace: zoxide not found in PATH'
  command -v fzf >/dev/null 2>&1 || die_pause 'smart-open-workspace: fzf not found in PATH'
  command -v jq >/dev/null 2>&1 || die_pause 'smart-open-workspace: jq not found in PATH'
}

shorten() {
  local path="$1"
  if [[ "$path" == "$HOME" ]]; then
    printf '~'
  elif [[ "$path" == "$HOME"/* ]]; then
    printf '~%s' "${path#"$HOME"}"
  else
    printf '%s' "$path"
  fi
}

# Load MRU ids (most recent first), one per line.
load_mru() {
  [[ -n "$mru_file" && -f "$mru_file" ]] || return 0
  grep -v '^[[:space:]]*$' "$mru_file" 2>/dev/null || true
}

# Write MRU ids (most recent first). No-op outside Herdr (no state dir).
save_mru() {
  [[ -n "$mru_file" ]] || return 0
  local -a ids=("$@")
  if ((${#ids[@]} == 0)); then
    : >"$mru_file"
    return
  fi
  printf '%s\n' "${ids[@]}" >"$mru_file"
}

# Move id to most-recent (head). Keeps other entries in relative order.
touch_mru() {
  local id="$1"
  [[ -n "$id" ]] || return 0
  local -a next=("$id")
  local other
  while IFS= read -r other; do
    [[ -z "$other" || "$other" == "$id" ]] && continue
    next+=("$other")
  done < <(load_mru)
  save_mru "${next[@]}"
}

# Drop id from MRU (after close).
drop_mru() {
  local id="$1"
  [[ -n "$id" ]] || return 0
  local -a next=()
  local other
  while IFS= read -r other; do
    [[ -z "$other" || "$other" == "$id" ]] && continue
    next+=("$other")
  done < <(load_mru)
  save_mru "${next[@]+"${next[@]}"}"
}

# Sync MRU with live workspaces: currently focused is most recent, drop dead ids,
# append any unknown live ids. Returns display order via stdout (one id per line):
#   previous (MRU #2), active (MRU #1), then older MRU…  — active second for Enter-to-alternate.
ordered_workspace_ids() {
  local list_json="$1"
  local focused live_json
  local -a live=() mru=()
  local id

  focused=$(printf '%s' "$list_json" | jq -r '.result.workspaces[]? | select(.focused == true) | .workspace_id' | head -1)
  live_json=$(printf '%s' "$list_json" | jq -c '[.result.workspaces[]?.workspace_id]')
  while IFS= read -r id; do
    [[ -n "$id" ]] && live+=("$id")
  done < <(printf '%s' "$live_json" | jq -r '.[]')

  ((${#live[@]} == 0)) && return 0

  is_live() {
    printf '%s' "$live_json" | jq -e --arg id "$1" 'index($id) != null' >/dev/null 2>&1
  }

  if [[ -n "$focused" ]]; then
    mru+=("$focused")
  fi
  while IFS= read -r id; do
    [[ -z "$id" || "$id" == "$focused" ]] && continue
    is_live "$id" || continue
    mru+=("$id")
  done < <(load_mru)
  for id in "${live[@]}"; do
    local seen=0
    local m
    for m in "${mru[@]+"${mru[@]}"}"; do
      [[ "$m" == "$id" ]] && { seen=1; break; }
    done
    ((seen)) || mru+=("$id")
  done
  save_mru "${mru[@]}"

  if ((${#mru[@]} == 1)); then
    printf '%s\n' "${mru[0]}"
    return
  fi
  printf '%s\n' "${mru[1]}"
  printf '%s\n' "${mru[0]}"
  if ((${#mru[@]} > 2)); then
    printf '%s\n' "${mru[@]:2}"
  fi
}

list_entries() {
  # Open workspaces first, ordered by last-open (active second).
  # Fields: display \t kind \t payload
  local list_json id label
  list_json=$("$herdr_bin" workspace list)

  while IFS= read -r id; do
    [[ -z "$id" ]] && continue
    label=$(printf '%s' "$list_json" | jq -r --arg id "$id" '
      .result.workspaces[]? | select(.workspace_id == $id) | .label // $id
    ')
    # Two spaces after icon: nerd glyphs are often double-width and look flush with one.
    printf '%s  %s\t%s\t%s\n' "$icon_ws" "${label:-$id}" "workspace" "$id"
  done < <(ordered_workspace_ids "$list_json")

  # Frecent zoxide dirs (zoxide already sorts; keep order with fzf --no-sort).
  zoxide query --list \
    | while IFS= read -r dir; do
        [[ -z "${dir:-}" ]] && continue
        printf '%s  %s\t%s\t%s\n' "$icon_dir" "$(shorten "$dir")" "dir" "$dir"
      done
}

parse_selection() {
  local line="$1"
  kind=$(printf '%s' "$line" | cut -f2)
  payload=$(printf '%s' "$line" | cut -f3)
}

# Interactive rename inside the popup (workspace rows only).
action_rename() {
  local line="${1:-}"
  local kind payload current name
  parse_selection "$line"
  [[ "$kind" == "workspace" && -n "$payload" ]] || return 0

  current=$("$herdr_bin" workspace get "$payload" 2>/dev/null \
    | jq -r '.result.workspace.label // empty')
  clear 2>/dev/null || true
  printf 'Rename workspace%s\n> ' "${current:+ ($current)}"
  IFS= read -r name </dev/tty || return 0
  [[ -z "${name// /}" ]] && return 0
  "$herdr_bin" workspace rename "$payload" "$name" >/dev/null
}

# Close workspace inside the popup (workspace rows only).
action_close() {
  local line="${1:-}"
  local kind payload
  parse_selection "$line"
  [[ "$kind" == "workspace" && -n "$payload" ]] || return 0
  drop_mru "$payload"
  "$herdr_bin" workspace close "$payload" >/dev/null
}

# --- subcommands (used by fzf reload/execute) ---------------------------------
case "${1:-}" in
  --list)
    list_entries
    exit 0
    ;;
  --rename)
    action_rename "${2:-}"
    exit 0
    ;;
  --close)
    action_close "${2:-}"
    exit 0
    ;;
esac

require_bins

selection=$(
  list_entries \
    | fzf \
      --ansi \
      --reverse \
      --no-sort \
      --info=hidden \
      --delimiter=$'\t' \
      --with-nth=1 \
      --prompt='  > ' \
      --header='rename [ctrl-r] · close [ctrl-x]' \
      --preview="$preview_script {}" \
      --preview-window='right:55%:border-left:<80(40%)' \
      --bind="ctrl-r:execute($self --rename {})+reload($self --list)" \
      --bind="ctrl-x:execute($self --close {})+reload($self --list)" \
    || true
)

[[ -z "${selection:-}" ]] && exit 0

kind=$(printf '%s' "$selection" | cut -f2)
payload=$(printf '%s' "$selection" | cut -f3)

case "$kind" in
  workspace)
    touch_mru "$payload"
    "$herdr_bin" workspace focus "$payload"
    ;;
  dir)
    if [[ ! -d "$payload" ]]; then
      die_pause "smart-open-workspace: directory no longer exists: $payload"
    fi
    label=$(basename "$payload")
    create_json=$("$herdr_bin" workspace create --cwd "$payload" --label "$label" --focus)
    new_id=$(printf '%s' "$create_json" | jq -r '.result.workspace.workspace_id // .result.workspace_id // empty')
    [[ -n "$new_id" ]] && touch_mru "$new_id"
    ;;
  *)
    die_pause "smart-open-workspace: unknown selection kind: $kind"
    ;;
esac
