`timescale 1ns/1ps ;

module adder4B_BH (
  output reg  [3:0] Sum,
  output reg Carry ,
  input [3:0] A ,
  input [3:0] B 
);
  
  always@(*) 
    begin 
      {Carry , Sum } = A+B ;
      
    end 
endmodule 
  