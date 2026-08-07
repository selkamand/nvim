---@brief
---
--- https://github.com/posit-dev/air
---
--- Air is an R formatter and language server, written in Rust.
---
--- Refer to the [documentation](https://posit-dev.github.io/air/editors.html) for more details.

---@type vim.lsp.Config
return {
  cmd = { 'air', 'language-server' },
  filetypes = { 'r' },
  root_markers = { 'air.toml', '.air.toml', '.git' },

  on_attach = function(_, bufnr)
    -- Setup autoformatting on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
