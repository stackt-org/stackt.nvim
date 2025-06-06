local instance = require('stackt.ui.instance')
local M = {}

M.close = function()
  instance.close()
end

M.open = function()
  instance.open()
end

return M
