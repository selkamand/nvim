local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "roxy",
    fmt(
      [[
#' {}
#' 
#' {}
#' 
#' @return {}
#' 
#' @examples
#' {}
#' 
#' @export
]],
      {
        i(1, "title"),
        i(2, "description"),
        i(3, "return"),
        i(4, "example"),
      }
    )
  ),
  s(
    "func",
    fmt(
      [[
{} <- function({}) {{
  {}
}}
]],
      {
        i(1, "function_name"),
        i(2, ""),
        i(3, "# body"),
      }
    )
  ),
}
