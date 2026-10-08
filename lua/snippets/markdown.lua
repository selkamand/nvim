local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("devwarn", {
    t({
      "> [!WARNING]",
      "> This tool is in early development and is not yet ready for use.",
    }),
  }),
}
