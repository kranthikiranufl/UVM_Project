
class my_transaction extends uvm_sequence_item;
	rand bit [15:0]    wdata;
    rand bit [3:0]    addr;
    rand bit          en;
	//this new function may not be needed to write
	function new(string name = "");
		super.new(name);
	endfunction
	
	constraint c_addr { addr >= 0; addr < 16;}

	`uvm_object_utils_begin(my_transaction)
		`uvm_field_int(wdata, UVM_ALL_ON)
		`uvm_field_int(addr, UVM_ALL_ON)
		`uvm_field_int(en, UVM_ALL_ON)
	`uvm_object_utils_end
endclass

class my_sequence extends uvm_sequence#(my_transaction);
  `uvm_object_utils(my_sequence)
  function new(string name="");
    super.new(name);
  endfunction
  //body() is the actual task that generates the sequence items randomly
  task body();
  my_transaction data_obj=my_transaction::type_id::create("data_obj");
  `uvm_info ("BASE_SEQ",$sformatf("Starting body of %s",this.get_name()),UVM_MEDIUM)
  repeat(100)
   begin
   //generating the sequence items here
   start_item(data_obj);
   assert(data_obj.randomize());
   finish_item(data_obj);
   end
    `uvm_info ("BASE_SEQ",$sformatf("Sequence %s is over!!!",this.get_name),UVM_MEDIUM)
  endtask
 endclass