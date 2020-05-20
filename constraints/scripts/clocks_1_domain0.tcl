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
# Domain 0
# ------------------------------------------------------------------------------

# Create Selection Clocks
foreach idx $clk_div_list {
  create_generated_clock -name dom0_by_${idx}_clk \
      -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_div/CLK_by_${idx}] \
      -divide_by 1 \
      -add \
      -master_clock by_${idx}_clk \
      [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_selector_dom0/CLK_OUT]
}

create_generated_clock -name dom0_gclk \
    -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_selector_dom0/CLK_OUT] \
    -divide_by 1 \
    -master_clock dom0_by_${dom0_div_factor}_clk \
    [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_dom0_clock_gate/Q]



# ------------------------------------------------------------------------------
# Source-Synchronous Interface Clock
# ------------------------------------------------------------------------------
create_generated_clock -name strobe \
    -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_dom0_clock_gate/Q] \
    -divide_by 1 \
    -invert \
    [get_ports $port_names(strobe)]
