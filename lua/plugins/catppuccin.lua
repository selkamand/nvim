-- Register the custom R Tree-sitter capture before the theme is loaded.
require("config.r_roxygen")

-- Choose flavour
require("catppuccin").setup({
  flavour = "macchiato",
  custom_highlights = function(colors)
    return {
      RustComment = { fg = colors.peach, style = { "bold" } },
      -- Built-in Rust syntax highlighting (active by default).
      rustCommentLine = { link = "RustComment" },
      rustCommentLineDoc = { link = "RustComment" },
      rustCommentBlock = { link = "RustComment" },
      rustCommentBlockDoc = { link = "RustComment" },
      -- Tree-sitter and LSP semantic highlighting, when enabled.
      ["@comment.rust"] = { link = "RustComment" },
      ["@comment.documentation.rust"] = { link = "RustComment" },
      ["@lsp.type.comment.rust"] = { link = "RustComment" },

      RNormalComment = { fg = colors.peach },
      RRoxygenText = { fg = colors.overlay2 },
      RRoxygenTag = { fg = colors.peach, style = { "bold" } },
      -- Built-in R syntax highlighting: peach comments, grey roxygen prose.
      rComment = { link = "RNormalComment" },
      rOBlock = { link = "RRoxygenText" },
      rOBlockNoTitle = { link = "RRoxygenText" },
      rOR6Block = { link = "RRoxygenText" },
      rOTitleBlock = { link = "RRoxygenText" },
      rOTitle = { link = "RRoxygenText" },
      rOCommentKey = { link = "RRoxygenText" },
      rOExamples = { link = "RRoxygenText" },
      rOTag = { link = "RRoxygenTag" },
      rOTitleTag = { link = "RRoxygenTag" },
      -- Tree-sitter and LSP semantic highlighting, when enabled.
      ["@comment.r"] = { link = "RNormalComment" },
      -- LSP comment tokens also cover roxygen prose, so leave their style to syntax/Tree-sitter.
      ["@lsp.type.comment.r"] = {},
      ["@roxygen.text.r"] = { link = "RRoxygenText" },
      ["@roxygen.tag.r"] = { link = "RRoxygenTag" },
    }
  end,
})

-- Set Colour scheme
vim.cmd.colorscheme "catppuccin-nvim"
