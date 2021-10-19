`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2021 23:26:37
// Design Name: 
// Module Name: EX_MA_reg
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


module EX_MA_reg(
                //input isBranchTaken_Out,
                input clk,
                input Result_In,
                input Inst_In,
                input Operand_B_In,
                output Result_Out,
                output Inst_Out,
                output Operand_B_Out
    );
    
    wire[31:0] Result_In;
    wire[31:0] Inst_In;
    wire[31:0] Operand_B_In;    
    wire clk;
    
    reg[31:0] Result_Out;
    reg[31:0] Inst_Out;
    reg[31:0] Operand_B_Out;
    
    initial
    begin
        Result_Out <= 32'd0;
        Inst_Out <= 32'd0;
        Operand_B_Out <= 32'd0;
    end
    
    always@(posedge clk)
    begin
        Result_Out <= Result_In;
        Inst_Out <= Inst_In;
        Operand_B_Out <= Operand_B_In;
    end
    
endmodule
