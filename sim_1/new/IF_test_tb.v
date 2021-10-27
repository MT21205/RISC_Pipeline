`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 13:30:38
// Design Name: 
// Module Name: IF_test_tb
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


module IF_test_tb;

    reg clk;
    
    reg[31:0] in_Addr;
    reg isBranchTaken;
    
    wire[31:0] IF_Inst_Out;
    wire[31:0] IF_DE_Inst_out;
    
    wire[4:0] IF_DE_RS1_Addr_out;
    wire[4:0] IF_DE_RS2_Addr_out;
    wire[4:0] IF_DE_RD_Addr_out;
    
    
    //PC_reg pc_reg(.in_addr(in_Addr), .clk(clk), .out_addr(out_addr));
    IF Instruction_Fetch (
                            //Inputs
                            .in_Addr(in_Addr), 
                            .isBranchTaken(isBranchTaken), 
                            .clk(clk), 
                            //Outputs
                            .Inst_Out(IF_Inst_Out)
                            );
    IF_DE_REG if_de_stage_reg (
                                //Inputs
                                .clk(clk), 
                                .Inst_In(IF_Inst_Out),
                                //Outputa 
                                .Inst_Out(IF_DE_Inst_out),
                                .RS1_Addr_out(IF_DE_RS1_Addr_out),
                                .RS2_Addr_out(IF_DE_RS2_Addr_out),
                                .RD_Addr_out(IF_DE_RD_Addr_out)
                                );
    
    initial
    begin
      in_Addr <= 32'd0;
      isBranchTaken <= 1'd0;
      clk <= 1'b0;  
    end
    
    always
    begin
        #5 clk <= ~clk;
    end
    
    initial
    begin
        //$monitor($time," %d ",Inst);
        #2
        in_Addr <= 32'd0; isBranchTaken <= 1'd0;
        #50 in_Addr <= 32'd2; isBranchTaken <= 1'd1;
        #10 in_Addr <= 32'd0; isBranchTaken <= 1'd0;     
        #20
        $finish;
        
    end
    
endmodule
