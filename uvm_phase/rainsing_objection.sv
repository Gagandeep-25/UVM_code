`include "uvm_macros.svh"
import uvm_pkg::*;

class comp extends uvm_component;
  `uvm_component_utils(comp)
  
  function new(string path = "comp",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  task reset_phase(uvm_phase phase);
    phase.raise_objection(this); //Keeps the reset_phase running, prevents UVM from ending it too early.
    
    `uvm_info("comp","reset started in reset_phase",UVM_NONE);
    #10;
    `uvm_info("comp","reset ended in reset_phase",UVM_NONE);
    
    phase.drop_objection(this); //Signals that the component is done, so the phase can finish when all objections are dropped.
  endtask
  
endclass

module tb;
  initial begin
    run_test("comp");
  end
endmodule
