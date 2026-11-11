-- -----------------------------------------------------------------------------
-- Auto-name rex sessions 🦖
-- -----------------------------------------------------------------------------
--
-- Names each session after the repo (or worktree, or dir) that the first pane
-- of its first tab is in. Started by zsh/local/rex.zsh, and run with:
--
--   rex do --all auto-name.lua

local terminal = "com.superlogical.terminal"
local home = os.getenv("HOME")

-- What each session was last named from, so we only do work when that changes
local seen = {}

-- What we last named each session, and the sessions someone else has renamed
-- since (by hand, or by an agent), which we leave alone from then on
local named = {}
local manual = {}

-- Renaming a session to this hands it back to us (see `rexs` in zsh/local/rex.zsh)
local reset_label = "↻"

-- The first (top left) pane of the session's first tab
local function first_block(view)
  local window = view.windows and view.windows[1]
  if not window then return nil end
  for _, layer in ipairs(window.layers or {}) do
    if layer.kind == "tiled" then
      local node = layer.layout
      while node and not node.block_id do
        node = node.split and node.split.before
      end
      return node and node.block_id
    end
  end
end

-- The directory a terminal is in, as a plain path
local function cwd_of(session_id, block_id)
  local args = { session_id = session_id, block_id = block_id }
  local reported = rex.block.call(terminal, "pwd", args)
  local pwd = reported and reported.pwd
  if not pwd then
    local process = rex.block.call(terminal, "process", args)
    pwd = process and process.foreground and process.foreground.cwd
  end
  if not pwd then return nil end
  pwd = pwd:match("^file://[^/]*(/.*)$") or pwd
  return (pwd:gsub("%%(%x%x)", function(hex) return string.char(tonumber(hex, 16)) end))
end

-- The repo (or worktree) root's dir name, else the dir's own name
local function name_for(cwd)
  local git = rex.exec({ "git", "rev-parse", "--show-toplevel" }, { cwd = cwd, stderr = false, timeout = 5 })
  local root = git and git.ok and git.stdout:gsub("%s+$", "") or cwd
  return root:match("([^/]+)/*$")
end

local function update(session_id, force)
  if manual[session_id] then return end
  local view = rex.session.view{ session_id = session_id }
  local block_id = view and first_block(view)
  if not block_id then return end
  local cwd = cwd_of(session_id, block_id)
  if not cwd or (cwd == home and not force) then return end
  local key = block_id .. "|" .. cwd
  if seen[session_id] == key then return end
  seen[session_id] = key
  local name = name_for(cwd)
  if name and name ~= view.label then
    named[session_id] = name
    rex.session.set_label{ session_id = session_id, label = name }
  end
end

-- Wait for a session to go quiet before looking at it, so a burst of changes
-- (ie. opening lots of tabs quickly) becomes one check afterwards, and we never
-- call into a session while its terminals are still being created
local debounce_seconds = 1
local pending = {}

local function schedule(session_id)
  if pending[session_id] then pending[session_id]:cancel() end
  pending[session_id] = rex.after(debounce_seconds, function()
    pending[session_id] = nil
    update(session_id)
  end)
end

rex.on("terminal.pwd_changed", function(ctx) schedule(ctx.session_id) end)
rex.on("session_view_changed", function(ctx) schedule(ctx.session_id) end)
rex.on("session_label_changed", function(ctx, ev)
  local session_id = ctx.session_id
  if ev.label == reset_label then
    seen[session_id], named[session_id], manual[session_id] = nil, nil, nil
    update(session_id, true)
  elseif ev.label ~= named[session_id] then
    manual[session_id] = true
  end
end)
rex.on("session_destroyed", function(ctx, ev)
  local session_id = ev.session_id or ctx.session_id
  seen[session_id], named[session_id], manual[session_id] = nil, nil, nil
  if pending[session_id] then pending[session_id]:cancel() end
  pending[session_id] = nil
end)

-- Name the sessions that already exist
local list = rex.call("session.list")
for _, session in ipairs(list and list.sessions or {}) do
  update(session.session_id)
end
