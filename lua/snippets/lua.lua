local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("fun", {
    i(1, "name"),
    t(" <- function("),
    i(2),
    t({
      ") {",
      "  ",
    }),
    i(3),
    t({
      "",
      "}",
    }),
  }),
}
