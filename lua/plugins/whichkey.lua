local wk = require("which-key")

wk.setup({
	preset = "helix"
})

wk.add({
  { "<leader>s", name = "Search" },
  { "<leader>d", name = "Diagnostics" },
  { "<leader>a", name = "Custom" },
})
