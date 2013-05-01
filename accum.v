module accum
  (input                    clk,
   input                    rst_b,
   input                    din_en,
   input signed [7:0]       din,
   output reg signed [15:0] dout
   );

  parameter signed [15:0] MaxBound = 16'sh7fff;
  parameter signed [15:0] MinBound = -16'sh7fff;

  wire signed [16:0] sum = dout + din;

  always_ff @(posedge clk or negedge rst_b)
    if (~rst_b)
      dout <= 16'h0000;
    else if (din_en)
      if (sum < MinBound)
        dout <= MinBound;
      else if (sum > MaxBound)
        dout <= MaxBound;
      else
        dout <= sum;

endmodule
