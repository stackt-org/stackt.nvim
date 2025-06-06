local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event

local M = {}

M.window = Popup({
  enter = true,
  focusable = true,
  border = {
    style = 'rounded',
  },
  position = '50%',
  size = {
    width = '80%',
    height = '85%',
  },
})

M.open = function()
  if M.window._.mounted then
    return
  end

  M.window:mount()

  M.window:on(event.BufLeave, function()
    M.close()
  end)

  M.window:on(event.BufHidden, function()
    M.close()
  end)

  M.window:on(event.BufWinLeave, function()
    M.close()
  end)

  M.window:map('n', '<Esc>', function()
    M.close()
  end, { noremap = true, nowait = true })

  vim.api.nvim_buf_set_lines(M.window.bufnr, 0, 1, false, M.window_content)
end

M.close = function()
  if M.window._.mounted then
    return
  end

  M.window:unmount()
end

M.window_content = { 'Hello, StacktUI!' }

return M
