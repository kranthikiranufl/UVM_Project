class my_test extends uvm_test;
 `uvm_component_utils(my_test)
 my_env m_env;
 my_sequence m_seq;
 
 function new (string name ="my_test", uvm_component parent);
   super.new(name,parent);
 endfunction
 
 virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	m_env = my_env::type_id::create("m_env",this);
	m_seq = my_sequence::type_id::create("m_seq",this);
 endfunction
 
 virtual task run_phase(uvm_phase phase);
   phase.raise_objection(this);
   m_seq.start(m_env.m_agent.m_sequencer);
   phase.drop_objection(this);
 endtask
 
endclass