`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2021 19:06:02
// Design Name: 
// Module Name: EX
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


module EX(
            input[31:0] Operand_A_val_In,
            input[31:0] Operand_B_val_In,
            input[31:0] Immx_Data_In,
            input[4:0] Inst_Type_In,
            input[4:0] RD_Addr_In,
            input[9:0] Operation_Type_In,
            output reg isBranchTaken_Out,
            
            // Result_Out is a 32-bit value representing either of the following:
            // a) Arithematic expression outcome
            // b) Branch Address
            // c) Address in Memory for load or Store
            output reg[31:0] Result_Out,
            output reg[31:0] Operand_B_Out,
            output reg[4:0] Inst_Type_Out,
            output reg[4:0] RD_Addr_Out
    );
    
    parameter IMMEDIATE_TYPE = 5'b00100;
    parameter REGISTER_REGISTER_TYPE = 5'b01100;
    parameter LOAD_TYPE = 5'b00000;
    parameter STORE_TYPE = 5'b01000;
    parameter BRANCH_TYPE = 5'b11000;
    parameter MAC_TYPE = 5'b11111;
    
    // For reg-reg operation, function is specified in the funct7 and funct3
    // funct7 -> Inst[31:25] 
    // funct3 -> Inst[14:12]
    parameter AND = 10'b0000000111;
    parameter OR = 10'b0000000110;
    parameter ADD = 10'b0000000000;
    parameter SUB = 10'b0100000000;
    parameter SLL = 10'b0000000001;
    parameter SRA = 10'b0100000101;
      
    
    initial
    begin
        isBranchTaken_Out <= 1'd0;
        Result_Out <= 32'dx;
        Operand_B_Out <= 32'd0;
        Inst_Type_Out <= 5'dx;
        RD_Addr_Out <= 5'dx;
    end
    
    always@(*)
    begin
        Inst_Type_Out <= Inst_Type_In;
        RD_Addr_Out <= RD_Addr_In;
        
        // The beanch taken flag is always initialized to zero
        // before processing any instruction.
        // If the branch has to be taken in current execution,
        // then the flag is set in the Branch execution case.
        isBranchTaken_Out <= 1'd0;
        
        case(Inst_Type_In) // Opcode.  This give the information on the type of the instruction
            IMMEDIATE_TYPE : 
                begin
                    Result_Out <= Operand_A_val_In + Immx_Data_In;
                end
                
            REGISTER_REGISTER_TYPE : 
                begin
                    //Perform the required operation based on the function specified
                    // For reg-reg operation, function is specified in the funct7 and funct3
                    // funct7 -> Inst[31:25] 
                    // funct3 -> Inst[14:12]
                    
                    case(Operation_Type_In)
                        AND : Result_Out <= Operand_A_val_In & Operand_B_val_In;
                        OR  : Result_Out <= Operand_A_val_In | Operand_B_val_In;
                        ADD : Result_Out <= Operand_A_val_In + Operand_B_val_In;
                        SUB : Result_Out <= Operand_A_val_In - Operand_B_val_In;
                        // SLL, SRL, and SRA perform logical left, logical right, and arithmetic right shifts 
                        // on the value in register rs1 by  
                        // the shift amount held in the lower 5 bits of register rs2
                        SLL : Result_Out <= Operand_A_val_In << Operand_B_val_In[4:0];
                        SRA : Result_Out <= Operand_A_val_In >>> Operand_B_val_In[4:0];
                        default : Result_Out <= 32'd0;
                    endcase
                end
                
            LOAD_TYPE :
                begin
                    // Effective Address is obtained by adding rs1 to the immediate value. Here immediate datais the offset
                    // Operand A has the data of RS1
                    // Effictive Address <- Rs1 + Immediate_data
                    // rd <- Mem[rs1 + Immediate_data]
                    // Result_Out has the Offset Address
                    Result_Out <= Operand_A_val_In + Immx_Data_In;
                end
                
            STORE_TYPE :
                begin
                    // Effective Address is obtained by adding rs2 to the immediate value. Here immediate datais the offset
                    // Operand B has the data of RS2
                    // Effictive Address <- Rs1 + Immediate_data
                    // Mem[rs1 + Immediate_data] <- rs2
                    // For rs1 to be stored into the memory, ot has to be forwarded to the next stage. Hence, Operand_B_Out.
                    // Result_Out has the Offset Address 
                    Result_Out <= Operand_A_val_In + Immx_Data_In;
                    Operand_B_Out <= Operand_B_val_In;
                end
                
            BRANCH_TYPE :
                begin
                    if(Operand_A_val_In == Operand_B_val_In)
                    begin
                        Result_Out <= Immx_Data_In;
                        isBranchTaken_Out <= 1'd1;
                    end
                    else
                    begin
                        Result_Out <= 32'd0;
                        isBranchTaken_Out <= 1'd0;
                    end
                end
                
            MAC_TYPE :
                begin
                    Result_Out <= 32'd0;
                end
                
            default :
                begin
                    Result_Out <= 32'd0;
                    isBranchTaken_Out <= 1'd0;
                end  
                       
        endcase
    end
    
endmodule
