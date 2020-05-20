module Core (
  input   wire          MASTER_CLK_0,
  input   wire          MASTER_CLK_1,

  input   wire          PORESETn,

  input   wire          DATA_IN,

  // SSI
  output  wire          SSI_STROBE,
  output  wire          SSI_DATA
);

  wire        clk0_w;
  wire        reset0n_w;

  wire        clk1_w;
  wire        reset1n_w;

  wire        d_temp;

  wire        master_clk_select_w;
  wire [2:0]  design_clk_select_w;

  PlatformController u_platform_ctrl (
    .MASTER_CLK_0       (MASTER_CLK_0),
    .MASTER_CLK_1       (MASTER_CLK_1),

    .PORESETn           (PORESETn),

    .MASTER_CLK_SELECT  (master_clk_select_w),
    .DESIGN_CLK_SELECT  (design_clk_select_w),

    .DESIGN0_CLK        (clk0_w),
    .DESIGN0_RESETn     (reset0n_w),

    .DESIGN1_CLK        (clk1_w),
    .DESIGN1_RESETn     (reset1n_w)
  );

  BlockA u_block_a (
    .CLK                (clk0_w),
    .RESETn             (reset0n_w),

    .MASTER_CLK_SELECT  (master_clk_select_w),
    .DESIGN_CLK_SELECT  (design_clk_select_w),

    .DATA_IN            (d_temp),

    .DATA_OUT           (SSI_DATA),
    .STROBE_OUT         (SSI_STROBE)
  );

  BlockB u_block_b (
    .CLK                (clk1_w),
    .RESETn             (reset1n_w),
    .DATA_OUT           (d_temp),
    .DATA_IN            (DATA_IN)
  );

endmodule
