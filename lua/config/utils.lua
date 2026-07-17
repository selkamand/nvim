-- Assorted utilities
--
local M = {}

-- Get full filepath as a string. You may actually want `current_file_escaped` if you want a string escaped for use a shell command argument
function M.current_filepath()
  return vim.fn.expand("%:p")
end

-- Path to current file (escaped for use as a shell command argument)
function M.current_filepath_escaped()
  return vim.fn.shellescape(M.current_filepath())
end

-- Current filename (no path)
function M.current_filename()
  return vim.fn.expand("%:t")
end

-- Current filename without extension
function M.current_filename_no_extension()
  return vim.fn.expand("%:t:r")
end

return M
