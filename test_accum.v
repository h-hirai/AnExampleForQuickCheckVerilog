module test_accum;
  timeunit 1ns;
  timeprecision 1ns;

  logic              clk;
  logic              rst_b;
  logic              din_en;
  logic signed [7:0] din;
  wire signed [15:0] dout;

  accum dut(.*);

  initial begin
    rst_b = 1'b1;
    clk = 1'b1;
    forever
      #(20ns) clk = ~clk;
  end

  import "DPI-C" context task c_main();
  initial begin
    repeat (3) @(posedge clk);
    c_main();

    $finish;
  end

  export "DPI-C" task reset;
  export "DPI-C" task v_write_data;

  task reset();
    @(negedge clk);
    rst_b = 1'b0;
    @(negedge clk);
    rst_b = 1'b1;
    @(posedge clk);
  endtask

  task v_write_data(input byte signed wr_data, inout int signed rd_data);
    @(posedge clk);
    #(1ns);
    din_en = 1'b1;
    din = wr_data;
    @(posedge clk);
    #(1ns);
    din_en = 1'b0;
    @(posedge clk);
    #(1ns);
    rd_data = dout;
  endtask

endmodule
