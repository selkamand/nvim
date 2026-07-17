-- Assorted utilities
--
local M = {}

-- Get full filepath as a string. You may actually want `current_file_escaped` if you want a string escaped for use a shell command argument
function M.current_file()
  return vim.fn.expand("%:p")
end

-- Path to current file (escaped for use as a shell command argument)
function M.current_file_escaped()
  return vim.fn.shellescape(M.current_file())
end

return M
