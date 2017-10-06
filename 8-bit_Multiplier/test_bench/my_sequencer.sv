class my_transaction extends uvm_sequence_item;
  
  rand bit [7:0] a;
  rand bit [7:0] b; 
  rand bit [15:0] c;
 `uvm_object_utils_begin(my_transaction)
   `uvm_field_int(a,UVM_ALL_ON)
   `uvm_field_int(b,UVM_ALL_ON)
   `uvm_field_int(c,UVM_ALL_ON)
 `uvm_object_utils_end
 function new (string name="my_transaction");
    super.new(name);
 endfunction
 
endclass


class my_sequence extends uvm_sequence#(my_transaction);
 `uvm_object_utils(my_sequence)
 
 function new (string name="");
   super.new(name);
 endfunction
 
 virtual task body();
      repeat (10) begin
       req=my_transaction::type_id::create("req");
	wait_for_grant();
	req.randomize();
	send_request(req);
	wait_for_item_done();
     end
 endtask
 
 endclass

 class my_sequencer extends uvm_sequencer #(my_transaction);
  `uvm_component_utils(my_sequencer)
   
 function new (string name="", uvm_component parent);
   super.new(name,parent);
 endfunction
endclass
