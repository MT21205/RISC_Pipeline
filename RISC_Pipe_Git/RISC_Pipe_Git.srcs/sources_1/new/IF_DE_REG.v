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
                 input branch_kill_flag_In,
                 input stall_ctrl_in,
                 output Inst_Out,
                 output RS1_Addr_out,
                 output RS2_Addr_out,
                 output RD_Addr_out           
                    );
                    
    parameter IMMEDIATE_TYPE = 5'b00100;
    parameter LOAD_TYPE = 5'b00000;
    
    wire clk;
    wire[31:0] Inst_In;
    wire branch_kill_flag_In;
    wire stall_ctrl_in;
    
    reg[31:0] Inst_Out;
    reg[4:0] RS1_Addr_out;
    reg[4:0] RS2_Addr_out;
    reg[4:0] RD_Addr_out;
    
    initial
    begin
        Inst_Out <= 32'dx;
        RS1_Addr_out <= 5'dx;
        RS2_Addr_out <= 5'dx;
        RD_Addr_out <= 5'dx;
    end
    
    always@(posedge clk)
    begin
        // If a branch is taken, then the instructions in the fetch and the decode stage should to be killed.
        // Hence, these content aren't to be transmitte to the next stages.
        // To achieve this, an xx is being sent to the next stages.
        if(stall_ctrl_in == 1'b1)
        begin
            Inst_Out <= Inst_Out;
            RS1_Addr_out <= RS1_Addr_out;
            RS2_Addr_out <= RS2_Addr_out;
            RD_Addr_out <= RD_Addr_out;
        end 
        else if(branch_kill_flag_In == 1'd1)
        begin
            Inst_Out <= 32'dx;
            RS1_Addr_out <= 5'dx;
            RS2_Addr_out <= 5'dx;
            RD_Addr_out <= 5'dx;
        end
        else
        begin
            Inst_Out <= Inst_In;
            RS1_Addr_out <= Inst_In[19:15];
            
            if((Inst_In[6:2] == IMMEDIATE_TYPE) || (Inst_In[6:2] == LOAD_TYPE))
                RS2_Addr_out <= 5'd0;
            else
                RS2_Addr_out <= Inst_In[24:20];
                
            RD_Addr_out <= Inst_In[11:7];
        end
        
    end
    
    
endmodule
