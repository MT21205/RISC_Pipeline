`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 11:53:46
// Design Name: 
// Module Name: IF_DE_REG
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


module IF_DE_REG(input clk,
                 input Inst_In,
                 output Inst_Out,
                 output RS1_Addr_out,
                 output RS2_Addr_out,
                 output RD_Addr_out           
                    );
    
    wire clk;
    wire[31:0] Inst_In;
    
    reg[31:0] Inst_Out;
    reg[5:0] RS1_Addr_out;
    reg[5:0] RS2_Addr_out;
    reg[5:0] RD_Addr_out;
    
    initial
    begin
        Inst_Out <= 32'd0;
        RS1_Addr_out <= 5'd0;
        RS2_Addr_out <= 5'd0;
        RD_Addr_out <= 5'd0;
    end
    
    always@(posedge clk)
    begin
        Inst_Out <= Inst_In;
        RS1_Addr_out <= Inst_In[25:21];
        RS2_Addr_out <= Inst_In[20:16];
        RD_Addr_out <= Inst_In[15:11];
    end
    
    
endmodule
