`include "uvm_macros.svh"
import uvm_pkg::*;

class comp1 extends uvm_component;
  `uvm_component_utils(comp1)

  int data1 = 0;

  function new(string name = "comp1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(int)::get(null, "uvm_test_top", "data", data1))
      `uvm_error("comp1", "unable to access data1");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("comp1", $sformatf("comp1 : %0d", data1), UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass


class comp2 extends uvm_component;
  `uvm_component_utils(comp2)

  int data2 = 0;

  function new(string name = "comp2", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(int)::get(null, "uvm_test_top", "data", data2))
      `uvm_error("comp2", "unable to access data2");
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("comp2", $sformatf("comp2 : %0d", data2), UVM_NONE);
    phase.drop_objection(this);
  endtask
endclass


class agent extends uvm_agent;
  `uvm_component_utils(agent)

  comp1 c1;
  comp2 c2;

  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    c1 = comp1::type_id::create("comp1", this);
    c2 = comp2::type_id::create("comp2", this);
  endfunction
endclass


class env extends uvm_env;
  `uvm_component_utils(env)

  agent a;

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = agent::type_id::create("agent", this);
  endfunction
endclass


class test extends uvm_test;
  `uvm_component_utils(test)

  env e;

  function new(string name = "test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("env", this);
  endfunction
endclass


module ram_tb;
  int data = 256;

  initial begin
    uvm_config_db#(int)::set(null, "uvm_test_top", "data", data);
    run_test("test");
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
