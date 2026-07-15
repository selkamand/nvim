local luasnip = require("luasnip")

luasnip.setup({
  -- Enable this only if you use autosnippets.
  enable_autosnippets = true,
})

require("luasnip.loaders.from_lua").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
})


