local ls = require("luasnip")

local snippet_dir = vim.fn.stdpath("config") .. "/lua/snippets" -- string
-- print("snippet dir = " .. snippet_dir)

require("luasnip.loaders.from_lua").load({
  paths = { snippet_dir },  -- table of paths
  include = ".*%.lua",
})
