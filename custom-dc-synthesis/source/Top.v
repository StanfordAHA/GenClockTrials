module Top (
  input   wire          MASTER_CLK_0,
  input   wire          MASTER_CLK_1,

  input   wire          PORESETn,

  input   wire          DATA_IN,

  // SSI
  output  wire          SSI_STROBE,
  output  wire          SSI_DATA
);

  Core u_core (
    .MASTER_CLK_0       (MASTER_CLK_0),
    .MASTER_CLK_1       (MASTER_CLK_1),

    .PORESETn           (PORESETn),

    .DATA_IN            (DATA_IN),

    .SSI_STROBE         (SSI_STROBE),
    .SSI_DATA           (SSI_DATA)
  );

endmodule
