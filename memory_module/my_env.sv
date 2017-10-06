class my_env extends uvm_env;
 `uvm_component_utils(my_env)
 
 my_agent m_agent;
 my_scoreboard m_scoreboard;
 virtual dut_if vif;
 
 function new(string name="",uvm_component parent);
  super.new(name,parent);
 endfunction
 
 virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);  
   if(!uvm_config_db #(virtual dut_if)::get(this,"","dut_if",vif))
	   `uvm_error (get_type_name(),"No interface found")
  
  m_agent=my_agent::type_id::create("m_agent",this);
  m_scoreboard=my_scoreboard::type_id::create("m_scoreboard",this);
 endfunction
 
 virtual function void connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //scoreboard and agent are connected here
   m_agent.m_monitor.mon_ap.connect(m_scoreboard.sb_export_before);
   m_agent.m_monitor.mon_ap_after.connect(m_scoreboard.sb_export_after);
   
  
 endfunction
 
 endclass