return {
  {
    "jpalardy/vim-slime",
    lazy = false,
    init = function()
      -- Tell slime to use tmux
      vim.g.slime_target = "tmux"

      -- Do not prompt every time
      vim.g.slime_dont_ask_default = 1

      -- Default tmux target
      -- These must match your tmux session/window/pane
      vim.g.slime_default_config = {
        socket_name = "default",
        target_pane = "{top-right}",
      }

      -- Better paste behavior for R
      vim.g.slime_bracketed_paste = 1
    end,
  },
}
