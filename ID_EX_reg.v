`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 20:19:56
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg(input clk,
                 input Inst_In,
                 input Operand_A_val_In,
                 input Operand_B_val_In,
                 input Immx_Data_In,
                 output Inst_Out,
                 output Operand_A_val_Out,
                 output Operand_B_val_Out,
                 output Immx_Data_Out
                );
                
    
    wire clk;
    wire[31:0] Inst_In;
    wire[31:0] Operand_A_val_In;
    wire[31:0] Operand_B_val_In;
    wire[31:0] Immx_Data_In;
    
    reg[31:0] Inst_Out;
    reg[31:0] Operand_A_val_Out;
    reg[31:0] Operand_B_val_Out;
    reg[31:0] Immx_Data_Out;
    
    initial
    begin
        Inst_Out <= 32'd0;
        Operand_A_val_Out <= 32'd0;
        Operand_B_val_Out <= 32'd0;
        Immx_Data_Out <= 32'd0;
    end
    
    always@(posedge clk)
    begin
        Inst_Out <= Inst_In;
        Operand_A_val_Out <= Operand_A_val_In;
        Operand_B_val_Out <= Operand_B_val_In;
        Immx_Data_Out <= Immx_Data_In;
    end
    
endmodule
