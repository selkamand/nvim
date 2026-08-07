--------------------------------------------
-- Create R-Specific Configuartion
--------------------------------------------
-- Configure tmux helper
local tmux = require("config.tmux")

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


--------------------------------------------
-- Code folding (use lsp)
--------------------------------------------
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
-- vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldtext = "" -- ensure folded text keeps syntax highlighting

-- Enable folding but initially leave everything open.
vim.opt_local.foldenable = true
vim.opt_local.foldlevel = 99
