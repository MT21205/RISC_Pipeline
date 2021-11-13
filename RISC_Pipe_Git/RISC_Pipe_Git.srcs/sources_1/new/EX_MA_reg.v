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
                input clk,
                input[31:0] Result_In,
                input[4:0] Inst_Type_In,
                input[31:0] Operand_B_In,
                input[4:0] RD_Addr_In,
                output reg[31:0] Result_Out,
                output reg[31:0] Operand_B_Out,
                output reg[4:0] Inst_Type_Out,
                output reg[4:0] RD_Addr_Out
    );
    
    initial
    begin
        Result_Out <= 32'dx;
        Operand_B_Out <= 32'dx;
        Inst_Type_Out <= 5'dx;
        RD_Addr_Out <= 5'dx;
    end
    
    always@(posedge clk)
    begin
        Result_Out <= Result_In;
        Operand_B_Out <= Operand_B_In;
        Inst_Type_Out <= Inst_Type_In;
        RD_Addr_Out <= RD_Addr_In;
    end
    
endmodule
