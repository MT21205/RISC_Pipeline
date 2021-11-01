`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2021 11:29:38
// Design Name: 
// Module Name: IF
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


module IF(input in_Addr,
          input isBranchTaken,
          input clk,
          output Inst_Out 
    );
    
    parameter Mem_Size = 12;
    
    //From the branch execute stage, the multiplexed BranchAddress or current PC address is sent as PC_In_Addr 
    reg[31:0] PC;
    //An Additional reg NPC is used only for notation and debug purpose
    reg[31:0] NPC;
    reg[31:0] Inst_Out; 
    wire isBranchTaken;
    wire[31:0] in_Addr;
    wire clk;
    
    //Instruction Reg and Memory
    reg [31:0] Instruction;
    reg [31:0] Inst_memory [0:Mem_Size-1];
    integer mem_read;
    
    
    
    //Initialize PC
    initial
    begin
        PC <= 32'd0;
        NPC <= 32'd0;
        Inst_Out <= 32'd0;
    end
    
    //Initialize Memory
    /*
    initial
    begin
        for(integer idx=0; idx < Mem_Size; idx = idx+1)
        begin
            Inst_memory[idx] <= 32'd0;
        end
    end
    */
    
    //Read the contents of the Instruction Memory
    //always@(posedge clk)
    initial 
    begin
        //$readmemb("./Instruction_Memory.txt", mem_read)
        //mem_read = $fopen("D:/College/IIITD/Others/Verilog_Lab/RISV_Pipe_Test/RISV_Pipe_Test.srcs/sources_1/new/Instruction_Memory.txt","r");
        mem_read = $fopen("Instruction_Memory.txt","r");
        //mem_read = $fopen("/Instruction_Memory.txt","r");
        for (integer idx = 0; idx < Mem_Size; idx = idx+1)
        begin
            $fscanf(mem_read,"%b\n",Inst_memory[idx]);
            //$display("%d",Inst_memory[idx]);
        end
    end    

    //The PC register isn't Implemented seperately.
    //Instead it is included in IF stage itself to fetch the PC appropriately with the clk as the reference.
    always@(posedge clk)
    begin
    /*
        Inst_Out <= Inst_memory[PC];
        
        if(isBranchTaken == 1)
            PC <= in_Addr;
        else
            PC <= PC+32'd1;
    */
        PC = NPC;
        if(isBranchTaken == 1'd1)
        begin
            PC = in_Addr;
            Inst_Out = Inst_memory[PC];
        end
        else
            Inst_Out = Inst_memory[PC];
        
        NPC = PC + 32'd1;

    end
    
endmodule
