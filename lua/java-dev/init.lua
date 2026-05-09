local M = {}

M.config = {
  java_cmd = "java",
  javac_cmd = "javac",
  maven_cmd = "mvn",
}

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

return M
