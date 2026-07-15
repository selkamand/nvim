local blink = require("blink.cmp")

-- Build Blink's native fuzzy matcher.
-- Requires Rust and Cargo to be installed.

blink.setup({
  snippets = {
    preset = "luasnip",
  },

  keymap = {
    -- Ctrl-y accepts a completion.
    preset = "enter",
  },

  completion = {
    menu = {
      border = "rounded",

      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
        },
      },
    },

    documentation = {
      auto_show = true,
      auto_show_delay_ms = 300,

      window = {
        border = "rounded",
      },
    },

    ghost_text = {
      enabled = true,
    },
  },

  signature = {
    enabled = true,

    window = {
      border = "rounded",
    },
  },

  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },
  },

  fuzzy = {
    implementation = "rust",
  },
})
