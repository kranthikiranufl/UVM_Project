class my_sequencer extends uvm_sequencer #(my_transaction);
    `uvm_component_utils (my_sequencer)
    function new (string name="m_sequencer", uvm_component parent);
      super.new (name, parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
	  super.build_phase(phase);
	  `uvm_info("MY_SEQUENCER","Building the sequencer object here!!",UVM_LOW)
	endfunction
  endclass