-- The R Tree-sitter parser treats each roxygen line as one comment node.
-- Narrow the tag capture to just the @name so prose can use a separate colour.
vim.treesitter.query.add_directive("roxygen-tag-range!", function(match, _, source, predicate, metadata)
  local capture = predicate[2]
  local nodes = match[capture]
  if not nodes or not nodes[1] then
    return
  end

  local node = nodes[1]
  local text = vim.treesitter.get_node_text(node, source)
  local prefix = text:match("^#+%s*'%s*")
  local tag = prefix and text:sub(#prefix + 1):match("^@[%a_][%w_]*")
  if not tag then
    return
  end

  local row, col = node:range()
  metadata[capture] = metadata[capture] or {}
  metadata[capture].range = { row, col + #prefix, row, col + #prefix + #tag }
end, { force = true })
