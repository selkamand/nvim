local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("nxfmain", {
    t(vim.split(
      [[
nextflow.enable.dsl=2

params {
    input: Path
    outdir: Path = "results"
}

include { PROCESS_1; PROCESS_2 } from './modules/local/module1.nf'

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

  s("nxfprocess", {
    t(vim.split(
      [[
process MY_PROCESS {
    tag "${meta.id}"

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
  s("nxfinclude", {
    t(vim.split(
      [[
include { PROCESS_1; PROCESS_2; PROCESS_3 } from './modules/local/module1.nf'

// With aliasing (recommended when reusing modules)
include { PROCESS_1 as STEP_A; PROCESS_2 as STEP_B } from './modules/local/module1.nf'
]],
      "\n"
    )),
  }),
  s("nxfshebang", {
    t(vim.split(
      [[
#!/usr/bin/env nextflow

]],
      "\n"
    )),
  }),
  s(
    "nxfparsesamplesheet",
    fmt(
      [[
ch_{channel} = channel.fromPath({manifest})
    // Read the manifest as CSV and expose each row as a map
    .splitCsv(header: true)

    // Convert each manifest row into the tuple structure expected downstream
    .map {{ row ->
        // Pull required columns out of the row
        def sample = row.{sample_col} as String
        def r1 = file(row.{r1_col} as String)
        def r2 = file(row.{r2_col} as String)

        // Validate required sample identifier
        if (!sample) {{
            error("Missing {sample_col} column in manifest row: ${{row}}")
        }}

        // Validate input files exist before running any processes
        if (!r1.exists()) {{
            error("File not found for sample ${{sample}}: ${{r1}}")
        }}
        if (!r2.exists()) {{
            error("File not found for sample ${{sample}}: ${{r2}}")
        }}

        // Emit a standard tuple:
        //   meta map first, then one or more files
        // This is a common shape for DSL2 module inputs
        tuple([id: sample], r1, r2)
    }}
]],
      {
        channel = i(1, "samples"),
        manifest = i(2, "params.input"),
        sample_col = i(3, "sample"),
        r1_col = i(4, "r1"),
        r2_col = i(5, "r2"),
      }
    )
  ),
  s("nxftyped", {
    t(vim.split(
      [[
nextflow.enable.types = true
]],
      "\n"
    )),
  }),
  s("nxfworkflowtyped", {
    t(vim.split(
      [[
nextflow.enable.dsl=2
nextflow.enable.types = true

workflow greet {
    take:
    greetings: Channel<String>

    main:
    messages = greetings.map { v -> "$v world!" }

    emit:
    messages: Channel<String>
}
]],
      "\n"
    )),
  }),
  s("nxfprocesstyped", {
    t(vim.split(
      [[
nextflow.enable.types = true

process FASTQC {
    tag id
    conda 'bioconda::fastqc=0.12.1'

    input:
    record(
        id: String,
        fastq_1: Path,
        fastq_2: Path
    )

    output:
    record(
        id: id,
        fastqc: file("fastqc_${id}_logs")
    )

    script:
    """
    fastqc.sh "${id}" "${fastq_1} ${fastq_2}"
    """
}
]],
      "\n"
    )),
  }),
  s("nxfrecordtype", {
    t(vim.split(
      [[
record FastqPair {
    id: String
    fastq_1: Path
    fastq_2: Path
}
]],
      "\n"
    )),
  }),
}
