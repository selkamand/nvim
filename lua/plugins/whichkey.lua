local wk = require("which-key")

wk.setup({
	preset = "helix"
})

wk.add({
  { "<leader>s", name = "Search" },
  { "<leader>f", name = "Find" },
  { "<leader>d", name = "Diagnostics" },
  { "<leader>b", name = "Buffers" },
  { "<leader>g", name = "Git" },
  { "<leader>e", name = "Editor" },
  { "<leader>a", name = "Custom" },
  { "<leader>c", name = "Code", mode = "v" },
})
