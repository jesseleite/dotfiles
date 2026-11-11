-- -----------------------------------------------------------------------------
-- Rex Config! 🦖
-- -----------------------------------------------------------------------------

-- Switch tabs (j/k for vertical tabs in the sidebar, h/l for tabs along the top)
rex.bind("ctrl+j", "client.tab.next")
rex.bind("ctrl+k", "client.tab.previous")
rex.bind("ctrl+l", "client.tab.next")
rex.bind("ctrl+h", "client.tab.previous")

-- Move tabs (same idea as switching: j/k for vertical tabs, h/l for top tabs)
rex.bind("ctrl+shift+j", "client.tab.move.forward")
rex.bind("ctrl+shift+k", "client.tab.move.backward")
rex.bind("ctrl+shift+l", "client.tab.move.forward")
rex.bind("ctrl+shift+h", "client.tab.move.backward")

-- Focus panes
rex.bind("alt+h", "pane.focus.left")
rex.bind("alt+j", "pane.focus.down")
rex.bind("alt+k", "pane.focus.up")
rex.bind("alt+l", "pane.focus.right")

-- Jump to the next agent needing attention (see next-agent.lua)
require("next-agent")
rex.bind("alt+n", "next_agent")
