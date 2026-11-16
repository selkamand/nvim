; extends
; LSP comment semantic tokens use priority 125, so roxygen must take precedence.

((comment) @roxygen.text
  (#lua-match? @roxygen.text "^#+'")
  (#set! priority 126))

((comment) @roxygen.tag
  (#lua-match? @roxygen.tag "^#+'%s*@[A-Za-z_][A-Za-z0-9_]*")
  (#roxygen-tag-range! @roxygen.tag)
  (#set! priority 127))
