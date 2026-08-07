--------------------------------------------
-- Create R-Specific Configuartion
--------------------------------------------
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
