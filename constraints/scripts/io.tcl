#-----------------------------------------------------------------------------
# Synopsys Design Constraint (SDC) File
#-----------------------------------------------------------------------------
# Purpose: Source-Sync Interface Constraints
#------------------------------------------------------------------------------
#
# Author   : Gedeon Nyengele
# Date     : May 8, 2020
#------------------------------------------------------------------------------

# DATA_IN
set_input_delay -max [expr ${clk_period_1} * 0.4] -clock [get_clocks dom1_gclk] \
    [get_ports $port_names(data_in)]

set_input_delay -add_delay -min 0.2 -clock [get_clocks dom1_gclk] \
    [get_ports $port_names(data_in)]


# PORESETn
set_input_delay -max [expr ${clk_period_1} * 2] -clock [get_clocks master_clk_1] \
    [get_ports $port_names(poreset_n)]

set_input_delay -add_delay -min 0.2 -clock [get_clocks master_clk_1] \
    [get_ports $port_names(poreset_n)]


set_multicycle_path -setup -end -from [get_ports $port_names(poreset_n)] 5
set_multicycle_path -hold -end -from [get_ports $port_names(poreset_n)] 4

# outputs
set_output_delay -max 0.250 -clock [get_clocks strobe] [get_ports $port_names(data_out)]
set_output_delay -add_delay -min -0.250 -clock [get_clocks strobe] [get_ports $port_names(data_out)]

set_false_path -setup -rise_from [get_clocks dom0_gclk] -fall_to [get_clocks strobe]
set_false_path -setup -fall_from [get_clocks dom0_gclk] -rise_to [get_clocks strobe]

set_false_path -hold -rise_from [get_clocks dom0_gclk] -fall_to [get_clocks strobe]
set_false_path -hold -fall_from [get_clocks dom0_gclk] -rise_to [get_clocks strobe]
