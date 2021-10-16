`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 19:29:49
// Design Name: 
// Module Name: Register_File
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


module Register_File(input Inst_In,
          input Reg_Write_flag_In,
          input RS1_Addr_In,
          input RS2_Addr_In,
          input RD_Addr_In,
          input RD_Data_In,
          output RS1_Data_Out,
          output RS2_Data_Out
                     );
                     
    parameter reg_cnt = 32;
    reg [31:0] register_memory [0:reg_cnt];
    integer i,out;
    reg [31:0]RS1_Data_Out, RS2_Data_Out;
    
    wire[5:0] RS1_Addr_In;
    wire[5:0] RS2_Addr_In;
    wire[5:0] RD_Addr_In;
    wire[31:0] RD_Data_In;
    
    //Initialize the operands A and B
    initial
    begin
        RS1_Data_Out <= 32'd0; // Operand A
        RS2_Data_Out <= 32'd0; // Operand B
    end
    
    initial
    begin
        out = $fopen("D:/College/IIITD/Others/Verilog_Lab/RISV_Pipe_Test/RISV_Pipe_Test.srcs/sources_1/new/Register_Memory.txt","r");
        for (i = 0; i < reg_cnt+1; i = i + 1)
        begin
            //Reading the contents of the register
            $fscanf(out,"%b\n",register_memory[i]); 
        end
        
    end
    
    always@(*)
    begin
        if(Reg_Write_flag_In == 1'd1)
            register_memory[RD_Addr_In] <= RD_Data_In;
        else
            //temp reg
            register_memory[32] <= 32'd0;
            
        RS1_Data_Out <= register_memory[RS1_Addr_In];
        RS2_Data_Out <= register_memory[RS2_Addr_In];
        
    end
                 
    

endmodule
