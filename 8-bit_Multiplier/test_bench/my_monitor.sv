class my_monitor extends uvm_monitor;
 `uvm_component_utils(my_monitor)
  uvm_analysis_port #(my_transaction) mon_ap;
 virtual dut_if vif;
 my_transaction seq_item;
  function new(string name="", uvm_component parent);
   super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  if(!uvm_config_db#(virtual dut_if)::get(this,"","dut_if",vif))
      `uvm_error(get_type_name(),"No interfaces found")
   seq_item = new();
   mon_ap = new("mon_ap",this);
 endfunction

 virtual task run_phase(uvm_phase phase);
  forever begin
   @(posedge vif.clk)
    begin
    seq_item.a = vif.a;
    seq_item.b = vif.b;
    end
   // $display("MONITOR:The inputs received from driver are: %d, %d",vif.a,vif.b);
   //@(posedge vif.clk)
    seq_item.c = vif.c;
    $display("MONITOR:The inputs received from driver are: %d, %d, O/p: %d",vif.a,vif.b,vif.c);
	if(!seq_item.a || !seq_item.b)
	   $display("Zero inputs are taken at Monitor here");
	mon_ap.write(seq_item);
  end	
 endtask
endclass
