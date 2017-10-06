class my_monitor extends uvm_monitor;
 `uvm_component_utils(my_monitor)
 
 virtual dut_if vif;
 //create an analysis port that can be connected to a scoreboard through the parent agent
  uvm_analysis_port #(my_transaction) mon_ap;
  uvm_analysis_port #(my_transaction) mon_ap_after;
 function new(string name="",uvm_component parent);
   super.new(name,parent);
 endfunction
 
 virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
    //create instance of analysis port
   mon_ap=new(.name("mon_ap"),.parent(this));
   mon_ap_after=new(.name("mon_ap"),.parent(this));
   	if(uvm_config_db#(virtual dut_if)::get(this,"","vif",vif))
	  `uvm_error(get_type_name(),"No interface found")
 endfunction
 
 virtual task run_phase(uvm_phase phase);
   my_transaction mon_data=my_transaction::type_id::create("mon_data",this);
   my_transaction  			mon_data_after=my_transaction::type_id::create("mon_data_after",this);
   forever begin
     mon_data.en = vif.en;
	 mon_data.wdata=vif.wdata;
	 mon_data.addr=vif.addr;
	 mon_data_after.en = vif.en;
	 mon_data_after.wdata=vif.wdata;
	 mon_data_after.addr=vif.addr;
	 if(vif.wr)
	 //send data that is written to the memory
	  mon_ap.write(mon_data);
	 else
       mon_ap_after.write(mon_data_after);
   end
  endtask
 endclass