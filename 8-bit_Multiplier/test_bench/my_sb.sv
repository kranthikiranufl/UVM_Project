class my_sb extends uvm_scoreboard;
 `uvm_component_utils(my_sb)
 
  uvm_analysis_imp#(my_transaction,my_sb) sb_export;
 
  logic [7:0] A,B;
  logic [15:0] C,D;
 function new (string name="",uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    sb_export = new("sb_export",this);
  endfunction
  
  function void write(my_transaction pkt);
   A=pkt.a;
   B=pkt.b;
   C = pkt.c;
  D= A*B;
  $display("SCOREBOARD: The valus received are :%d, %d, %d",A,B,C);
   if(C==D)
     `uvm_info(get_type_name(),"Test is PASSED",UVM_LOW)
   else 
    `uvm_info(get_type_name(),"Test is FAILED!!",UVM_LOW)
 endfunction  
 endclass
