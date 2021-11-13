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
                input[31:0] Data_In,
                input[4:0] Inst_Type_In,
                input[4:0] RD_Addr_In,
                output reg[31:0] Data_Out,
                output reg[4:0] Inst_Type_Out,
                output reg[4:0] RD_Addr_Out
                );

    initial
    begin
        Data_Out <= 32'dx;
        Inst_Type_Out <= 5'dx;
        RD_Addr_Out <= 5'dx;
    end
    
    always@(posedge clk)
    begin
        Data_Out <= Data_In;
        Inst_Type_Out <= Inst_Type_In;
        RD_Addr_Out <= RD_Addr_In;
    end
    
endmodule
