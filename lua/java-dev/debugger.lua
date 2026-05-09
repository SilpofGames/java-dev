local M = {}

function M.setup_dap()
  local ok, dap = pcall(require, "dap")
  if not ok then
    vim.notify("nvim-dap is not installed.", vim.log.levels.ERROR)
    return false
  end
  
  dap.configurations.java = {
    {
      type = 'java',
      request = 'attach',
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005,
    },
  }
  
  vim.notify("DAP for Java configured successfully.", vim.log.levels.INFO)
  return true
end

function M.start_debug()
  local ok, dap = pcall(require, "dap")
  if not ok then return end
  if M.setup_dap() then
    dap.continue()
  end
end

return M
