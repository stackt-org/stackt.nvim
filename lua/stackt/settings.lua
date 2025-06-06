local constants = require('stackt.constants')
local ui = require('stackt.ui')

local M = {}

---@type StacktConfig
M.config = {
  install_root_dir = constants.DATA_PATH,
  registries = { constants.REGISTRY },
  automatic_installation = true,
  log_level = constants.LOG_LEVEL,
  max_concurrent_installers = 4,
  run_post_install_hook = true,
  registry_cache_path = constants.REGISTRY_CACHE_PATH,
  ui = {
    icons = {
      debugger_installed = '✓',
      debugger_pending = '➜',
      debugger_uninstalled = '✗',
    },
    check_outdated_packages_on_open = true,
    border = 'none',
    width = 0.8,
    height = 0.9,
    keymaps = {
      toggle_package_expand = '<CR>',
      install_package = 'i',
      update_package = 'u',
      check_package_version = 'c',
      update_all_packages = 'U',
      check_outdated_packages = 'C',
      uninstall_package = 'X',
      cancel_installation = '<C-c>',
      apply_language_filter = '<C-f>',
    },
  },
}

M.setup_commands = function()
  vim.api.nvim_create_user_command('Stackt', function()
    ui.open()
  end, { desc = 'Open Stackt UI' })

  vim.api.nvim_create_user_command('StacktInstall', function()
    -- Add installation logic here
    print('Installing packages...')
  end, { desc = 'Install packages' })
end

return M
