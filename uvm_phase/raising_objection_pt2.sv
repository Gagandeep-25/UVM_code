`include "uvm_macros.svh"
import uvm_pkg::*;

class comp extends uvm_component;
  `uvm_component_utils(comp)
  
  function new(string path = "comp",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("comp","start of reset",UVM_NONE);
    #10;
    `uvm_info("comp","end of reset",UVM_NONE);
    phase.drop_objection(this);
  endtask
  
  task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("comp","start of main phase",UVM_NONE);
    #10;
    `uvm_info("comp","end of main phase",UVM_NONE);
    phase.drop_objection(this);
  endtask
  
endclass

module tb;
  initial begin
    run_test("comp");
  end
endmodule
