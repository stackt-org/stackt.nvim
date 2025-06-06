local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event
local constants = require('stackt.constants')

local M = {}

-- Define the content to be displayed inside the popup
M.window_content = {
  '',
  ' stackt.nvim  ',
}

-- Create the popup window styled like Mason
M.window = Popup({
  enter = true,
  focusable = true,
  position = '50%',
  size = {
    width = '90%',
    height = '85%',
  },
  win_options = {
    winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
  },
})

-- Open the popup
M.open = function()
  if M.window._.mounted then
    return
  end

  M.window:mount()

  vim.api.nvim_set_hl(0, 'StacktTitle', { fg = '#ffffff', bold = true })

  vim.api.nvim_buf_set_lines(M.window.bufnr, 0, -1, false, M.window_content)

  vim.api.nvim_buf_add_highlight(M.window.bufnr, -1, 'StacktTitle', 1, 1, -1)

  -- Auto close events
  M.window:on(event.BufLeave, function()
    M.close()
  end)

  M.window:on(event.BufHidden, function()
    M.close()
  end)

  M.window:on(event.BufWinLeave, function()
    M.close()
  end)

  -- Map <q> to close
  M.window:map('n', 'q', function()
    M.close()
  end, { noremap = true, nowait = true })
end

-- Close the popup
M.close = function()
  if not M.window._.mounted then
    return
  end
  M.window:unmount()
end

return M
