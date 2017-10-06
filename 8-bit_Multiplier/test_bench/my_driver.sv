class my_driver extends uvm_driver#(my_transaction);
  `uvm_component_utils(my_driver)
 
 virtual dut_if vif;
 my_transaction seq_item;
 function new (string name="", uvm_component parent);
   super.new(name,parent);
 endfunction
 
 function void build_phase (uvm_phase phase);
   super.build_phase(phase);
   
   if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_if",vif))
      `uvm_fatal("VIF","No virtual interface found")
 endfunction
 
 virtual task run_phase(uvm_phase phase);
   forever begin
   seq_item=my_transaction::type_id::create("seq_item");
   seq_item_port.get_next_item(seq_item);
   drive();
   seq_item_port.item_done();
   end
 endtask
  task drive();
   @(posedge vif.clk)
   begin
    vif.a=seq_item.a;
	vif.b=seq_item.b;
        $display("The inputs  generated are :%d, %d",vif.a,vif.b);
        //@(posedge vif.clk);
	if(!seq_item.a || !seq_item.b)
           $display("Zero inputs are generated here");
   end
  endtask
 endclass
