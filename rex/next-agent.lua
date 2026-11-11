-- -----------------------------------------------------------------------------
-- Next agent action for rex 🦖
-- -----------------------------------------------------------------------------
--
-- Defines a `next_agent` action, which cycles through agents, neediest first.
-- (A port of herdr/plugins/smart-next-agent)
--
-- Every agent lives in one ranked list: blocked first, then errored, then
-- finished ("done"), freshest first, then everyone else in tab order. A press
-- jumps to whatever became needy since the last press; failing that it carries
-- on from wherever the last press left you, so repeated presses tour every
-- agent instead of ping-ponging between two tabs.
--
-- That tour needs two facts rex can't supply: which pane we sent you to last,
-- and how far agent state had moved when we did. Both live in a small state
-- file; nothing else is kept.
--
-- This file is used in two ways:
--
--   1. Required from init.lua, where it defines the action
--   2. Run as a script by that action (`rex do next-agent.lua`), to do the
--      choosing, because only a script can look into other sessions

local attention = { blocked = 3, error = 2, done = 1 }

-- The entry following block_id, wrapping at the end. Returns nil when there's
-- nowhere else to go, and the first entry when block_id isn't in the list.
local function next_after(list, block_id)
  if #list < 2 then return nil end
  for i, agent in ipairs(list) do
    if agent.block_id == block_id then return list[i % #list + 1] end
  end
  return list[1]
end

-- Pick the next agent to focus, in order of preference:
--
--   1. Anything that became needy since the last press. A new notification
--      wins wherever it sits in the order; that's the whole point of the key.
--   2. If you're still standing where the last press put you, continue the
--      tour: the next needy agent while you're among them, otherwise the next
--      agent in the ranked list.
--   3. Otherwise this press came from somewhere we didn't send you, so start
--      at the top: the neediest agent, or plain tab order cycling when nobody
--      needs anything.
--
-- Returns the target and the state to save, or nil when there's nowhere to go.
local function choose(agents, state, focused_block_id)
  if #agents == 0 then return nil end

  local needy, rest = {}, {}
  for i, agent in ipairs(agents) do
    agent.order = i
    agent.rank = attention[agent.state] or 0
    table.insert(agent.rank > 0 and needy or rest, agent)
  end
  -- Equal agents keep tab order, so the list stays put underneath a tour;
  -- only a genuine status change moves anyone.
  table.sort(needy, function(a, b)
    if a.rank ~= b.rank then return a.rank > b.rank end
    if a.updated_at ~= b.updated_at then return a.updated_at > b.updated_at end
    return a.order < b.order
  end)
  local ranked = {}
  for _, agent in ipairs(needy) do table.insert(ranked, agent) end
  for _, agent in ipairs(rest) do table.insert(ranked, agent) end

  local focused, focused_needy
  for _, agent in ipairs(agents) do
    if agent.block_id == focused_block_id then
      focused, focused_needy = agent.block_id, agent.rank > 0
      break
    end
  end

  local seen = state.seen or ""
  local target
  for _, agent in ipairs(needy) do
    if agent.updated_at > seen then
      target = agent -- needy is ranked already, so this is the most urgent new one
      break
    end
  end
  if not target then
    if focused and focused == state.last_target then
      if focused_needy and #needy > 1 then
        target = next_after(needy, focused)
      else
        target = next_after(ranked, focused)
      end
    elseif #needy > 0 then
      target = needy[1]
    elseif focused then
      target = next_after(ranked, focused)
    else
      target = ranked[1]
    end
  end

  -- Never re-focus the pane we're already on; step past it instead.
  if not target or target.block_id == focused then
    target = next_after(ranked, focused)
    if not target then return nil end
  end

  for _, agent in ipairs(agents) do
    if agent.updated_at > seen then seen = agent.updated_at end
  end
  return target, { last_target = target.block_id, seen = seen }
end

-- A session's view, attaching to it first if we aren't already
local function view_of(session_id)
  local view = rex.session.view{ session_id = session_id }
  if view then return view end
  local attached = rex.session.attach{ session_id = session_id }
  return attached and attached.view
end

-- Every terminal that has a program reporting its status, in tab order. A
-- terminal with several records is represented by its neediest, freshest one.
local function list_agents()
  local agents = {}
  local list = rex.call("session.list")
  for _, session in ipairs(list and list.sessions or {}) do
    local view = view_of(session.session_id)
    for _, window in ipairs(view and view.windows or {}) do
      for _, layer in ipairs(window.layers or {}) do
        for _, block in ipairs(layer.blocks or {}) do
          local status = block.creator_name == "com.superlogical.terminal"
            and rex.block.call(block.creator_name, "program_status", {
              session_id = session.session_id,
              block_id = block.block_id,
            })
          local best
          for _, record in ipairs(status and status.records or {}) do
            local rank, best_rank = attention[record.state] or 0, best and attention[best.state] or 0
            if not best or rank > best_rank or (rank == best_rank and record.updated_at > best.updated_at) then
              best = record
            end
          end
          if best then
            table.insert(agents, {
              session_id = session.session_id,
              window_id = window.window_id,
              block_id = block.block_id,
              state = best.state,
              app = best.app,
              updated_at = best.updated_at,
            })
          end
        end
      end
    end
  end
  return agents
end

local state_dir = (os.getenv("XDG_STATE_HOME") or os.getenv("HOME") .. "/.local/state") .. "/rex"
local state_path = state_dir .. "/next-agent.json"

local function load_state()
  local file = io.open(state_path, "r")
  if not file then return {} end
  local raw = file:read("*a")
  file:close()
  local ok, state = pcall(rex.json.decode, raw)
  return ok and type(state) == "table" and state or {}
end

local function save_state(state)
  rex.exec({ "mkdir", "-p", state_dir })
  local file = io.open(state_path, "w")
  if not file then return end
  file:write(rex.json.encode(state))
  file:close()
end

-- Run as a script: choose the target, focus its pane, and print it as JSON
-- Pass peek=true to print the target without focusing it or saving state
if rex.args then
  local target, state = choose(list_agents(), load_state(), rex.args.block)
  if target and not rex.args.peek then
    save_state(state)
    rex.session.focus_block{ session_id = target.session_id, block_id = target.block_id }
  end
  return target
end

-- Required from init.lua: define the action
local script = os.getenv("HOME") .. "/.config/rex/next-agent.lua"

-- The server doesn't have `rex` on its PATH, so point at the binary it ships with
local rex_bin = (os.getenv("REX_BIN_DIR") or os.getenv("HOME")
  .. "/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS")
  .. "/rex"

rex.action{
  name = "next_agent",
  title = "Go to Next Agent",
  description = "Cycle through agents, neediest first",
  args = { peek = "boolean?" },
  run = function(ctx, args)
    local argv = { rex_bin, "do", script }
    if ctx.block_id then argv[#argv + 1] = "block=" .. ctx.block_id end
    if args.peek then argv[#argv + 1] = "peek=true" end
    local found, err = rex.exec(argv, { timeout = 10 })
    if not found then error(err, 0) end
    if not found.ok then error(found.stderr, 0) end
    local target = rex.json.decode(found.stdout)
    if not target or args.peek then return target end
    rex.client.queue("session.select", { session_id = target.session_id, window_id = target.window_id })
    return target
  end,
}
