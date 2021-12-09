********************************************************************
                   Team Members (Project 2)
********************************************************************
1. Ranjith Srinivas AB    – MT21205
2. Momin Haider           – MT21197
3. Kazi Soaib Ikbal       – MT21194


********************************************************************
This is the knowhow file of the project and the pipeline execution
********************************************************************

*******************************************************************************************************************
                                      File Naming Conventions Used
*******************************************************************************************************************

/////////////////////////////////////////////// Design Source ///////////////////////////////////////////////

1. IF.v             -> Module implementation of the Instruction Fetch phase.
2. IF_DE_REG.v      -> Module implementation of the pipeline register between the Fetch and Decode phase.
3. Register_File.v  -> Module implementation of the Register File.
4. ID.v             -> Module implementation of the Instruction Decode phase.
5. ID_EX_reg.v      -> Module implementation of the pipeline register between the Decode and Execute phase.
6. EX.v             -> Module implementation of the Execute phase.
7. EX_MA_reg.v      -> Module implementation of the pipeline register between the Execute and Memory Access phase.
8. Data_Memory.v    -> Module implementation of the Memory Access phase.
9. MA_RW_reg.v      -> Module implementation of the pipeline register between the Memory Access and Register Writeback phase.
10. RW.v            -> Module implementation of the Register Writeback phase.
11. Forward_Unit.v  -> Module implementation of the forwarding and stall control unit.

/////////////////////////////////////////////// Design Source ///////////////////////////////////////////////

/////////////////////////////////////////////// Simulation Sources ///////////////////////////////////////////////

1. forwarding_Test_tb   -> This is the testbench required to test the above pipeline module.

/////////////////////////////////////////////// Simulation Sources ///////////////////////////////////////////////



*******************************************************************************************************************
                                              Testing Procedure
*******************************************************************************************************************

Note:
Please import the project using the "RISC_Pipe_Git.xpr" file from the repository.

Binaries Used:
1. Instruction_Memory.txt     // Encoded Instruction Memory in Binary.
2. Register_Memory.txt        // 32-bit Binary Register Memory. These are the initial values in the register.
3. Data_Memory.txt            // 32-bit Binary Data Memory.

Testbench to be used:
forwarding_Test_tb.v

Output Register File:
Updated_Reg_Mem.txt -> This file is present in the path "RISC_Pipe_Git.sim\sim_1\behav\xsim" from the project root directory.

Process to test:
1. Import the Project.
2. Make sure the simulation source "forwarding_Test_tb.v" is enabled as the top module.
3. Select "Flow -> Run Simulation -> Run Behavioural Simulation" to run the testbench.
4. Observe the output waveforms to validate the functionality.













