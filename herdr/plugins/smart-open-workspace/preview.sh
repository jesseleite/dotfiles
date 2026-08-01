#!/usr/bin/env bash
# fzf preview for smart-open-workspace rows: "display\tkind\tpayload"
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"
line="${1:-}"

[[ -z "$line" ]] && exit 0

kind=$(printf '%s' "$line" | cut -f2)
payload=$(printf '%s' "$line" | cut -f3)

# ------------------------------------------------------------------------------
# Colors from Herdr config [theme.custom] (mauve / teal / subtext0).
# Falls back to rose-pine-ish defaults if the config is missing a token.
# TODO: more dynamically read from the active Herdr theme (not just parsing
# config.toml), and add plugin config options for overriding colors.
# ------------------------------------------------------------------------------
color_heading_hex='#E4609B' # mauve  — titles + section headings
color_key_hex='#47BAC0'     # teal   — keys, tags, git letters, directories
color_muted_hex='#AAA7BD'   # subtext0 — body text

hex_to_fg() {
  # #RRGGBB → CSI 38;2;r;g;b m
  local hex="${1#\#}"
  printf '\033[38;2;%d;%d;%dm' "0x${hex:0:2}" "0x${hex:2:2}" "0x${hex:4:2}"
}

# Read token colors from herdr's config.toml [theme.custom].
# Herdr does not expose a theme API to plugins, so we parse the file directly.
load_theme_colors() {
  # Same path Herdr itself uses (symlink into dotfiles is fine; bash follows it).
  local conf="${HERDR_CONFIG_PATH:-${XDG_CONFIG_HOME:-$HOME/.config}/herdr/config.toml}"
  [[ -f "$conf" ]] || return 0

  local in_section=0 raw key val
  while IFS= read -r raw || [[ -n "${raw:-}" ]]; do
    # trim leading whitespace first so full-line comments (# …) drop cleanly
    raw="${raw#"${raw%%[![:space:]]*}"}"
    # full-line comments only — do NOT strip '#' inside values like "#E4609B"
    [[ -z "$raw" || "$raw" == \#* ]] && continue
    # trim trailing whitespace
    raw="${raw%"${raw##*[![:space:]]}"}"

    if [[ "$raw" == \[*\] ]]; then
      if [[ "$raw" == "[theme.custom]" ]]; then
        in_section=1
      else
        in_section=0
      fi
      continue
    fi
    ((in_section)) || continue
    [[ "$raw" == *=* ]] || continue

    key="${raw%%=*}"
    val="${raw#*=}"
    key="${key// /}"
    val="${val#"${val%%[![:space:]]*}"}"
    val="${val%"${val##*[![:space:]]}"}"
    val="${val//\"/}"
    val="${val//\'/}"
    [[ -n "$val" ]] || continue
    case "$key" in
      mauve)    color_heading_hex="$val" ;;
      teal)     color_key_hex="$val" ;;
      subtext0) color_muted_hex="$val" ;;
    esac
  done <"$conf"
}

load_theme_colors
c_heading=$(hex_to_fg "$color_heading_hex")
c_key=$(hex_to_fg "$color_key_hex")
c_muted=$(hex_to_fg "$color_muted_hex")
c_reset=$'\033[0m'

heading() {
  printf '%s%s%s\n' "$c_heading" "$1" "$c_reset"
}

# Single field line: cyan key, muted value — "  path:  ~/…"
field() {
  local key="$1" value="$2"
  printf '  %s%s%s  %s%s%s\n' "$c_key" "$key" "$c_reset" "$c_muted" "$value" "$c_reset"
}

# Tab rows: cyan "1:" / muted label
format_tab_line() {
  local line="$1"
  if [[ "$line" =~ ^([0-9]+:)[[:space:]]*(.*)$ ]]; then
    printf '  %s%s%s %s%s%s\n' \
      "$c_key" "${BASH_REMATCH[1]}" "$c_reset" \
      "$c_muted" "${BASH_REMATCH[2]}" "$c_reset"
  else
    printf '  %s%s%s\n' "$c_muted" "$line" "$c_reset"
  fi
}

# Pane rows: cyan "[shell]" / muted title
format_pane_line() {
  local line="$1"
  if [[ "$line" =~ ^(\[[^]]+\])[[:space:]]*(.*)$ ]]; then
    printf '  %s%s%s  %s%s%s\n' \
      "$c_key" "${BASH_REMATCH[1]}" "$c_reset" \
      "$c_muted" "${BASH_REMATCH[2]}" "$c_reset"
  else
    printf '  %s%s%s\n' "$c_muted" "$line" "$c_reset"
  fi
}

# Porcelain: "XY path" → cyan status letters, muted path
format_change_line() {
  local line="$1"
  if [[ ${#line} -lt 2 ]]; then
    printf '  %s%s%s\n' "$c_muted" "$line" "$c_reset"
    return
  fi
  local xy="${line:0:2}"
  local path="${line:2}"
  path="${path# }" # drop the single porcelain separator space
  printf '  %s%s%s %s%s%s\n' "$c_key" "$xy" "$c_reset" "$c_muted" "$path" "$c_reset"
}

# Tree row: muted box-drawing prefix, cyan name if directory else muted
format_tree_line() {
  local root="$1" line="$2"
  local prefix name

  if [[ "$line" == *'── '* ]]; then
    prefix="${line%%── *}── "
    name="${line#*── }"
  else
    # Fallback: leading whitespace is prefix
    if [[ "$line" =~ ^([[:space:]]*)(.*)$ ]]; then
      prefix="${BASH_REMATCH[1]}"
      name="${BASH_REMATCH[2]}"
    else
      prefix=''
      name="$line"
    fi
  fi

  if [[ -d "$root/$name" ]]; then
    printf '  %s%s%s%s%s%s\n' \
      "$c_muted" "$prefix" "$c_reset" \
      "$c_key" "$name" "$c_reset"
  else
    printf '  %s%s%s%s%s\n' \
      "$c_muted" "$prefix" "$name" "$c_reset"
  fi
}

shorten() {
  local path="$1"
  if [[ -z "$path" || "$path" == "null" ]]; then
    printf '—'
  elif [[ "$path" == "$HOME" ]]; then
    printf '~'
  elif [[ "$path" == "$HOME"/* ]]; then
    printf '~%s' "${path#"$HOME"}"
  else
    printf '%s' "$path"
  fi
}

# Prefer worktree checkout path; otherwise mirror herdr's dynamic naming source:
# cwd of the first tab's first pane (root tab/pane as the workspace grows).
workspace_path() {
  local info="$1"
  local tabs="$2"
  local panes="$3"
  local path

  path=$(printf '%s' "$info" | jq -r '.result.workspace.worktree.checkout_path // empty')
  if [[ -n "$path" ]]; then
    printf '%s' "$path"
    return
  fi

  [[ -z "$tabs" || -z "$panes" ]] && return

  # Lowest tab number = first tab; among its panes, first listed (creation order).
  # Prefer foreground_cwd (what the shell is in) over process cwd, like smart-titles.
  jq -nr \
    --argjson tabs "$(printf '%s' "$tabs" | jq '.result.tabs // []')" \
    --argjson panes "$(printf '%s' "$panes" | jq '.result.panes // []')" '
      ($tabs | min_by(.number // 9999) | .tab_id) as $first_tab
      | [$panes[] | select(.tab_id == $first_tab)]
      | .[0]
      | .foreground_cwd // .cwd // empty
    ' 2>/dev/null || true
}

preview_workspace() {
  local id="$1"
  local info tabs panes path

  info=$("$herdr_bin" workspace get "$id" 2>/dev/null) || {
    printf 'workspace %s not found\n' "$id"
    return
  }

  tabs=$("$herdr_bin" tab list --workspace "$id" 2>/dev/null || true)
  panes=$("$herdr_bin" pane list --workspace "$id" 2>/dev/null || true)

  local label status tabs_n panes_n focused
  label=$(printf '%s' "$info" | jq -r '.result.workspace.label // .result.workspace.workspace_id')
  path=$(workspace_path "$info" "$tabs" "$panes")
  status=$(printf '%s' "$info" | jq -r '.result.workspace.agent_status // "unknown"')
  tabs_n=$(printf '%s' "$info" | jq -r '.result.workspace.tab_count // 0')
  panes_n=$(printf '%s' "$info" | jq -r '.result.workspace.pane_count // 0')
  focused=$(printf '%s' "$info" | jq -r '.result.workspace.focused // false')

  heading "$label"
  field 'path:' "$(shorten "$path")"
  field 'status:' "$status"
  field 'tabs:' "$tabs_n"
  field 'panes:' "$panes_n"
  if [[ "$focused" == "true" ]]; then
    field 'focused:' 'yes'
  fi
  printf '\n'

  if [[ -n "$tabs" ]]; then
    heading 'tabs'
    while IFS= read -r tab_line; do
      [[ -z "$tab_line" ]] && continue
      format_tab_line "$tab_line"
    done < <(printf '%s' "$tabs" | jq -r '.result.tabs[]? | (.label // .tab_id)' 2>/dev/null)
    printf '\n'
  fi

  if [[ -n "$panes" ]]; then
    heading 'panes'
    while IFS= read -r pane_line; do
      [[ -z "$pane_line" ]] && continue
      format_pane_line "$pane_line"
    done < <(
      printf '%s' "$panes" | jq -r '
        .result.panes[]?
        | (
            if .agent then "\(.agent)/\(.agent_status // "?")"
            else "shell"
            end
          ) as $who
        | "[\($who)]  \(.label // .terminal_title_stripped // .pane_id)"
      ' 2>/dev/null
    )
  fi
}

# Single-level directory tree; drop the root path line.
dir_tree() {
  local dir="$1"
  local out

  if command -v eza >/dev/null 2>&1; then
    out=$(eza --tree --level=1 --all --icons=never --color=never --group-directories-first "$dir" 2>/dev/null) || out=""
  elif command -v tree >/dev/null 2>&1; then
    out=$(tree -n -L 1 -a --dirsfirst --noreport "$dir" 2>/dev/null) || out=""
  else
    out=$(ls -1A "$dir" 2>/dev/null | sed 's/^/├── /') || out=""
  fi

  [[ -z "$out" ]] && return

  # Skip the first line (directory path / tree root label).
  printf '%s\n' "$out" | tail -n +2
}

preview_dir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    printf 'directory missing: %s\n' "$dir"
    return
  fi

  heading "$(shorten "$dir")"
  printf '\n'

  # repo (+ optional changes) only when this path is inside a git work tree.
  if git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    local branch changes
    branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null || true)
    [[ -z "$branch" ]] && branch='—'
    heading 'repo'
    field 'branch:' "$branch"
    printf '\n'

    changes=$(git -C "$dir" status --porcelain 2>/dev/null || true)
    if [[ -n "$changes" ]]; then
      heading 'changes'
      while IFS= read -r change_line; do
        [[ -z "$change_line" ]] && continue
        format_change_line "$change_line"
      done <<<"$changes"
      printf '\n'
    fi
  fi

  local tree tree_line
  tree=$(dir_tree "$dir")
  if [[ -n "$tree" ]]; then
    heading 'files'
    while IFS= read -r tree_line; do
      [[ -z "$tree_line" ]] && continue
      format_tree_line "$dir" "$tree_line"
    done <<<"$tree"
  fi
}

case "$kind" in
  workspace) preview_workspace "$payload" ;;
  dir)       preview_dir "$payload" ;;
  *)         printf 'unknown selection\n' ;;
esac
