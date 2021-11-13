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


module IF(input[31:0] in_Addr,
          input isBranchTaken,
          input clk,
          input stall_ctrl_in,
          output reg[31:0] Inst_Out 
    );
    
    parameter Mem_Size = 1024;
    
    integer idx;
    
    //From the branch execute stage, the multiplexed BranchAddress or current PC address is sent as PC_In_Addr 
    reg[31:0] PC;
    //An Additional reg NPC is used only for notation and debug purpose
    reg[31:0] NPC;
    
    //Instruction Reg and Memory
    reg [31:0] Instruction;
    reg [31:0] Inst_memory [0:Mem_Size-1];
    integer mem_read;
    
    
    
    //Initialize PC
    initial
    begin
        PC <= 32'd0;
        NPC <= 32'd0;
        Inst_Out <= 32'dx;
    end
    
    
    //Read the contents of the Instruction Memory
    initial 
    begin
        //$readmemb("./Instruction_Memory.txt", mem_read)
        //mem_read = $fopen("D:/College/IIITD/Others/Verilog_Lab/RISV_Pipe_Test/RISV_Pipe_Test.srcs/sources_1/new/Instruction_Memory.txt","r");
        mem_read = $fopen("Instruction_Memory.txt","r");
        //mem_read = $fopen("/Instruction_Memory.txt","r");
        for (idx = 0; idx < Mem_Size; idx = idx+1)
        begin
            $fscanf(mem_read,"%b\n",Inst_memory[idx]);
            //$display("%d",Inst_memory[idx]);
        end
    end    

    //The PC register isn't Implemented seperately.
    //Instead it is included in IF stage itself to fetch the PC appropriately with the clk as the reference.
    always@(posedge clk)
    begin
    if(stall_ctrl_in != 1'b1)
        begin
            PC = NPC;
            if(isBranchTaken == 1'd1)
            begin
                PC = in_Addr*4;
                Inst_Out = Inst_memory[PC>>2];
            end
            else
                // As the PC is Byte addressable, and the instruction is 32-bits in size, the shift is carried out to access right instruction.
                Inst_Out = Inst_memory[PC>>2];
            
            NPC = PC + 32'd4;
        end
    else
        begin
        // If a stall signal is recieved from the stall control unit, 
        //The same previous instruction is being fetched in next cycle.
            PC = PC;
            NPC = NPC;
        end

    end
    
endmodule
