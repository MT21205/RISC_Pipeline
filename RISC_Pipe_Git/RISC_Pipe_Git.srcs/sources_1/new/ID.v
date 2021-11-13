`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 19:37:43
// Design Name: 
// Module Name: ID
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


module ID(
            input[31:0] Inst_In,
            input stall_ctrl_in,
            input[4:0] RD_Addr_In,
            input clk,
            output reg[31:0] Imm_Data_Out,
            output reg[4:0] Inst_Type_Out,
            output reg[9:0] Operation_Type_Out,
            output reg[4:0] RD_Addr_Out 
            );
          
    // Based on the value in the Opcode i.e., Inst[6:2] -> 5bits
    parameter IMMEDIATE_TYPE = 5'b00100;
    parameter REGISTER_REGISTER_TYPE = 5'b01100;
    parameter LOAD_TYPE = 5'b00000;
    parameter STORE_TYPE = 5'b01000;
    parameter BRANCH_TYPE = 5'b11000;
    parameter MAC_TYPE = 5'b11111;
    
    initial
    begin
        Imm_Data_Out <= 32'dx;
        RD_Addr_Out <= 5'dx;
        Operation_Type_Out <= 10'dx;
    end
    
    always@(*)
    begin
        if((clk == 1'b0) && (stall_ctrl_in == 1))
        begin
            Imm_Data_Out <= 32'dx;
            Inst_Type_Out <= 5'dx;
            RD_Addr_Out <= 5'dx;
            Operation_Type_Out <= 10'dx;
        end
        else
        begin
        RD_Addr_Out <= RD_Addr_In;
        
        //Sign Extending the Immediate Data
        case(Inst_In[6:2])
            IMMEDIATE_TYPE  : Imm_Data_Out <= {{20{Inst_In[31]}},{Inst_In[31:20]}};
            // Immediate values of Load are encoded similar to Immediate type Instruction
            LOAD_TYPE       : Imm_Data_Out <= {{20{Inst_In[31]}},{Inst_In[31:20]}};
            STORE_TYPE      : Imm_Data_Out <= {{20{Inst_In[31]}},{Inst_In[31:25]},{Inst_In[11:7]}};
            //Recheck the Immediate encoding for Branch instruction. What is the offset[0] in this case.
            BRANCH_TYPE     : Imm_Data_Out <= {{20{Inst_In[31]}},{Inst_In[31]},{Inst_In[7]},{Inst_In[30:25]},{Inst_In[11:8]}};
            default : Imm_Data_Out <= 32'd0;
        endcase
        
        Inst_Type_Out <= Inst_In[6:2];
        Operation_Type_Out <= {{Inst_In[31:25]},{Inst_In[14:12]}};
        end
    end
    
endmodule
