class my_config extends uvm_object;
  `uvm_object_utils(my_config)

	function new(string name = "");
		super.new(name);
	endfunction
endclass