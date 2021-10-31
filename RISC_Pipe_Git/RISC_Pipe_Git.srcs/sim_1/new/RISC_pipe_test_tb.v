`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2021 11:50:13
// Design Name: 
// Module Name: RISC_pipe_test_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module RISC_pipe_test_tb;

    reg clk;
    
    RISC_pipe pipeline(.clk(clk));
    
    initial
    begin
        clk <= 1'b0;
    end
   
    always #5 clk <= ~clk;
    
    initial
    begin
        #160
        $finish;
    end
   
endmodule
