vim.keymap.set("n", "<leader>sr", function()
  vim.cmd("set splitright")
  vim.cmd("GrugFar")
end, { desc = "GrugFar (right side)" })
