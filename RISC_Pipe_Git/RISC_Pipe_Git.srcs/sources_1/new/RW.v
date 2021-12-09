`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2021 11:26:36
// Design Name: 
// Module Name: RW
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


module RW(
            input[31:0] Data_In,
            input[4:0] Inst_Type_In,
            input[4:0] RD_Addr_In,
            output reg[31:0] Data_Out,
            output reg Reg_Write_flag_Out,
            output reg[4:0] Dest_Reg_Addr_Out
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
        Data_Out <= 32'dx;
        Reg_Write_flag_Out <= 32'dx;
        Dest_Reg_Addr_Out <= 5'dx;
    end
    
    always@(*)
    begin
        Reg_Write_flag_Out <= 1'd0;
        Dest_Reg_Addr_Out <= 5'd0;
        case(Inst_Type_In)
            IMMEDIATE_TYPE,
            REGISTER_REGISTER_TYPE,
            LOAD_TYPE,               
            MAC_TYPE                :
                begin 
                    if(RD_Addr_In != 32'd0)
                    begin
                        Reg_Write_flag_Out <= 32'd1;
                        Data_Out <= Data_In;
                        Dest_Reg_Addr_Out <= RD_Addr_In;
                    end
                end
            default                 : Reg_Write_flag_Out <= 32'd0;
        endcase
    end

endmodule
