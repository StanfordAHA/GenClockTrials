#-----------------------------------------------------------------------------
# Synopsys Design Constraint (SDC) File
#-----------------------------------------------------------------------------
# Purpose: Defining Design Clocks
#------------------------------------------------------------------------------
#
#
# Author   : Gedeon Nyengele
# Date     : May 9, 2020
#------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Clock Parameters
# ------------------------------------------------------------------------------
set clk_period_0                    ${dc_clock_period}
set clk_period_1                    1.0

set dom0_div_factor                 2
set dom1_div_factor                 2

# ------------------------------------------------------------------------------
# Create Master Clocks
# ------------------------------------------------------------------------------
create_clock -name master_clk_0 -period ${clk_period_0} \
    [get_ports $port_names(master_clk_0)]

create_clock -name master_clk_1 -period ${clk_period_1} \
    [get_ports $port_names(master_clk_1)]


# ------------------------------------------------------------------------------
# Muxed Master Clock
# ------------------------------------------------------------------------------
create_generated_clock -name m_clk_0 \
    -source [get_ports $port_names(master_clk_0)] \
    -divide_by 1 \
    -add \
    -master_clock master_clk_0 \
    [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_switch/CLK_OUT]


create_generated_clock -name m_clk_1 \
    -source [get_ports $port_names(master_clk_1)] \
    -divide_by 1 \
    -add \
    -master_clock master_clk_1 \
    [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_switch/CLK_OUT]

# These clocks are exclusive (no timing paths between them)
set_clock_groups -logically_exclusive -group {m_clk_0} -group {m_clk_1}

# ------------------------------------------------------------------------------
# Divided Clocks
# ------------------------------------------------------------------------------
set clk_div_list  [list 1 2 4 8 16 32]

foreach idx $clk_div_list {
  create_generated_clock -name by_${idx}_clk \
      -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_switch/CLK_OUT] \
      -divide_by ${idx} \
      [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_div/CLK_by_${idx}]
}
