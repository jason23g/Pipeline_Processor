-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PIPELINE_EX_MEM IS
	PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		-- for branches
		ALU_Zero_IN				: IN STD_LOGIC;
		PC_Immed_IN				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		-- for load word/store word/R-type/I-type
		ALU_Result_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for store word
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		RF_B_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for load word/ R-type/I-type
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		-- for branches
		ALU_Zero_OUT			: OUT STD_LOGIC;
		PC_Immed_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		-- for load word/store word/R-type/I-type
		ALU_Result_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for store word
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		RF_B_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for load word/ R-type/I-type
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
END PIPELINE_EX_MEM;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PIPELINE_EX_MEM IS
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
				ALU_Zero_OUT		<= '0' 			after 10 ns;
				PC_Immed_OUT		<= x"00000000" 	after 10 ns;
				BranchEq_OUT		<= '0' 			after 10 ns;
				BranchNotEq_OUT		<= '0' 			after 10 ns;
				Jump_OUT			<= '0' 			after 10 ns;
				ALU_Result_OUT		<= x"00000000" 	after 10 ns;
				MEM_WrEn_OUT		<= '0' 			after 10 ns;
				ByteOp_OUT			<= '0' 			after 10 ns;
				RF_B_OUT 			<= x"00000000" 	after 10 ns;
				Write_Register_OUT	<= "00000" 		after 10 ns;
				RF_WrEn_OUT			<= '0' 			after 10 ns;
				RF_WrData_sel_OUT 	<= '0' 			after 10 ns;
		ELSIF rising_edge(clk) THEN
			IF WE = '1' THEN
				ALU_Zero_OUT		<= ALU_Zero_IN 			after 10 ns;
				BranchEq_OUT		<= BranchEq_IN 			after 10 ns;
				BranchNotEq_OUT		<= BranchNotEq_IN 		after 10 ns;
				Jump_OUT			<= Jump_IN 				after 10 ns;
				PC_Immed_OUT		<= PC_Immed_IN 			after 10 ns;
				RF_B_OUT 			<= RF_B_IN 				after 10 ns;
				ALU_Result_OUT		<= ALU_Result_IN 		after 10 ns;
				MEM_WrEn_OUT		<= MEM_WrEn_IN 			after 10 ns;
				ByteOp_OUT			<= ByteOp_IN 			after 10 ns;
				Write_Register_OUT	<= Write_Register_IN 	after 10 ns;
				RF_WrEn_OUT			<= RF_WrEn_IN 			after 10 ns;
				RF_WrData_sel_OUT	<= RF_WrData_sel_IN 	after 10 ns;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------