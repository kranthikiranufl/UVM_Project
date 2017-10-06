class my_env extends uvm_env;
 `uvm_component_utils(my_env)
 
 my_agent m_agent;
 my_sb m_sb;
 
 function new(string name, uvm_component parent);
   super.new(name,parent);
 endfunction
 
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   m_agent = my_agent::type_id::create("m_agent",this);
   m_sb = my_sb::type_id::create("m_sb",this);
 endfunction
  
 function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  m_agent.m_monitor.mon_ap.connect(m_sb.sb_export);
 endfunction
 
 endclass
