local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node

return {
  s("nxfmain", {
    t(vim.split(
      [[
nextflow.enable.dsl=2

params {
    input: Path
    outdir: Path = "results"
}

include { PROCESS_1; PROCESS_2 } from 'modules/local/module1.nf'

workflow {

    main:
    ch_inputs = channel
        .fromPath(params.input)

    ch_out = PROCESS_1(ch_inputs)

    publish:
    output1 = ch_out
}

output {
  output1 {
    path "${params.outdir}/output1/"
    mode 'copy'
  }
}
]],
      "\n"
    )),
  }),

  s("nxfmodule", {
    t(vim.split(
      [[
process MY_PROCESS {
    tag "{meta.id}"

    input:
    tuple val(meta), path(input_file)

    output:
    tuple val(meta), path("output.txt"), emit: result

    script:
    """
    set -euo pipefail

    your_command "$input_file" > output.txt
    """
}
]],
      "\n"
    )),
  }),
}
