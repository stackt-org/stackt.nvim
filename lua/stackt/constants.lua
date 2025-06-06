local M = {}

M.VERSION = '0.0.0'
M.GITHUB_REPO = 'https://github.com/stackt-org/stackt.nvim'
M.REGISTRY = 'github:stackt/stackt-registry'
M.DATA_PATH = vim.fn.stdpath('data') .. '/stackt'
M.CACHE_PATH = vim.fn.stdpath('cache') .. '/stackt'
M.LOG_LEVEL = vim.log.levels.INFO
M.REGISTRY_CACHE_PATH = M.CACHE_PATH .. '/registry.json'

return M
