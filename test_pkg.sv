//package test_pkg;
 import uvm_pkg::*;
 //import my_pkg::*;
 
 class base_test extends uvm_test;
   `uvm_component_utils(base_test)
   my_env m_top_env;
//my_cfg m_cfg0;
   virtual dut_if vif;
   function new (string name,uvm_component parent);
     super.new(name,parent);
   endfunction
   
   virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
	 //m_cfg0 = my_cfg::type_id::create("m_cfg0",this);
	 m_top_env = my_env::type_id::create("m_top_env",this);
	 
	 set_cfg_params();
	// uvm_config_db #(my_cfg)::set(this,"m_top_env.my_agent","m_cfg0",m_cfg0);
   endfunction

  virtual function void set_cfg_params();
    if(!uvm_config_db #(virtual dut_if)::get(this,"","dut_if",vif))  
	  begin
	     `uvm_error (get_type_name(),"DUT Interface not found")
	  end
	 // m_cfg0.m_verbosity=UVM_HIGH;
	 // m_cfg0.active=UVM_ACTIVE;
  endfunction
  
  virtual function void end_of_elaboration_phase (uvm_phase phase);
         // By now, the environment is all set up, just print the topology for debug
         uvm_top.print_topology ();
    if (! uvm_config_db #(virtual dut_if) :: exists (this, "*", "dut_vif"))
        `uvm_error ("VIF", "Could not find an interface handle")
      endfunction
	  
  virtual task run_phase(uvm_phase phase);
    my_sequence m_seq=my_sequence::type_id::create("m_seq");
	phase.raise_objection(this,"Starting the sequence here main_phase");
    m_seq.start(m_top_env.m_agent.m_sequencer);
	phase.drop_objection(this);
  endtask
 endclass
 
 
 //endpackage
	