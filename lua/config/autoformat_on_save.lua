-- This code sets up an autocommand to format on save
-- The code was yoinked straight from the nvim help file (`help vim.lsp.buf.format`).
-- We dropped the autocomplete setup  from the help docs since we use blink.cmp plugin for autocomplete instead
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    ---------------------------------
    -- Auto-format ("lint") on save.
    ---------------------------------

    -- Skip formatting for R files (the air lsp already adds an autoformat command on attach)
    if vim.bo[ev.buf].filetype == 'r' then
      return
    end

    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
