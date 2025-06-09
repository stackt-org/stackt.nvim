local event = require('nui.utils.autocmd').event
local Popup = require('nui.popup')
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
  border = {
    style = {
      '╭',
      '─',
      '╮',
      '│',
      '│',
      '╰',
      '─',
      '╯',
    },
    text = {
      top = ' stackt.nvim  ',
      top_align = 'center',
    },
    highlight = 'FloatBorder',
  },
  win_options = {
    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,FloatTitle:Title',
    cursorline = true,
  },
})

-- Open the popup
M.open = function()
  if M.window._.mounted then
    return
  end

  M.window:mount()

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
