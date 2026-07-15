local luasnip = require("luasnip")

luasnip.setup({
  -- Enable this only if you use autosnippets.
  enable_autosnippets = true,
})

-- Load R snippets in rmd and quarto
luasnip.filetype_extend("rmd", { "r" })
luasnip.filetype_extend("quarto", { "r" })

require("luasnip.loaders.from_lua").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
})


