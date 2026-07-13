local M = {}

---@class TmuxOptions
---@field target? string Tmux target pane, such as `"{top-right}"`
---@field press_enter? boolean Whether to press Enter after sending text

---@type TmuxOptions
local config = {
  target = "{top-right}",
  press_enter = true,
}

---Configure the default tmux target and sending behaviour.
---@param opts? TmuxOptions
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
end

---Send literal text to a tmux pane.
---
---Uses the configured defaults unless overridden by `opts`.
---@param text string Text to send
---@param opts? TmuxOptions Per-call configuration overrides
function M.send(text, opts)
  if not text or text == "" then
    vim.notify("No code found", vim.log.levels.WARN)
    return
  end

  opts = opts or {}

  local target = opts.target or config.target
  local press_enter = opts.press_enter

  if press_enter == nil then
    press_enter = config.press_enter
  end

  local output = vim.fn.system({
    "tmux",
    "send-keys",
    "-t",
    target,
    "-l",
    "--",
    text,
  })

  if vim.v.shell_error ~= 0 then
    vim.notify(output, vim.log.levels.ERROR)
    return
  end

  if press_enter then
    vim.fn.system({
      "tmux",
      "send-keys",
      "-t",
      target,
      "Enter",
    })
  end
end


-- ---Create a keymap that obtains text and sends it to tmux.
-- ---@param mode string|string[] Neovim keymap mode or modes
-- ---@param lhs string Key sequence
-- ---@param get_text fun(): string? Function that returns the text to send
-- ---@param description string Keymap description
-- ---@param opts? TmuxOptions Per-mapping tmux options
-- function M.map_send(mode, lhs, get_text, description, opts)
--   vim.keymap.set(mode, lhs, function()
--     M.send(get_text(), opts)
--   end, {
--   desc = description,
--   silent = true,
-- })
-- end
--

---Return the active Visual-mode selection.
---@return string selection
function M.visual_selection()
  return table.concat(
    vim.fn.getregion(
      vim.fn.getpos("v"),
      vim.fn.getpos("."),
      { type = vim.fn.mode() }
    ),
    "\n"
  )
end

---Return the entire current buffer.
---@return string contents
function M.entire_buffer()
  return table.concat(
    vim.api.nvim_buf_get_lines(0, 0, -1, false),
    "\n"
  )
end

---Return the current line.
---@return string line
function M.current_line()
  return vim.api.nvim_get_current_line()
end

return M
