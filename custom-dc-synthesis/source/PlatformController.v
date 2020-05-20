module PlatformController (
  input   wire          MASTER_CLK_0,
  input   wire          MASTER_CLK_1,
  input   wire          PORESETn,

  input   wire          MASTER_CLK_SELECT,
  input   wire [2:0]    DESIGN_CLK_SELECT,

  output  wire          DESIGN0_CLK,
  output  wire          DESIGN0_RESETn,

  output  wire          DESIGN1_CLK,
  output  wire          DESIGN1_RESETn
);

  wire    design0_clk_w;
  wire    design1_clk_w;

  ClockController u_clk_ctrl (
    .MASTER_CLK_0       (MASTER_CLK_0),
    .MASTER_CLK_1       (MASTER_CLK_1),
    .PORESETn           (PORESETn),

    .MASTER_CLK_SELECT  (MASTER_CLK_SELECT),
    .DESIGN_CLK_SELECT  (DESIGN_CLK_SELECT),

    .DESIGN0_CLK        (design0_clk_w),
    .DESIGN1_CLK        (design1_clk_w)
  );

  ResetController u_rst_ctrl (
    .DESIGN0_CLK        (design0_clk_w),
    .DESIGN1_CLK        (design1_clk_w),

    .PORESETn           (PORESETn),

    .DESIGN0_RESETn     (DESIGN0_RESETn),
    .DESIGN1_RESETn     (DESIGN1_RESETn)
  );


  assign  DESIGN0_CLK = design0_clk_w;
  assign  DESIGN1_CLK = design1_clk_w;

endmodule
