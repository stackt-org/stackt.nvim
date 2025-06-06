local api = require('stackt.ui.instance')
local M = {}

M.close = function()
  api.close()
end

M.open = function()
  api.open()
end

return M
