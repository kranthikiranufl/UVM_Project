 class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent);
  
  my_driver m_driver;
  my_monitor m_monitor;
  my_sequencer m_sequencer;
  virtual dut_if vif;
  
  function new (string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	m_sequencer = my_sequencer::type_id::create("m_sequencer",this);
	m_driver = my_driver::type_id::create("m_driver",this);
	m_monitor = my_monitor::type_id::create("m_monitor",this);
	
    if(!uvm_config_db #(virtual dut_if)::get(this,"","dut_if",vif))
	   `uvm_error (get_type_name(),"No interface found")
	   
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    //connect the driver to sequencer here
	m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	//connect the monitor to analysis port of the agent if not connected in environment
  endfunction
 endclass