class my_agent extends uvm_agent;
 `uvm_component_utils(my_agent)
 
 my_driver m_driver;
 my_monitor m_monitor;
 my_sequencer m_sequencer;
 
 function new (string name="",uvm_component parent);
    super.new(name,parent);
 endfunction
 
 function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   
   m_driver = my_driver::type_id::create("m_driver",this);
   m_monitor = my_monitor::type_id::create("m_monitor",this);
   m_sequencer = my_sequencer::type_id::create("m_sequencer",this);
 endfunction
 
 function void connect_phase(uvm_phase phase);
  m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
 endfunction
 
endclass
