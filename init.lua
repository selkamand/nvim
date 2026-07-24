----------------
-- Basic Settings
----------------
-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight current line
vim.opt.cursorline = true

-- Line wrapping
vim.opt.wrap = false

-- Tabs
vim.opt.expandtab = true -- expand tabs to spaces
vim.opt.shiftwidth = 2   -- indent step size (2 spaces)
vim.opt.tabstop = 2      -- How many columns a literal tab char is treated as

-- Smart indenting (aot-indent newlines in a context aware way)
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Opt into new neovim UI
-- (improves commandline messages and pager: see https://neovim.io/doc/user/news-0.12/#_ui for details)
require('vim._core.ui2').enable()

-- Rounded borders for floating windows.
vim.o.winborder = "rounded"

----------------
-- Gutter Settings
----------------
-- Always show the signcolumn to prevent the screen from shifting when diagnostics appear
vim.opt.signcolumn = "yes"

-- Always show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

----------------
-- Yanking Settings
----------------
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "highlight_yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

----------------
-- Folding behaviour
----------------
-- Enable folding, but initially show everything
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Use treesitter to identify folds
vim.opt.foldtext = "getline(v:foldstart)"
vim.opt.fillchars:append({
  fold = " ",
})

----------------
-- Diagnostics
----------------
-- Configure how diagnostics (Error messages and Warnings) be displayed
vim.diagnostic.config({
  virtual_text = {
    -- show only on the line (inline) and not as a separate sign
    spacing = 2,
    prefix = "●",
    -- show for all severities you care about (you can filter further)
    severity = {
      min = vim.diagnostic.severity.WARN, -- show WARN/ERROR/INFO/HINT as well
    },
    -- source = "if you want: lsp" (optional)
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

----------------
-- Keymaps (universal)
----------------
-- Select all
vim.keymap.set("n", "<leader>aa", function() vim.cmd("normal! ggVG") end, { desc = "Select all" })

-- Editor Config Keybinds
-- Linewrapping
vim.keymap.set("n", "<leader>ew", "<cmd>set wrap!<CR>", { desc = "Toggle line wrap" })

-- Codetools
-- Open diagnostics
vim.keymap.set('n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = "Open diagnostic" })
-- Code action
vim.keymap.set('n', "<leader>ca", '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = "Code action" })
-- Rename Symbol under cursor (requires LSP rename support)
vim.keymap.set("n", "<leader>cr", function() vim.lsp.buf.rename() end, { desc = "LSP: Rename symbol" })
-- Run codelens command
vim.keymap.set('n', "<leader>c.", function() vim.lsp.codelens.run() end, { desc = "Code lens" })

----------------
-- Tmux Keymaps
----------------
-- Configure tmux helper
local tmux = require("config.tmux")

tmux.setup({
  target = "{top-right}", -- which pane to send code to
  press_enter = true
})

-- Send selection to tmux
vim.keymap.set('v', "<leader>cc", function() tmux.send(tmux.visual_selection()) end,
  { desc = "Send selection to tmux", noremap = true, silent = true })

-- Send current line to tmux (and step down one line
vim.keymap.set('n', "<leader>cc", function()
  tmux.send(tmux.current_line())
  vim.cmd('normal! j');
end, { desc = "Send line to tmux", noremap = true, silent = true })

-- Send full buffer to tmux
vim.keymap.set({ 'n', 'v' }, "<leader>cb", function() tmux.send(tmux.entire_buffer()) end,
  { desc = "Send buffer to tmux", noremap = true, silent = true })

----------------
-- Plugins
----------------
-- Setup package/plugin manager
-- We use the inbuilt plugin manager (vim.pack) released in v.0.12+
vim.pack.add({
  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
  -- LuaSnp (snippets)
  { src = "https://github.com/L3MON4D3/LuaSnip",                version = 'v2.5.0' },
  -- WhichKey (popup which key you want to press)
  { src = "https://github.com/folke/which-key.nvim",            version = 'v3.17.0' },
  -- Catpuccin Theme
  { src = "https://github.com/catppuccin/nvim",                 name = "catppuccin", version = "v2.0.0" },
  -- Mini icons (used by lots of downstream plugins including oil)
  { src = "https://github.com/nvim-mini/mini.icons",            version = "v0.18.0" },
  -- Rustaceanvim (custom lsp config for rust)
  { src = "https://github.com/mrcjkb/rustaceanvim",             version = "v9.0.5" },
  -- Snacks (loads of QOL features)
  { src = "https://github.com/folke/snacks.nvim",               version = "v2.31.0" },
  -- Fast nice autocompletion
  { src = "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/saghen/blink.cmp",                version = "v1.10.2" },
  -- Mini.ai  adds keybinds like vai (select around scope)
  { src = "https://github.com/nvim-mini/mini.ai",               version = "v0.18.0" },
  -- Gitsigns for git changes in gutter
  { src = "https://github.com/lewis6991/gitsigns.nvim",         version = "v2.1.0" },
  -- Grug-Far for rg powered find and replace
  { src = "https://github.com/MagicDuck/grug-far.nvim",         version = "1.6.75" }
})


-- CONFIGURE PLUGINS
-- Some plugins require configuration which we do here, often by calling a configuration lua script
-- from the lua/plugins directory
require("plugins.catppuccin")
require("plugins.whichkey")
require("plugins.luasnip")
require("plugins.snacks")
require("plugins.grugfar")
require("plugins.blink")

----------------
-- LSPs
----------------
-- Enable and configure the LSPs we want to use.
-- neovim 0.12+ will look for the language server configuration files in the `lsp` folder).
-- These config file are what tells neovim what the CLI command to use to startup the server,
-- what arguments to provide, and how to know which filetypes to use it for.
--
-- To add a new lsp config file without writing it from scratch, just grab it from:
-- [`https://github.com/neovim/nvim-lspconfig/tree/master/lsp`] and add to the lsp folder
-- then enable it below
--
-- Note you still have to install the language server tool manually (or via Mason, but we recommend manual installation). See the readme for instructions on how to install common language servers
--
-- Also note some of these will add keymaps (search plugin file for vim.keymap.set to see those keybinds)
vim.lsp.enable('lua_ls')
vim.lsp.enable('nextflow_ls')
vim.lsp.enable('r_language_server')

-- We do not have to add a rust lsp because rustaceanvim handles it for us

-- Autoformat on save (LSP controls formatting)
require("config.autoformat_on_save")

-- Enable codelens (commands appearing near the code)
vim.lsp.codelens.enable(true)

----------------
-- Filetype Detection
----------------
-- Filetype detection rules

-- Nextflow
vim.filetype.add({
  extension = {
    nf = "nextflow",
  },
})
