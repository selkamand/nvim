return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",         -- all filetypes
        css = { rgb_fn = true },
        html = { rgb_fn = true },
      }, {
        mode = "background",   -- highlight background
        tailwind = false,
      })
    end,
  },
}