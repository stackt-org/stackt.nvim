local settings = require('stackt.settings')

local M = {}

---@param config StacktConfig
M.setup = function(config)
  ---@type StacktConfig
  return vim.tbl_deep_extend('force', settings.config, config or {})
end

M.open = function()
  require('stackt.ui.init').open()
end

vim.api.nvim_create_user_command('YourPlugin', function()
  require('stackt.ui.init').open()
end, {})

return M
