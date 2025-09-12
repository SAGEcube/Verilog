`timescale 1ns / 1ps ;

module Tb (); 
  reg [3:0] A ;
  reg [3:0] B ;
  wire [3:0] Sum ;
  wire Carry ;
  
  adder4B_BH d1(.Sum(Sum) , .Carry(Carry) , .A(A) , .B(B));
  
  initial 
    begin 
      $dumpfile("Tb.vcd") ;
      $dumpvars(0,Tb);
      
      $monitor("|Time = %t | A=%b | B=%b | Sum = %b | Carry =%b|",$time ,Sum,Carry,A,B);
      
        A = 4'b1000 ; B = 4'b0110 ; #5 ;
        A = 4'b0011 ; B = 4'b0010 ; #5 ;
        A = 4'b1011 ; B = 4'b1111 ; #5 ;
        A = 4'b1010 ; B = 4'b0110 ; #5 ;
      
      $finish ;
    end 
endmodule 