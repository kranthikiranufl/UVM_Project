interface dut_if (input clk);

   logic          rstn;
   logic [15:0]    wdata;
   logic [15:0]    rdata;
   logic [3:0]    addr;
   logic          wr;
   logic          en;

endinterface  