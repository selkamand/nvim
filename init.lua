----------------
-- Basic Settings
----------------
-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Add relative linenumbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Highlight current line
vim.opt.cursorline = true

-- Line wrapping
vim.opt.wrap = true

-- Smart indenting (aot-indent newlines in a context aware way)
vim.opt.smartindent = true

-- Opt into new neovim UI 
-- (improves commandline messages and pager: see https://neovim.io/doc/user/news-0.12/#_ui for details)
require('vim._core.ui2').enable()

-- Highlight yanked text
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "highlight_yank",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

----------------
-- Keymaps (universal)
----------------
-- Select all
vim.keymap.set("n", "<leader>aa", "ggVG", {desc = "Select all", noremap = true})
vim.keymap.set("v", "<leader>aa", "ggVG", {desc = "Select all", noremap = true})

----------------
-- Plugins
----------------
-- Setup package/plugin manager
-- We use the inbuilt plugin manager (vim.pack) released in v.0.12+
vim.pack.add({
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = 'main' },
	-- LuaSnp (snippets)
	{ src = "https://github.com/L3MON4D3/LuaSnip", version = 'v2.5.0' },
	-- WhichKey (popup which key you want to press)
	{ src = "https://github.com/folke/which-key.nvim", version = 'v3.17.0' },
	-- Catpuccin Theme
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin", version = "v2.0.0"  },
	-- Rustaceanvim (custom lsp config for rust)
	{ src = "https://github.com/mrcjkb/rustaceanvim", version = "v9.0.5" },
	-- Plenary (dependency of telescope)
	{ src = "https://github.com/nvim-lua/plenary.nvim", version = "v0.1.4" },
	-- Telescope (fuzzy finder)
	{ src = "https://github.com/nvim-telescope/telescope.nvim", version = "v0.2.2" },
})


-- CONFIGURE PLUGINS
-- Some plugins require configuration which we do here, often by calling a configuration lua script
-- from the lua/plugins directory
require("plugins.whichkey")
require("plugins.luasnip")
require("plugins.catppuccin")
require("plugins.telescope")

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
vim.lsp.enable('lua_ls')
vim.lsp.enable('nextflow_ls')
vim.lsp.enable('r_language_server')

-- We do not have to add a rust lsp because rustaceanvim handles it for us
