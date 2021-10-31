********************************************************************
This is the knowhow file of the project and the pipeline execution
********************************************************************

*******************************************************************************************************************
                                      File Naming Conventions Used
*******************************************************************************************************************

/////////////////////////////////////////////// Design Source ///////////////////////////////////////////////

1. IF             -> Module implementation of the Instruction Fetch phase.
2. IF_DE_REG      -> Module implementation of the pipeline register between the Fetch and Decode phase.
3. Register_File  -> Module implementation of the Register File.
4. ID             -> Module implementation of the Instruction Decode phase.
5. ID_EX_reg      -> Module implementation of the pipeline register between the Decode and Execute phase.
6. EX             -> Module implementation of the Execute phase.
7. EX_MA_reg      -> Module implementation of the pipeline register between the Execute and Memory Access phase.
8. Data_Memory    -> Module implementation of the Memory Access phase.
9. MA_RW_reg      -> Module implementation of the pipeline register between the Memory Access and Register Writeback phase.
10. RW            -> Module implementation of the Register Writeback phase.

/////////////////////////////////////////////// Design Source ///////////////////////////////////////////////

/////////////////////////////////////////////// Simulation Sources ///////////////////////////////////////////////

1. IF_ID_EX_MA_RW_Test_tb   -> This is the testbench required to test the above module.

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
IF_ID_EX_MA_RW_Test_tb.v

Output Register File:
Output_RegFile.txt

Process to test:
1. Import the Project.
2. Make sure the simulation source "IF_ID_EX_MA_RW_Test_tb.v" is enabled as the top module.
3. Run the behavioural simulation.
4. Observe the output waveforms to validate the functionality.













