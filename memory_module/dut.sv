//`include "timescale.v"

module dut (   
               input    clk,                 // Clock at some freq
               input    rstn,                // Active Low  Sync Reset
               input    wr,                  // Active High Write
               input    en,                  // Module Enable
               input  [15:0]   wdata,               // Write Data
               input  [3:0] addr,                // Address

               output [15:0] rdata                // Read Data
            );

   //parameter DEPTH = 16;                      // Depth of Memory Element

   reg [15:0]   rdata_syn;                    // rdata synced with clock
   reg [15:0]   mem [0:15];                  // Memory element

   //--------------------------------------------------------------------------
   // Write data into the memory space
   //--------------------------------------------------------------------------

   always @ (posedge clk) begin
      if (!rstn) begin
         for (int i = 0; i < $size(mem); i++) begin
            mem[i] <= 0;
         end
      end else begin
         if (en & wr) begin
            mem [addr] <= wdata;
         end
      end
   end

   //--------------------------------------------------------------------------
   // Read data from memory space
   //--------------------------------------------------------------------------

   always @ (posedge clk) begin
      if (!rstn) begin
         rdata_syn <= 0;
      end else begin
         if (!wr & en) begin
            rdata_syn <= mem [addr];
         end
      end
   end

   //--------------------------------------------------------------------------
   // Assign rdata_syn to output 
   //--------------------------------------------------------------------------
   assign rdata = rdata_syn;

endmodule 