local Popup = require('nui.popup')
local event = require('nui.utils.autocmd').event
local constants = require('stackt.constants')

local M = {}

-- Define the content to be displayed inside the popup
M.window_content = {
  'stackt.nvim' .. ' v' .. constants.VERSION,
  'press g? for help',
  constants.GITHUB_REPO,
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

  local width = M.window._.win_config.width
  local centered_content = vim.tbl_map(function(line)
    local pad = math.max(0, math.floor((width - #line) / 2))
    return string.rep(' ', pad) .. line
  end, M.window_content)

  vim.api.nvim_buf_set_lines(M.window.bufnr, 0, -1, false, centered_content)

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
