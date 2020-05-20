module ResetController (
  input   wire      DESIGN0_CLK,
  input   wire      DESIGN1_CLK,

  input   wire      PORESETn,

  output  wire      DESIGN0_RESETn,
  output  wire      DESIGN1_RESETn
);

  AhaResetSync u_dom0_rst_sync (
    .CLK            (DESIGN0_CLK),
    .Dn             (PORESETn),
    .Qn             (DESIGN0_RESETn)
  );

  AhaResetSync u_dom1_rst_sync (
    .CLK            (DESIGN1_CLK),
    .Dn             (PORESETn),
    .Qn             (DESIGN1_RESETn)
  );
  
endmodule
