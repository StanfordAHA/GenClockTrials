module ClockController (
  input   wire        MASTER_CLK_0,
  input   wire        MASTER_CLK_1,
  input   wire        PORESETn,

  input   wire        MASTER_CLK_SELECT,
  input   wire [2:0]  DESIGN_CLK_SELECT,

  output  wire        DESIGN0_CLK,
  output  wire        DESIGN1_CLK
);

  // Master Clock Switch
  wire    master_clk;

  AhaClockSwitch2 u_clk_switch (
    .MASTER_CLK0        (MASTER_CLK_0),
    .MASTER_CLK1        (MASTER_CLK_1),
    .PORESETn           (PORESETn),

    .SELECT             (MASTER_CLK_SELECT),

    .CLK_OUT            (master_clk)
  );

  // Divided Clocks
  wire    gen_clk_by_1;
  wire    gen_clk_by_2;
  wire    gen_clk_by_4;
  wire    gen_clk_by_8;
  wire    gen_clk_by_16;
  wire    gen_clk_by_32;

  AhaClockDivider u_clk_div (
    .CLK_IN           (master_clk),
    .RESETn           (PORESETn),

    .CLK_by_1         (gen_clk_by_1),
    .CLK_by_1_EN      (),
    .CLK_by_2         (gen_clk_by_2),
    .CLK_by_2_EN      (),
    .CLK_by_4         (gen_clk_by_4),
    .CLK_by_4_EN      (),
    .CLK_by_8         (gen_clk_by_8),
    .CLK_by_8_EN      (),
    .CLK_by_16        (gen_clk_by_16),
    .CLK_by_16_EN     (),
    .CLK_by_32        (gen_clk_by_32),
    .CLK_by_32_EN     ()
  );

  // Dom0 Clock

  wire dom0_clk_free;
  wire dom0_clk_gated;

  AhaClockSelector u_clk_selector_dom0 (
    .CLK_by_1         (gen_clk_by_1),
    .CLK_by_1_EN      (1'b0),
    .CLK_by_2         (gen_clk_by_2),
    .CLK_by_2_EN      (1'b0),
    .CLK_by_4         (gen_clk_by_4),
    .CLK_by_4_EN      (1'b0),
    .CLK_by_8         (gen_clk_by_8),
    .CLK_by_8_EN      (1'b0),
    .CLK_by_16        (gen_clk_by_16),
    .CLK_by_16_EN     (1'b0),
    .CLK_by_32        (gen_clk_by_32),
    .CLK_by_32_EN     (1'b0),

    .RESETn           (PORESETn),
    .SELECT           (DESIGN_CLK_SELECT),

    .CLK_OUT          (dom0_clk_free),
    .CLK_EN_OUT       ()
  );

  AhaClockGate u_dom0_clock_gate (
    .TE     (1'b0),
    .E      (~MASTER_CLK_SELECT),
    .CP     (dom0_clk_free),
    .Q      (dom0_clk_gated)
  );

  // Dom1 Clock

  wire dom1_clk_free;
  wire dom1_clk_gated;

  AhaClockSelector u_clk_selector_dom1 (
    .CLK_by_1         (gen_clk_by_1),
    .CLK_by_1_EN      (1'b0),
    .CLK_by_2         (gen_clk_by_2),
    .CLK_by_2_EN      (1'b0),
    .CLK_by_4         (gen_clk_by_4),
    .CLK_by_4_EN      (1'b0),
    .CLK_by_8         (gen_clk_by_8),
    .CLK_by_8_EN      (1'b0),
    .CLK_by_16        (gen_clk_by_16),
    .CLK_by_16_EN     (1'b0),
    .CLK_by_32        (gen_clk_by_32),
    .CLK_by_32_EN     (1'b0),

    .RESETn           (PORESETn),
    .SELECT           (DESIGN_CLK_SELECT),

    .CLK_OUT          (dom1_clk_free),
    .CLK_EN_OUT       ()
  );

  AhaClockGate u_dom1_clock_gate (
    .TE     (1'b0),
    .E      (~MASTER_CLK_SELECT),
    .CP     (dom1_clk_free),
    .Q      (dom1_clk_gated)
  );


  assign DESIGN0_CLK  = dom0_clk_gated;
  assign DESIGN1_CLK  = dom1_clk_gated;

endmodule
