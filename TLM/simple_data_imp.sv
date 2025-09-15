`include "uvm_macros.svh"
import uvm_pkg::*;

class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  int data = 12;
  
  uvm_blocking_put_port #(int) send; // send is the name of the class
  
  function new(string path = "producer", uvm_component parent = null);
    super.new(path,parent);
    
    send = new("send",this);
    
  endfunction
  
  task main_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    send.put(data);                 // puts 'data' onto send class port 
    `uvm_info("producer",$sformatf("data send = %0d",data),UVM_NONE);
    phase.drop_objection(this);
    
  endtask
  
endclass

class consumer extends uvm_component;
  `uvm_component_utils(consumer)
  
  uvm_blocking_put_export #(int) recv; // recv is the name of the class
  uvm_blocking_put_imp #(int,consumer) imp; //implementation
  
  function new(string path = "consumer", uvm_component parent = null);
    super.new(path,parent);
    
    recv = new("recv",this);
    imp = new("imp",this);
    
  endfunction
  
  task put(int datar);
    `uvm_info("consumer",$sformatf("data received = %0d",datar),UVM_NONE);
  endtask
  
endclass

class env extends uvm_env;
  `uvm_component_utils(env)
  
  producer p;
  consumer c;
  
  function new(input string path = "env", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    p = producer::type_id::create("p",this);
    c = consumer::type_id::create("c",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    p.send.connect(c.recv); // port.connect(export)
    c.recv.connect(c.imp);  // recv connected to imp
    
  endfunction
  
endclass

class test extends uvm_test;
  `uvm_component_utils(test)
  
  env e;
  
  function new(input string path = "test", uvm_component parent = null);
    super.new(path,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    e = env::type_id::create("e",this);
  endfunction
  
endclass

module tb;
  initial begin
    run_test("test");
  end
endmodule
