`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2021 18:17:17
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(
                    //input Inst_In,
                    input Inst_Type_In,
                    input Store_Operand_B_Data_In,
                    input Ld_Str_Addr_Reg_Result_In,
                    input RD_Addr_In,
                    output Register_Data_Out,
                    output RD_Addr_Out,
                    output Inst_Type_Out
                    );

    parameter DATA_MEM_SIZE = 1024; // Memory of 1024 words.
    
    // Based on the value in the Opcode i.e., Inst[6:2] -> 5bits
    parameter LOAD_TYPE = 5'b00000;
    parameter STORE_TYPE = 5'b01000;
    
    integer mem_idx;
    integer mem_reader;
    
    //wire[31:0] Inst_In;
    wire[4:0] Inst_Type_In;
    wire[31:0] Store_Operand_B_In;
    wire[4:0] RD_Addr_In;
    
    // Ld_Str_Addr_Reg_Result_In can have either of the following data:
    // a) Address in memory from where the data to the register has to be loaded
    // b) Address in memory at which the data in register rs2 has to be stored
    // c) Rsult from the arithematic functions
    // d) Branch Address
    
    wire[31:0] Ld_Str_Addr_Reg_Result_In;
    
    // Register_Data_Out can have either of the information:
    // a) Data in the memory which has to be written to the destination register.
    // b) Arithematic Result from the execute stage to be written to the destination register.
    
    reg[31:0] Register_Data_Out;
    reg[4:0] Inst_Type_Out;
    reg[4:0] RD_Addr_Out;
    
    // Data Memory
    reg[31:0] Data_Memory[0:DATA_MEM_SIZE-1];
    
    
    initial
    begin        
        //mem_reader = $fopen("D:/College/IIITD/Others/Verilog_Lab/RISV_Pipe_Test/RISV_Pipe_Test.srcs/sources_1/new/Data_Memory.txt","r");
        mem_reader = $fopen("Data_Memory.txt","r");
        for (mem_idx = 0; mem_idx < DATA_MEM_SIZE+1; mem_idx = mem_idx + 1)
        begin
            //Reading the contents of the register
            $fscanf(mem_reader,"%b\n",Data_Memory[mem_idx]);
        end
        
    end
    
    initial
    begin
        Register_Data_Out <= 32'dx;
        Inst_Type_Out <= 32'dx;
        RD_Addr_Out <= 5'dx;
    end
    
    always@(*)
    begin
        Inst_Type_Out <= Inst_Type_In;
        RD_Addr_Out <= RD_Addr_In;
        case(Inst_Type_In)
            LOAD_TYPE   : Register_Data_Out <= Data_Memory[Ld_Str_Addr_Reg_Result_In];
            STORE_TYPE  : 
                begin
                    Register_Data_Out <= 32'd0;
                    Data_Memory[Ld_Str_Addr_Reg_Result_In] <= Store_Operand_B_Data_In;
                end
            // For the Immediate, Register-Register type, bypass the Arithematic incoming result to RW stage.
            default     : Register_Data_Out <= Ld_Str_Addr_Reg_Result_In;
        endcase
    end
endmodule
