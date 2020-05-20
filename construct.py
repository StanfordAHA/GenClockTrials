#! /usr/bin/env python
#=========================================================================
# construct.py
#=========================================================================
# Author :
# Date   :
#

import os
import sys

from mflowgen.components import Graph, Step

def construct():

  g = Graph()

  #-----------------------------------------------------------------------
  # Parameters
  #-----------------------------------------------------------------------

  adk_name = 'tsmc16'
  adk_view = 'stdview'

  parameters = {
    'construct_path'    : __file__,
    'design_name'       : 'Top',
    'clock_period'      : 2.0,
    'adk'               : adk_name,
    'adk_view'          : adk_view,
    # Synthesis
    'flatten_effort'    : 1,
    'topographical'     : False,
    # RTL Generation
    'array_width'       : 32,
    'array_height'      : 16,
    'interconnect_only' : False,
    # Don't touch this parameter
    'soc_only'          : False,
    # SRAM macros
    'num_words'      : 2048,
    'word_size'      : 64,
    'mux_size'       : 8,
    'corner'         : "tt0p8v25c",
    'partial_write'  : True,
    # Low Effort flow
    'express_flow' : False,
    'nthreads'      : 8
  }

  #-----------------------------------------------------------------------
  # Create nodes
  #-----------------------------------------------------------------------

  this_dir = os.path.dirname( os.path.abspath( __file__ ) )

  # ADK step

  g.set_adk( adk_name )
  adk = g.get_adk_step()

  # Custom steps

  constraints    = Step( this_dir + '/constraints'                         )
  dc             = Step( this_dir + '/custom-dc-synthesis'                 )
  custom_init    = Step( this_dir + '/custom-init'                         )

  # Default steps

  info         = Step( 'info',                          default=True )
  iflow        = Step( 'cadence-innovus-flowsetup',     default=True )
  init         = Step( 'cadence-innovus-init',          default=True )

  #-----------------------------------------------------------------------
  # Graph -- Add nodes
  #-----------------------------------------------------------------------

  g.add_step( info              )
  g.add_step( constraints       )
  g.add_step( dc                )
  g.add_step( iflow             )
  g.add_step( custom_init       )
  g.add_step( init              )

  #-----------------------------------------------------------------------
  # Graph -- Add edges
  #-----------------------------------------------------------------------

  # Connect by name
  g.connect_by_name( adk,      dc           )
  g.connect_by_name( adk,      iflow        )
  g.connect_by_name( adk,      init         )

  g.connect_by_name( constraints,   dc        )

  g.connect_by_name( dc,       iflow        )
  g.connect_by_name( dc,       init         )

  g.connect_by_name( iflow,    init         )
  g.connect_by_name( custom_init,    init   )


  #-----------------------------------------------------------------------
  # Parameterize
  #-----------------------------------------------------------------------

  g.update_params( parameters )

  # Since we are adding an additional input script to the generic Innovus
  # steps, we modify the order parameter for that node which determines
  # which scripts get run and when they get run.


  return g


if __name__ == '__main__':
  g = construct()
#  g.plot()
