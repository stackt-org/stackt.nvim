local constants = require('stackt.constants')

local M = {}

M.component = {
  'stackt.nvim' .. ' v' .. constants.VERSION,
  'press g? for help',
  constants.GITHUB_REPO,
}

return M
