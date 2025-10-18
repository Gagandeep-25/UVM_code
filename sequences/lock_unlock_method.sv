`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
  
  rand bit [3:0] a;
  rand bit [3:0] b;
  bit [4:0] y;
  
  function new(input string path = "transaction");
    super.new(path);
  endfunction
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(a,UVM_DEFAULT);
  `uvm_field_int(b,UVM_DEFAULT);
  `uvm_field_int(y,UVM_DEFAULT);
  `uvm_object_utils_end
  
  constraint range_ab {
    a inside {[0:15]};
    b inside {[0:10]};
  }
  
endclass

class sequence1 extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence1)
  
  transaction trans;
  
  function new(input string path = "sequence1");
    super.new(path);
  endfunction
  
  virtual task body();
    
    lock(m_sequencer);
    
    repeat(3) begin
      
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ1","SEQ1 started",UVM_NONE);
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
      `uvm_info("SEQ2","SEQ2 ended",UVM_NONE);
      
    end
    
    unlock(m_sequencer);
  endtask
  
endclass

class sequence2 extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence2)
  
  transaction trans;
  
  function new(input string path = "sequence2");
    super.new(path);
  endfunction
  
  virtual task body();
    
     lock(m_sequencer);
    
    repeat(3) begin
      trans = transaction::type_id::create("trans");
      `uvm_info("SEQ2","SEQ2 Started",UVM_NONE);
      start_item(trans);
      assert(trans.randomize());
      finish_item(trans);
      `uvm_info("SEQ2","SEQ2 endded",UVM_NONE);
    end
    
    unlock(m_sequencer);
    
  endtask
  
endclass

class driver extends uvm_driver#(transaction);
  `uvm_component_utils(driver)
  
  transaction t;
  virtual adder_if aif;
  
  function new(input string path = "driver", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t = transaction::type_id::create("t");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(t);
      seq_item_port.item_done();
    end
  endtask
  
endclass

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  
  function new(input string path = "agent", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  driver d;
  uvm_sequencer#(transaction) seq;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    d = driver::type_id::create("d",this);
    seq = uvm_sequencer#(transaction)::type_id::create("seq",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    d.seq_item_port.connect(seq.seq_item_export);
  endfunction
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  function new(input string path = "env", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  agent a;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = agent::type_id::create("a",this);
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  function new(input string path = "test", uvm_component parent);
    super.new(path,parent);
  endfunction
  
  env e;
  sequence1 s1;
  sequence2 s2;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
    s1 = sequence1::type_id::create("s1");
    s2 = sequence2::type_id::create("s2");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    //e.a.seq.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
    fork
      s2.start(e.a.seq,null,200);
      s1.start(e.a.seq,null,100);
    join
    phase.drop_objection(this);
  endtask
  
endclass

module tb;
 
 
initial begin
  run_test("test");
end
 
endmodule

/*

in the case of lock method , then i sequence has this method , that specific sequence completes sending its transactions first 

if there are multiple methods with lock and unlock , then the sequence that first accesses the sequencer finished sending its transactions first 

*/

