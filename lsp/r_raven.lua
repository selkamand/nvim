---@brief
---
--- [raven](https://github.com/jbearak/raven/tree/main) is an
--- implementation of the Microsoft's Language Server Protocol for the R
--- language. Unlike the more commonly used r_language_server it does static analysis
--- and is not dependent on an R session running in the background.
--- This makes it feel very snappy

---@type vim.lsp.Config
return {
  name = "raven",
  cmd = { "raven", "--stdio" },
  filetypes = { "r", "rmd", "quarto" },
  root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
  settings = {
    raven = {
      -- indentation = {
      --   enabled = true,
      --   argumentStyle = "aligned",
      --   infixContinuationStyle = "indented",
      -- },
      -- linting = {
      --   infixContinuationStyle = "indented",
      -- },
      -- chunks = {
      --   activeCellIndicator = true
      -- }
    },
  },
}
