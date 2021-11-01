`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2021 11:59:07
// Design Name: 
// Module Name: IF_ID_EX_MAreg_Test_tb
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


module IF_ID_EX_MAreg_Test_tb;

    reg clk;
    reg[31:0] in_Addr;
    reg isBranchTaken;
    
    wire[31:0] IF_Inst_Out;
    wire[31:0] IF_DE_Inst_out;
        
    wire[4:0] IF_DE_RS1_Addr_out;
    wire[4:0] IF_DE_RS2_Addr_out;
    wire[4:0] IF_DE_RD_Addr_out;
    
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
    
    //Inputs and nets for EX Stage
    wire EX_isBranchTaken_Out;
    wire[31:0] EX_Result_Out;
    //wire[31:0] EX_Inst_Out;
    wire[31:0] EX_Operand_B_Out;
    wire[4:0] EX_Inst_Type_Out;
    
    //Inputs and nets for EX_MA Register
    wire[31:0] EX_MA_Result_Out;
    wire[31:0] EX_MA_Inst_Out;
    wire[31:0] EX_MA_Operand_B_Out;
    wire[4:0] EX_MA_Inst_Type_Out;
    
    IF Instruction_Fetch (
                            //Inputs
                            .in_Addr(in_Addr), 
                            .isBranchTaken(isBranchTaken), 
                            .clk(clk),
                            //Output 
                            .Inst_Out(IF_Inst_Out)
                            );
                            
    IF_DE_REG if_de_stage_reg (
                               //Inputs
                                .clk(clk), 
                                .Inst_In(IF_Inst_Out), 
                                //Outputs
                                .Inst_Out(IF_DE_Inst_out),
                                .RS1_Addr_out(IF_DE_RS1_Addr_out),
                                .RS2_Addr_out(IF_DE_RS2_Addr_out),
                                .RD_Addr_out(IF_DE_RD_Addr_out)
                                );
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
                            .RD_Addr_In(IF_DE_RD_Addr_out),
                            //outputs
                            .Inst_Out(ID_EX_Inst_out),
                            .Operand_A_val_Out(ID_EX_A_out),
                            .Operand_B_val_Out(ID_EX_B_out),
                            .Immx_Data_Out(ID_EX_Imm_Out),
                            .Inst_Type_Out(ID_EX_Inst_Type_Out),
                            .RD_Addr_Out(ID_EX_RD_Addr_Out)
                            );
                            
    EX execute(
                //Inputs
                .Inst_In(ID_EX_Inst_out),
                .Operand_A_val_In(ID_EX_A_out),
                .Operand_B_val_In(ID_EX_B_out),
                .Immx_Data_In(ID_EX_Imm_Out),
                .Inst_Type_In(ID_EX_Inst_Type_Out),
                .RD_Addr_In(ID_EX_RD_Addr_Out),
                //Outputs
                .isBranchTaken_Out(EX_isBranchTaken_Out),
                .Result_Out(EX_Result_Out),
                //.Inst_Out(EX_Inst_Out),
                .Operand_B_Out(EX_Operand_B_Out),
                .Inst_Type_Out(EX_Inst_Type_Out),
                .RD_Addr_Out(EX_RD_Addr_Out)
                );
    
    EX_MA_reg execute_ma_register(
                //Inputs
                //.isBranchTaken_Out(),
                .clk(clk),
                .Result_In(EX_Result_Out),
                .Inst_In(EX_Inst_Out),
                .Operand_B_In(EX_Operand_B_Out),
                .Inst_Type_In(EX_Inst_Type_Out),
                //Outputs
                .Result_Out(EX_MA_Result_Out),
                .Inst_Out(EX_MA_Inst_Out),
                .Operand_B_Out(EX_MA_Operand_B_Out),
                .Inst_Type_Out(EX_MA_Inst_Type_Out)
    );
    
    
    initial
    begin
        clk <= 1'd0;
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
    end
    
    always
        #5 clk <= ~clk;
        
    initial
    begin
        #2
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        
        /*
        #10
        in_Addr <= 32'd0;
        isBranchTaken <= 1'd0;
        Reg_Write_flag_In <= 1'd0;
        RD_Data_In <= 32'd0;
        */
        
        
        $finish;
    end
    
    
endmodule
