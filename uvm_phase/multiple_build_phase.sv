`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;
  `uvm_component_utils(driver)
  
  function new(string path = "driver",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("driver","driver build_phase  executed ",UVM_NONE);
  endfunction
  
endclass

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  function new(string path = "monitor",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("monitor","build phase of monitor executed",UVM_NONE);
  endfunction
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  driver drv;
  monitor mon;
  
  function new(string path = "env",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("env","env build phase executed",UVM_NONE);
    drv = driver::type_id::create("drv",this);
    mon = monitor::type_id::create("mon",this);
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(string path = "test",uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("test","test build phase executed",UVM_NONE);
    e = env::type_id::create("e",this);
  endfunction
  
endclass

module tb;
  initial begin
    run_test("test"); //only build phase executes in a top down method where as others follow bottom to top approach  
  end
endmodule
