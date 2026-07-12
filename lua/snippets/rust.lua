-- Define local variables
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- impl Display snippet
  s(
    "disp",
    fmt(
      [[
impl std::fmt::Display for {} {{
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {{
        write!(f, "{}")
    }}
}}
]],
      {
        i(1, "TypeName"),
        i(2, "{}"),
      }
    )
  ),

  -- derive traits snippet
  s("drv", {
    t("#[derive("),
    i(1, "Debug, Clone, PartialEq, Eq"),
    t(")]"),
  }),

  -- iterator trait snippet
  s(
    "iterimpl",
    fmt(
      [[
impl<{R}> Iterator for {Type}<{R}> {{
    type Item = {Item};

    fn next(&mut self) -> Option<Self::Item> {{
        if self.{done_flag} {{
            return None;
        }}

        {body}

        None
    }}
}}
]],
      {
        R = i(1, "R"),
        Type = i(2, "MyIterator"),
        Item = i(3, "Result<T>"),
        done_flag = i(4, "done"),
        body = i(5, "// iterator logic here"),
      }
    )
  ),
}
