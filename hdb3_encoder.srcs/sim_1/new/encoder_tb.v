//`timescale 1ns / 1ps
//// =============================================================================
//// Filename: encoder_tb.v
//// Author: NG, Renard Rafferty
//// Email: rrng@connect.ust.hk
//// Affiliation: Hong Kong University of Science and Technology
//// -----------------------------------------------------------------------------
////
//// This file exports the testbench for encoder module.
//// It generates the adhoc input stimulus for the encoder.
//// =============================================================================

//module encoder_tb;

//// ----------------------------------
//// Local parameter declaration
//// ----------------------------------
//localparam CLK_PERIOD = 488;  // clock period: 1/Data Rate: 1/ 2.048Mbits/s = 0.488us

//// ----------------------------------
//// Interface of the divider module
//// ----------------------------------
//reg clk, rst;
//reg [59:0] data;
//reg [59:0] p;
//reg [59:0] n;

//// ----------------------------------
//// Instantiate the divider
//// ----------------------------------
//encoder uut (
//  .clk        (clk),          // system clock
//  .rst        (rst),          // system reset (active high)

//  .data       (data),         // Data Line Input
//  .p          (p),            // Positive Output
//  .n          (n)             // Negative Output
//);

//// ----------------------------------
//// For gate-level and post-layout 
//// simulation, we should backannotate 
//// the SDF file defined in SDF_FILE
//// ----------------------------------

//`ifdef SDF_FILE
//initial begin
//  $sdf_annotate(`SDF_FILE, uut);
//end
//`endif

//// ----------------------------------
//// Clock generation
//// ----------------------------------

//initial begin
//  clk = 1'b0;
//  forever #(CLK_PERIOD/2.0) clk = ~clk;
//end

//// ----------------------------------
//// Input stimulus
//// Generate the ad-hoc stimulus
//// ----------------------------------
//initial begin
//  // Reset
//  rst         = 1'b1;
//  data        = 60'b110000100000000110000111000011110010100011000000000000111000;
//  #(2*CLK_PERIOD) rst = 1'b0;

//  // Finish the testbench
//   #(CLK_PERIOD*2);
//  $finish;
//end
  
//// ----------------------------------
//// Time Limit
//// ----------------------------------
//initial begin
//  #1000000 
//  $display("Reach time limit, force stop.");
//  $finish;
//end
  
//// ----------------------------------
//// Output monitor
//// ----------------------------------

//endmodule

`timescale 1ns / 1ps

module encoder_tb;

// Testbench variables
reg clk;
reg rst;
reg [59:0] data;
wire [59:0] p;
wire [59:0] n;

// Instantiate the module
encoder #( .N(60) ) uut (
  .clk(clk),
  .rst(rst),
  .data(data),
  .p(p),
  .n(n)
);

// Clock generation
initial begin
  clk = 0;
  forever #5 clk = ~clk; // Generate a clock with a period of 10ns
end

// Test sequence
initial begin
  // Reset sequence
  rst = 1;
  data = 60'b110000100000000110000111000011110010100011000000000000111000;
  #100; // Wait for 100ns
  rst = 0;

end

endmodule

