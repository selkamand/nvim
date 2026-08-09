---@brief
---
--- The ry formatter (https://github.com/felix-andreas/ry)
---
--- [languageserver](https://github.com/REditorSupport/languageserver) is an
--- implementation of the Microsoft's Language Server Protocol for the R
--- language.
---

---@type vim.lsp.Config
return {
  cmd = { 'ry', 'server', },
  filetypes = { 'r' },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, '.git') or vim.uv.os_homedir())
  end,
  on_attach = function(client, bufnr)
    -- Turn off autoformatting by LSP (we'll use air to autoformat instead)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}
