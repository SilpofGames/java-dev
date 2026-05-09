if vim.g.loaded_java_dev == 1 then
  return
end
vim.g.loaded_java_dev = 1

vim.api.nvim_create_user_command("JavaInitProject", function() require("java-dev.runner").init_project() end, {})
vim.api.nvim_create_user_command("JavaRun", function() require("java-dev.runner").run() end, {})
vim.api.nvim_create_user_command("JavaDecompile", function() require("java-dev.decompile").decompile() end, {})
vim.api.nvim_create_user_command("JavaDebug", function() require("java-dev.debugger").start_debug() end, {})
