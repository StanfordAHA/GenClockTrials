#-----------------------------------------------------------------------------
# Synopsys Design Constraint (SDC) File
#-----------------------------------------------------------------------------
# Purpose: Design Info Variables
#------------------------------------------------------------------------------
#
#
# Author   : Gedeon Nyengele
# Date     : May 9, 2020
#------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Define Port Names
# ------------------------------------------------------------------------------

# Inputs
set port_names(master_clk_0)      "MASTER_CLK_0"
set port_names(master_clk_1)      "MASTER_CLK_1"
set port_names(poreset_n)         "PORESETn"
set port_names(data_in)           "DATA_IN"

# Outputs
set port_names(strobe)            "SSI_STROBE"
set port_names(data_out)          "SSI_DATA"


# ------------------------------------------------------------------------------
# Clock and Reset Port Names
# ------------------------------------------------------------------------------

set clock_ports   [list $port_names(master_clk_0) $port_names(master_clk_1)]
