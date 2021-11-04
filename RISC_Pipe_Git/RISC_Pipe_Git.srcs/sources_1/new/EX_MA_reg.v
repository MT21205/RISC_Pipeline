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
                //input Inst_In,
                input Inst_Type_In,
                input Operand_B_In,
                input RD_Addr_In,
                output Result_Out,
                //output Inst_Out,
                output Operand_B_Out,
                output Inst_Type_Out,
                output RD_Addr_Out
    );
    
    wire[31:0] Result_In;
    //wire[31:0] Inst_In;
    wire[31:0] Operand_B_In;    
    wire clk;
    wire[4:0] Inst_Type_In;
    wire[4:0] RD_Addr_In;
    
    reg[31:0] Result_Out;
    //reg[31:0] Inst_Out;
    reg[31:0] Operand_B_Out;
    reg[4:0] Inst_Type_Out;
    reg[4:0] RD_Addr_Out;
    
    initial
    begin
        Result_Out <= 32'dx;
        //Inst_Out <= 32'd0;
        Operand_B_Out <= 32'dx;
        Inst_Type_Out <= 5'dx;
        RD_Addr_Out <= 5'dx;
    end
    
    always@(posedge clk)
    begin
        Result_Out <= Result_In;
        //Inst_Out <= Inst_In;
        Operand_B_Out <= Operand_B_In;
        Inst_Type_Out <= Inst_Type_In;
        RD_Addr_Out <= RD_Addr_In;
    end
    
endmodule
