return {
  {
    "nvim-mini/mini.pairs",
    opts = function(_, opts)
      opts.mappings = opts.mappings or {}
      opts.mappings['"'] = false
      opts.mappings["'"] = false
    end,
  },
}
