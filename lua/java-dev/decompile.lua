local M = {}

function M.decompile()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  
  if ext == "java" then
    file = vim.fn.expand("%:p:r") .. ".class"
  elseif ext ~= "class" then
    vim.notify("Not a .java or .class file.", vim.log.levels.ERROR)
    return
  end
  
  if vim.fn.filereadable(file) == 0 then
    vim.notify(".class file not found. Compile first.", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Decompiling Java bytecode...", vim.log.levels.INFO)
  local cmd = string.format("javap -c -p %s", vim.fn.shellescape(file))
  local output = vim.fn.systemlist(cmd)
  
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("setlocal filetype=java")
  vim.cmd("setlocal readonly")
end

return M
