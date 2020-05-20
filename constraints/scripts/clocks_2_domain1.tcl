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
# Domain 1
# ------------------------------------------------------------------------------

# Create Selection Clocks
foreach idx $clk_div_list {
  create_generated_clock -name dom1_by_${idx}_clk \
      -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_div/CLK_by_${idx}] \
      -divide_by 1 \
      -master_clock by_${idx}_clk \
      -add \
      [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_selector_dom1/CLK_OUT]
}

create_generated_clock -name dom1_gclk \
    -source [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_clk_selector_dom1/CLK_OUT] \
    -divide_by 1 \
    -master_clock dom1_by_${dom1_div_factor}_clk \
    [get_pins u_core/u_platform_ctrl/u_clk_ctrl/u_dom1_clock_gate/Q]
