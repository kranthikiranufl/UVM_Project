class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
  
  `uvm_analysis_imp_decl (_data_read)
  `uvm_analysis_imp_decl (_data_written)
  
  //analysis exports to be connected to the analysis ports from agent
  uvm_analysis_imp_data_written #(my_transaction,my_scoreboard) sb_export_before;
  uvm_analysis_imp_data_read #(my_transaction,my_scoreboard) sb_export_after;
  //sequence item objects to collect sequences from the monitor
  my_transaction data_before;
  my_transaction data_after;
  function new (string name="",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
	//create the analysis exports and data sequence objects
	data_before=my_transaction::type_id::create("data_before",this);
	data_after=my_transaction::type_id::create("data_after",this);
    sb_export_after=new("sb_export_after",this);
    sb_export_before=new("sb_export_before",this);	 
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
  //connect any objects within the scoreboard
  endfunction
  
  function void write_data_written(my_transaction data);
    `uvm_info("RECEIVER1","Written data is collected here",UVM_MEDIUM)
	 data_before = data;
  endfunction
  function void write_data_read(my_transaction data);
    `uvm_info("RECEIVER1","Written data is collected here",UVM_MEDIUM)
	 data_after = data;
  endfunction
  virtual task run_phase(uvm_phase phase);
    forever begin
	 if(data_before.addr==data_after.addr)
	   begin
         if(data_before.wdata==data_after.wdata)
		    `uvm_info("RESULT","Test PASSED!!",UVM_HIGH)
		  else
		     `uvm_info("RESULT","Test FAILED!!",UVM_HIGH)
	    end
	end
 endtask
 
endclass
		  