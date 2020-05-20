set design_files [glob -nocomplain -directory source -types f *.v ]


if { ![analyze  -format sverilog $design_files] } { exit 1 }


if {[file exists [which setup-design-params.txt]]} {
  elaborate $dc_design_name -file_parameters setup-design-params.txt
  rename_design $dc_design_name* $dc_design_name
} else {
  elaborate $dc_design_name
}
