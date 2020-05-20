module BlockA (
  input   wire        CLK,
  input   wire        RESETn,

  output  wire        MASTER_CLK_SELECT,
  output  wire [2:0]  DESIGN_CLK_SELECT,

  input   wire        DATA_IN,

  output  wire        DATA_OUT,
  output  wire        STROBE_OUT
);

  reg   stage0;
  reg   stage1;
  reg   stage2;

  always @(posedge CLK or negedge RESETn) begin
    if(~RESETn) begin
      stage0  <= 1'b0;
      stage1  <= 1'b0;
      stage2  <= 1'b0;
    end else begin
      stage0  <= DATA_IN;
      stage1  <= stage0;
      stage2  <= stage1;
    end
  end


  assign DATA_OUT   = stage2;
  assign STROBE_OUT = ~CLK;

  assign MASTER_CLK_SELECT  = stage1;
  assign DESIGN_CLK_SELECT  = {stage2, stage1, stage0};

endmodule
