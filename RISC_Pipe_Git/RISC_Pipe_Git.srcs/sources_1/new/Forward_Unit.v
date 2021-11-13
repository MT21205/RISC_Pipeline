`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.11.2021 17:19:49
// Design Name: 
// Module Name: Forward_Unit
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


module Forward_Unit(
			input [4:0] ID_RD_Addr_In,
			input [4:0] EX_RD_Addr_In,      
			input [4:0] MEM_RD_Addr_In,
			input [4:0] WB_RD_Addr_In,
			input [4:0] ID_RS1_Addr_In,
			input [4:0] ID_RS2_Addr_In,
			input [4:0] EX_Inst_Type_In,
			input [31:0] EX_Result_In,
			input [31:0] MA_Result_In,
			input [31:0] WB_Result_In,
			input clk,
			output reg Forward_RS1_Out,
			output reg Forward_RS2_Out,
			output reg stall_ctrl_out,
			output reg [31:0] Fwd_Result_Out
			);  




    parameter IMMEDIATE_TYPE = 5'b00100;			
    parameter REGISTER_TYPE = 5'b01100;				
    parameter LOAD_TYPE = 5'b00000;					
    parameter STORE_TYPE = 5'b01000;				
    parameter BRANCH_TYPE = 5'b11000;				
    parameter MAC_TYPE = 5'b11111;
        
    initial
    begin
        Forward_RS1_Out <= 0;
		Forward_RS2_Out <= 0;
		stall_ctrl_out <= 0;
		Fwd_Result_Out <= 0;
    end

	always@(negedge clk)
	begin        
        if(EX_Inst_Type_In == LOAD_TYPE)   
        begin                  
               if((EX_RD_Addr_In == ID_RS1_Addr_In) || (EX_RD_Addr_In == ID_RS2_Addr_In))
                    stall_ctrl_out <= 1'b1;
        end
        
      // If the Instruction in the Execute stage isn't LOAD
      else
      begin
        stall_ctrl_out <= 0;
        
      // Decode_Execute stage data dependancy
        if(EX_RD_Addr_In == ID_RS1_Addr_In)
        begin
            Fwd_Result_Out <= EX_Result_In;
            Forward_RS1_Out <= 1'b1;
            Forward_RS2_Out <= 1'b0;
        end
        else if(EX_RD_Addr_In == ID_RS2_Addr_In)
        begin
            Fwd_Result_Out <= EX_Result_In;
            Forward_RS1_Out <= 1'b0;
            Forward_RS2_Out <= 1'b1;
        end
        
        // Decode_Memory stage data dependancy
        else if(MEM_RD_Addr_In == ID_RS1_Addr_In)
        begin
            Fwd_Result_Out <= MA_Result_In;
            Forward_RS1_Out <= 1'b1;
            Forward_RS2_Out <= 1'b0;
        end
        else if(MEM_RD_Addr_In == ID_RS2_Addr_In)
        begin
            Fwd_Result_Out = MA_Result_In;
            Forward_RS1_Out <= 1'b0;
            Forward_RS2_Out <= 1'b1;
        end
        
        // WriteBack_Memory stage data dependancy
        else if(WB_RD_Addr_In == ID_RS1_Addr_In)
        begin
            Fwd_Result_Out <= WB_Result_In;
            Forward_RS1_Out <= 1'b1;
            Forward_RS2_Out <= 1'b0;
        end
        else if(WB_RD_Addr_In == ID_RS2_Addr_In)
        begin
            Fwd_Result_Out <= WB_Result_In;
            Forward_RS1_Out <= 1'b0;
            Forward_RS2_Out <= 1'b1;
        end
        else
        begin
            Forward_RS1_Out <= 1'b0;
            Forward_RS2_Out <= 1'b0;
        end
      end
    end
endmodule
