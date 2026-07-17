local bufnr = vim.api.nvim_get_current_buf()
local tmux = require("config.tmux")
local config = tmux.setup({target="{top-right}", press_enter=true});

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })


------------------------
-- Rust specific keymaps
------------------------

-- Rustaceanvim specific code actions
vim.keymap.set(
  "n", "<leader>ca",
  function() vim.cmd.RustLsp('codeAction') end, -- supports rust-analyzer's grouping
  { desc = "Code actions (rustaceanvim)", silent = true, buffer = bufnr }
)

-- Rustaceanvim specific hover actions
vim.keymap.set(
  "n",
  "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
  function()
    vim.cmd.RustLsp({'hover', 'actions'})
  end,
  { silent = true, buffer = bufnr }
)

-- Cargo run current project
vim.keymap.set({ 'n' }, "<leader>ce", function() tmux.send("cargo run", config) end, {desc = "Cargo run", noremap = true, silent = true })
vim.keymap.set({ 'n' }, "<leader>cC",function() tmux.send("cargo check", config) end, {desc = "Cargo test", noremap = true, silent = true })
vim.keymap.set({ 'n' }, "<leader>cT",function() tmux.send("cargo test", config) end, {desc = "Cargo test", noremap = true, silent = true })
vim.keymap.set({ 'n' }, "<leader>cB",function() tmux.send("bacon", config) end, {desc = "Bacon", noremap = true, silent = true })

---------------
-- Rust formatting
----------------
local rust_format_group =
  vim.api.nvim_create_augroup("rust_format_on_save", { clear = true })

