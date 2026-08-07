---@class LspUtils
local M = {}

---Open LSP hover documentation for the symbol under the cursor
---in a vertical split to the right.
---
---Uses the first attached LSP client that supports
---`textDocument/hover`.
---
---The resulting buffer is:
--- - scratch-only
--- - Markdown
--- - non-modifiable
---
---@return nil
function M.hover_split()
  local bufnr = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()

  local clients = vim.lsp.get_clients({
    bufnr = bufnr,
    method = "textDocument/hover",
  })

  local client = clients[1]
  if not client then
    vim.notify("No LSP hover provider", vim.log.levels.WARN)
    return
  end

  local params = vim.lsp.util.make_position_params(
    win,
    client.offset_encoding
  )

  client:request("textDocument/hover", params, function(err, result)
    if err or not result or not result.contents then
      vim.notify("No hover information available")
      return
    end

    local lines =
        vim.lsp.util.convert_input_to_markdown_lines(result.contents)

    lines = vim.split(table.concat(lines, "\n"), "\n", {
      trimempty = true,
    })

    vim.schedule(function()
      local hover_buf = vim.api.nvim_create_buf(false, true)

      vim.api.nvim_buf_set_lines(
        hover_buf,
        0,
        -1,
        false,
        lines
      )

      vim.bo[hover_buf].filetype = "markdown"
      vim.bo[hover_buf].modifiable = false

      vim.api.nvim_open_win(hover_buf, true, {
        split = "right",
        win = win,
      })
    end)
  end, bufnr)
end

return M
