local wk = require("which-key")

wk.setup({
	preset = "helix"
})

wk.add({
  { "<leader>s", name = "Search" },
  { "<leader>d", name = "Diagnostics" },
  { "<leader>e", name = "Editor" },
  { "<leader>a", name = "Custom" },
  { "<leader>c", name = "Code", mode = "v" },
})
