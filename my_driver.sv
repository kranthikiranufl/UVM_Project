class my_driver extends uvm_driver #(my_transaction);
 `uvm_component_utils(my_driver)
  my_transaction data_obj;
  virtual dut_if vif;
  function new (string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
      	
    if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_if",vif))
	  `uvm_fatal(get_type_name(),"No interface found")
  endfunction
  
  task run_phase(uvm_phase phase);
   super.run_phase(phase);
   data_obj=my_transaction::type_id::create("data_obj",this);
   //very important phase which actually gives the transacions to DUT
   vif.rstn=0;
   #10 vif.rstn=1;
   vif.wr=1;
   repeat(100)
    begin
      `uvm_info(get_type_name(),"Waiting for data from the sequencer",UVM_LOW)
	//get the transaction item from the sequencer 
	seq_item_port.get_next_item(data_obj);
	vif.en=data_obj.en;
	vif.wdata=data_obj.wdata;
	vif.addr=data_obj.addr;
	//vif.wr= #5 ~vif.wr;
	seq_item_port.item_done();
    end
	//read data randomly
	vif.wr=#10 ~vif.wr;
    repeat(50) begin
      `uvm_info(get_type_name(),"Waiting for data from the sequencer",UVM_LOW)
	//get the transaction item from the sequencer 
	seq_item_port.get_next_item(data_obj);
	vif.en=data_obj.en;
	vif.wdata=data_obj.wdata;
	vif.addr=data_obj.addr;
	vif.wr= #5 ~vif.wr;
	seq_item_port.item_done();
    end
	endtask
endclass
	
	
	 
	 
	 