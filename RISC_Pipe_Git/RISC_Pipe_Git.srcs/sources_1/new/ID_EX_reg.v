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
                 input[31:0] Operand_A_val_In, //Operand A represents RS1
                 input[31:0] Operand_B_val_In, //Operand B represents RS2
                 input[31:0] RD_Data_In,
                 input[31:0] Immx_Data_In,
                 input[4:0] Inst_Type_In,
                 input branch_kill_flag_In,
                 input[4:0] RD_Addr_In,
                 input RS1_Fwd_Flag_In,
                 input RS2_Fwd_Flag_In,
                 input[31:0] RS1_RS2_Fwd_Data_In,
                 input[9:0] Operation_Type_In,
                 output reg[31:0] Operand_A_val_Out,
                 output reg[31:0] Operand_B_val_Out,
                 output reg[31:0] RD_Data_Out,
                 output reg[31:0] Immx_Data_Out,
                 output reg[4:0] Inst_Type_Out,
                 output reg[9:0] Operation_Type_Out,
                 output reg[4:0] RD_Addr_Out
                );
    
    initial
    begin
        //Inst_Out <= 32'dx;
        Operand_A_val_Out <= 32'dx;
        Operand_B_val_Out <= 32'dx;
        RD_Data_Out <= 32'dx;
        Immx_Data_Out <= 32'dx;
        Inst_Type_Out <= 5'dx;
        RD_Addr_Out <= 5'dx;
        Operation_Type_Out <= 9'dx;
    end
    
    always@(posedge clk)
    begin
        // If a branch is taken, then the instructions in the fetch and the decode stage should to be killed.
        // Hence, these content aren't to be transmitte to the next stages.
        // To achieve this, an xx is being sent to the next stages. 
        if(branch_kill_flag_In == 1'd1)
        begin
            //Inst_Out <= 32'dx;
            Operand_A_val_Out <= 32'dx;
            Operand_B_val_Out <= 32'dx;
            Immx_Data_Out <= 32'dx;
            Inst_Type_Out <= 5'dx;
            RD_Addr_Out <= 5'dx; 
            Operation_Type_Out <= 9'dx;
            RD_Data_Out <= 32'dx;   
        end
        else
        begin
            //Inst_Out <= Inst_In;
            RD_Data_Out <= RD_Data_In;
            if(RS1_Fwd_Flag_In == 1'b1)
                Operand_A_val_Out <= RS1_RS2_Fwd_Data_In;
            else
                Operand_A_val_Out <= Operand_A_val_In;
            if(RS2_Fwd_Flag_In == 1'b1)
                Operand_B_val_Out <= RS1_RS2_Fwd_Data_In;
            else
                Operand_B_val_Out <= Operand_B_val_In;
            Immx_Data_Out <= Immx_Data_In;
            Inst_Type_Out <= Inst_Type_In;
            RD_Addr_Out <= RD_Addr_In;
            Operation_Type_Out <= Operation_Type_In;
        end
        
    end
    
endmodule
