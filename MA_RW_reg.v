`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2021 20:19:45
// Design Name: 
// Module Name: MA_RW_reg
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


module MA_RW_reg(
                input clk,
                input Data_In,
                input Inst_In,
                input Inst_Type_In,
                output Data_Out,
                output Inst_Out,
                output Inst_Type_Out
                );
                
    wire clk;
    wire[31:0] Data_In;
    wire[31:0] Inst_In;
    wire[4:0] Inst_Type_In;
    
    reg[31:0] Data_Out;
    reg[31:0] Inst_Out;
    reg[4:0] Inst_Type_Out;

    initial
    begin
        Data_Out <= 32'd0;
        Inst_Out <= 32'd0;
        Inst_Type_Out <= 5'd0;
    end
    
    always@(posedge clk)
    begin
        Data_Out <= Data_In;
        Inst_Out <= Inst_In;
        Inst_Type_Out <= Inst_Type_In;
    end
    
endmodule
