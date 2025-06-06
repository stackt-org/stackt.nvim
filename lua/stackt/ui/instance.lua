local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event

local M = {}

-- Define the content to be displayed inside the popup
M.window_content = {
  '📦 StacktUI — Language Tool Manager',
  '',
  'Available (500)',
  '────────────────────────────',
  '• lua-language-server',
  '• typescript-language-server',
  '• angular-language-server',
  '',
  '🛈 Press <q> to close this window.',
}

-- Create the popup window styled like Mason
M.window = Popup({
  enter = true,
  focusable = true,
  border = {
    style = 'rounded',
    text = {
      top = ' StacktUI ',
      top_align = 'center',
    },
  },
  position = '50%',
  size = {
    width = '80%',
    height = '60%',
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

  vim.api.nvim_buf_set_lines(M.window.bufnr, 0, -1, false, M.window_content)

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
