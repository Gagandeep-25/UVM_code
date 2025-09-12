`include "uvm_macros.svh"
import uvm_pkg::*;
/////Default Timeout = 9200sec
 
 
class comp extends uvm_component;
  `uvm_component_utils(comp)
  
  function new(string path = "comp",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("comp","reset started",UVM_NONE);
    #10;
    `uvm_info("comp","reset completed",UVM_NONE);
    phase.drop_objection(this);
  endtask
  
  task main_phase(uvm_phase phase);
    phase.phase_done.set_drain_time(this,200);
    phase.raise_objection(this);
    `uvm_info("comp", " Main Phase Started", UVM_NONE);
    #100;
    `uvm_info("comp", " Main Phase Ended", UVM_NONE);
    phase.drop_objection(this);
  endtask
  
  task post_main_phase(uvm_phase phase);
    `uvm_info("comp","post main phase",UVM_NONE);
  endtask
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
endclass

module tb;
  
  initial begin
    run_test("comp");
  end
endmodule
