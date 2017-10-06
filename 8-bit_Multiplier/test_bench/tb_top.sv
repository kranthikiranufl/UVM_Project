`include "dut_if.sv"
`include "vedic8x8.sv"
`include "my_pkg.sv"
module tb_top;
 import uvm_pkg::*;
 bit clk;
 dut_if vif(clk);
 dut my_dut(.a(vif.a),.b(vif.b),.prod(vif.c));
 always #5 clk = ~clk;

 initial begin
  clk = 0;
  uvm_config_db#(virtual dut_if)::set (uvm_top,"*","dut_if",vif);
  run_test("my_test");
 end

endmodule 
