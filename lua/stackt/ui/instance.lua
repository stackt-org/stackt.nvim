local event = require('nui.utils.autocmd').event
local Popup = require('nui.popup')
local Menu = require('nui.menu')
local constants = require('stackt.constants')

local M = {}

-- Menu items
local menu_labels = {
  { label = 'Home (H)', key = 'h' },
  { label = 'Install (I)', key = 'i' },
  { label = 'Update (U)', key = 'u' },
  { label = 'Sync (S)', key = 's' },
  { label = 'Clean (X)', key = 'x' },
  { label = 'Check (C)', key = 'c' },
  { label = 'Log (L)', key = 'l' },
  { label = 'Restore (R)', key = 'r' },
  { label = 'Profile (P)', key = 'p' },
  { label = 'Debug (D)', key = 'd' },
  { label = 'Help (?)', key = '?' },
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
    winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder',
  },
})

local function get_menu_items(selected_idx)
  local items = {}
  for i, entry in ipairs(menu_labels) do
    local text = entry.label
    if i == selected_idx then
      text = ' ' .. text .. ' '
    end
    table.insert(items, Menu.item(text))
  end
  return items
end

-- Open the popup with menu
M.open = function(opts)
  opts = opts or {}
  local current_idx = opts.selected_idx or 1

  if M.window._.mounted then
    return
  end

  M.window:mount()

  -- Set the popup buffer content (header)
  local header
  if current_idx == 1 then
    header = ' stackt 󱐋 '
  else
    header = ' Home '
  end
  vim.api.nvim_buf_set_lines(M.window.bufnr, 0, -1, false, { '', header, '' })

  -- Create and mount the menu
  local menu = Menu({
    relative = 'win',
    position = {
      row = 4,
      col = 2,
    },
    size = {
      width = 80,
      height = 1,
    },
    border = {
      style = 'none',
    },
    win_options = {
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual',
    },
  }, {
    lines = get_menu_items(current_idx),
    max_width = 80,
    keymap = {
      focus_next = { 'l', '<Right>', '<Tab>' },
      focus_prev = { 'h', '<Left>', '<S-Tab>' },
      close = { '<Esc>', '<C-c>', 'q' },
      submit = { '<CR>', '<Space>' },
    },
    on_close = function()
      M.close()
    end,
    on_submit = function(item, idx)
      -- Reopen with new selection
      M.close()
      M.open({ selected_idx = idx })
    end,
  })

  menu:mount(M.window)

  -- Key mappings for direct selection
  for idx, entry in ipairs(menu_labels) do
    menu:map('n', entry.key, function()
      M.close()
      M.open({ selected_idx = idx })
    end, { noremap = true, nowait = true })
  end

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
end

-- Close the popup
M.close = function()
  if not M.window._.mounted then
    return
  end
  M.window:unmount()
end

return M
