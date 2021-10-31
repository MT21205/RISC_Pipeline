`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 21:16:41
// Design Name: 
// Module Name: Register_and_ID_test_tb
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


module Register_and_ID_test_tb;

    //Inputs and nets for Register
    reg clk;
    
    reg[31:0] IF_DE_Inst_out;
        
    reg[4:0] IF_DE_RS1_Addr_out;
    reg[4:0] IF_DE_RS2_Addr_out;
    reg[4:0] IF_DE_RD_Addr_out;
    
    //Inputs and nets for Register
    reg Reg_Write_flag_In;
    reg[31:0] RD_Data_In;
    
    wire[31:0] ID_RS1_Data_Out;
    wire[31:0] ID_RS2_Data_Out;
    
    //Inputs and nets for ID stage
    wire[31:0] ID_Imm_out;
    wire[31:0] ID_Inst_out;
    wire[4:0] ID_Inst_Type_out;
    
    //Inputs and nets for ID_EX Register
    wire[31:0] ID_EX_Inst_out;
    wire[31:0] ID_EX_A_out;
    wire[31:0] ID_EX_B_out;
    wire[31:0] ID_EX_Imm_Out;
    wire[4:0] ID_EX_Inst_Type_Out;
    
    
    
    Register_File reg_file(
                            //Inputs
                            .Inst_In(IF_DE_Inst_out),
                            .Reg_Write_flag_In(Reg_Write_flag_In),
                            .RS1_Addr_In(IF_DE_RS1_Addr_out),
                            .RS2_Addr_In(IF_DE_RS2_Addr_out),
                            .RD_Addr_In(IF_DE_RD_Addr_out),
                            .RD_Data_In(RD_Data_In),
                            //Outputs
                            .RS1_Data_Out(ID_RS1_Data_Out),
                            .RS2_Data_Out(ID_RS2_Data_Out)
                            );
    ID instruction_decode(
                            //Inputs
                            .Inst_In(IF_DE_Inst_out),
                            //Outputs
                            .Imm_Data_Out(ID_Imm_out),
                            .Inst_Out(ID_Inst_out),
                            .Inst_Type_Out(ID_Inst_Type_out)
                            );
                            
    ID_EX_reg inst_exec_reg(
                            //inputs
                            .clk(clk),
                            .Inst_In(ID_Inst_out),
                            .Operand_A_val_In(ID_RS1_Data_Out),
                            .Operand_B_val_In(ID_RS2_Data_Out),
                            .Immx_Data_In(ID_Imm_out),
                            .Inst_Type_In(ID_Inst_Type_out),
                            //outputs
                            .Inst_Out(ID_EX_Inst_out),
                            .Operand_A_val_Out(ID_EX_A_out),
                            .Operand_B_val_Out(ID_EX_B_out),
                            .Immx_Data_Out(ID_EX_Imm_Out),
                            .Inst_Type_Out(ID_EX_Inst_Type_Out)
                            );
    
    initial
    begin
        IF_DE_Inst_out <= 32'd0;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd0;
        IF_DE_RS2_Addr_out <= 32'd1;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;
        clk <= 0;
    end
    
    always #5 clk <= ~clk;
    
    initial
    begin
        #2
        #10
        IF_DE_Inst_out <= 32'd0;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd2;
        IF_DE_RS2_Addr_out <= 32'd3;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;

        #10
        IF_DE_Inst_out <= 32'd1;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd4;
        IF_DE_RS2_Addr_out <= 32'd5;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;

        #10
        IF_DE_Inst_out <= 32'd2;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd6;
        IF_DE_RS2_Addr_out <= 32'd7;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;

        #10
        IF_DE_Inst_out <= 32'd3;
        Reg_Write_flag_In <= 1'd1;
        IF_DE_RS1_Addr_out <= 32'd8;
        IF_DE_RS2_Addr_out <= 32'd9;
        IF_DE_RD_Addr_out <= 32'd1;
        RD_Data_In <= 32'd9;
        
        #10
        IF_DE_Inst_out <= 32'd2;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd1;
        IF_DE_RS2_Addr_out <= 32'd2;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;
        
        #10
        IF_DE_Inst_out <= 32'd2;
        Reg_Write_flag_In <= 1'd0;
        IF_DE_RS1_Addr_out <= 32'd1;
        IF_DE_RS2_Addr_out <= 32'd2;
        IF_DE_RD_Addr_out <= 32'd0;
        RD_Data_In <= 32'd0;

        $finish;
        
    end
    
endmodule
