--------------------------------------------------------------------------------
-- Automatically Watch for External File Changes
--------------------------------------------------------------------------------

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  group = vim.api.nvim_create_augroup('check_for_external_changes', { clear = true }),
  callback = function ()
    if vim.fn.bufname('%') ~= '' and vim.fn.filereadable(vim.fn.bufname('%')) then
      vim.cmd.checktime()
    end
  end
})


--------------------------------------------------------------------------------
-- Watch When Unfocused (:WatchStart and :WatchStop)
--------------------------------------------------------------------------------

local w = vim.uv.new_fs_event()

local function file_on_change(err, fname, status)
  vim.api.nvim_command('checktime')
  w:stop()
  file_watch_start()
end

function file_watch_start()
  w:start(vim.fn.expand('%'), {}, vim.schedule_wrap(function(...) file_on_change(...) end))
end

function file_watch_stop()
  w:stop()
end

vim.api.nvim_command("command! WatchStart lua file_watch_start()")
vim.api.nvim_command("command! WatchStop lua file_watch_stop()")
