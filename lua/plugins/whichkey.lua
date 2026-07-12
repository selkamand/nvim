local wk = require("which-key")

wk.setup({
	preset = "helix"
})

wk.add(
  -- group names
  { "<leader>s", group = "Search" },
  { "<leader>a", group = "Custom" }
)
