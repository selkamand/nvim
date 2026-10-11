local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("shebang", t("#!/usr/bin/env bash")),

  s("scriptdir", t('SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"')),

  s("callerdir", t('CALLER_DIR="$PWD"')),
}
