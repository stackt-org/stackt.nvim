local settings = require('stackt.settings')

local M = {}

---@param config StacktConfig
M.setup = function(config)
  settings.setup_commands()

  ---@type StacktConfig
  return vim.tbl_deep_extend('force', settings.config, config or {})
end

return M
