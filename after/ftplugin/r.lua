--------------------------------------------
-- Create R-Specific Configuartion
--------------------------------------------
-- Use Vim's R syntax groups so roxygen tags and prose can have separate colours.
vim.bo.syntax = "r"

-- Continue R comments, including roxygen #', with Enter and o/O.
vim.opt_local.formatoptions:append("ro")

-- Wrap text and show a subtle vertical guide at 80 columns
-- (tidyverse style width, matches air's default line width).
vim.opt_local.textwidth = 80
vim.opt_local.colorcolumn = "80"

-- Configure tmux helper
local tmux = require("config.tmux")
local utils = require("config.utils")

tmux.setup({
  target = "{top-right}", -- which pane to send code to
  press_enter = true
})

-- Send load-all to tmux
vim.keymap.set({ 'n', 'v' }, "<leader>cL", function() tmux.send("devtools::load_all(); ") end,
  { desc = "devtools::load_all()", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, "<leader>cT", function() tmux.send("devtools::test(); ") end,
  { desc = "devtools::test()", noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, "<leader>ct", function()
  local path = utils.current_filepath()
  local package_root, source_name = path:match("^(.*)/R/([^/]+)%.[rR]$")
  package_root = package_root or path:match("^(.*)/tests/testthat/test%-[^/]*%.[rR]$")
  if not package_root or vim.fn.filereadable(package_root .. "/DESCRIPTION") ~= 1 then
    vim.notify("Open a file in an R package's R or tests/testthat directory", vim.log.levels.WARN)
    return
  end

  if vim.bo.modified or vim.fn.filereadable(path) ~= 1 then
    vim.notify("Save the current file before running tests", vim.log.levels.WARN)
    return
  end

  local test_path = path
  if source_name then
    local test_stem = package_root .. "/tests/testthat/test-" .. source_name
    test_path = test_stem .. ".R"
    if vim.fn.filereadable(test_path) ~= 1 then
      test_path = test_stem .. ".r"
      if vim.fn.filereadable(test_path) ~= 1 then
        vim.notify("No matching test file for " .. source_name .. " in tests/testthat", vim.log.levels.WARN)
        return
      end
    end
  end

  -- The R session runs from the package root. Escape the relative path for its console.
  local relative_test_path = test_path:sub(#package_root + 2)
  local escaped_path = relative_test_path:gsub('[%c\\"]', function(char)
    if char == '"' or char == "\\" then
      return "\\" .. char
    end
    return ("\\%03o"):format(char:byte())
  end)
  tmux.send(('devtools::test_active_file(file = "%s")'):format(escaped_path))
end, { desc = "Run current or matching R test file", buffer = true, noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, "<leader>cC", function() tmux.send("devtools::check(); ") end,
  { desc = "devtools::check()", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, "<leader>cD", function() tmux.send("devtools::document(); ") end,
  { desc = "devtools::document()", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, "<leader>cB", function() tmux.send("devtools::build_readme(); ") end,
  { desc = "devtools::build_readme()", noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, "<leader>cI", function() tmux.send("devtools::install(); ") end,
  { desc = "devtools::install()", noremap = true, silent = true })
vim.keymap.set({ 'v' }, "<leader>cV", function() tmux.send("View(" .. tmux.visual_selection() .. ")") end,
  { desc = "View selection", noremap = true, silent = true })

vim.keymap.set('x', "<leader>cE", function()
  local lines = vim.split(tmux.visual_selection(), "\n", { plain = true })
  for index, line in ipairs(lines) do
    lines[index] = line:gsub("^[ \t]*#'[ \t]?", "")
  end
  tmux.send(table.concat(lines, "\n"))
end, { desc = "Send roxygen example to tmux", buffer = true, silent = true })
local undo_maps = [[lua vim.keymap.del({'n', 'x'}, '<leader>ct', { buffer = true }); vim.keymap.del('x', '<leader>cE', { buffer = true })]]
vim.b.undo_ftplugin = vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. " | " .. undo_maps) or undo_maps

-- Execute the entire script with Rscript
vim.keymap.set(
  { 'n' }, "<leader>cR",
  function()
    vim.cmd(utils.current_filepath_escaped())
  end,
  { desc = "Rscript current file", noremap = true, silent = true })


--------------------------------------------
-- R code folding (use lsp)
--------------------------------------------
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
vim.opt_local.foldtext = "" -- ensure folded text keeps syntax highlighting

-- Enable folding but initially leave everything open.
vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99

--------------------------------------------
-- Custom formatting
--------------------------------------------
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.R",
--   callback = function()
--     vim.lsp.buf.format({
--       name = "air", -- Only use the 'air' server
--       async = false,
--     })
--   end,
-- })
