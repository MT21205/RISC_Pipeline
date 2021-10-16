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


module ID(input Inst_In,
          //output Opcode_Type,
          //output Operand_A,
          //output Operand_B,
          output Imm_Data_Out,
          output Inst_Out
          );
          
        
    //reg[3:0] Opcode_Type;
    //reg[31:0] Operand_A;
    //reg[31:0] Operand_B;
    reg[31:0] Imm_Data_Out;
    reg[31:0] Inst_Out;
    
    wire[31:0] Inst_In;
    
    initial
    begin
        //Operand_A <= 32'd0;
        //Operand_B <= 32'd0;
        Imm_Data_Out <= 32'd0;
        Inst_Out <= 32'd0;
    end
    
    always@(*)
    begin
        Inst_Out <= Inst_In;
        //Sign Extending the Immediate Data
        Imm_Data_Out <= {{16{Inst_In[15]}},{Inst_In[15:0]}};
    end
    
    
    
    
endmodule
