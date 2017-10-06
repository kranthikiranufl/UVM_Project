module dut_wrapper (dut_if _if);
 dut dut0(.clk(_if.clk),
          .rstn(_if.rstn),
		  .wr (_if.wr),
		  .en (_if.en),
		  .wdata(_if.wdata),
		  .addr(_if.addr),
		  .rdata(_if.rdata));
 
endmodule