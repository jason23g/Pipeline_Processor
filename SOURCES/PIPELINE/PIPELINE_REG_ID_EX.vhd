-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PIPELINE_ID_EX IS
	PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		Opcode_IN				: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Op_IN					: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_IN 			: IN STD_LOGIC;
		RF_A_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed_IN				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rs_IN				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt_IN				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		Opcode_OUT				: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		--Control signals going to execution stage
		Op_OUT					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_OUT			: OUT STD_LOGIC;
		--Data signals for EXSTAGE
		RF_A_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		--Control signals going to mem stage
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		--Control signals for Write Back
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rs_OUT			: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt_OUT			: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
END PIPELINE_ID_EX;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PIPELINE_ID_EX IS
BEGIN
	PROCESS (CLK, RST, WE)
	BEGIN
		IF RST = '0' THEN
				-- value after reset for Opcode shouldn't be all zeros bc
				-- that's is an actual Opcode
				Opcode_OUT			<= "010000"			after 10 ns;
				OP_OUT 				<= "0000"			after 10 ns;
				ALU_Bin_sel_OUT 	<= '0'				after 10 ns;
				RF_A_OUT 			<= x"00000000"		after 10 ns;
				RF_B_OUT 			<= x"00000000"		after 10 ns;
				Immed_OUT 			<= x"00000000"		after 10 ns;
				PC_4_OUT 			<= x"00000000"		after 10 ns;
				BranchEq_OUT		<= '0'				after 10 ns;
				BranchNotEq_OUT		<= '0'				after 10 ns;
				Jump_OUT			<= '0'				after 10 ns;
				MEM_WrEn_OUT		<= '0'				after 10 ns;
				ByteOp_OUT			<= '0'				after 10 ns;
				Write_Register_OUT	<= "00000"			after 10 ns;
				ID_EX_Rs_OUT		<= "00000"			after 10 ns;
				ID_EX_Rt_OUT		<= "00000"			after 10 ns;
				RF_WrEn_OUT			<= '0'				after 10 ns;
				RF_WrData_sel_OUT 	<= '0'				after 10 ns;
		ELSIF rising_edge(clk) THEN
			IF WE = '1' THEN
				Opcode_OUT			<= Opcode_IN			after 10 ns;
				OP_OUT 				<= OP_IN				after 10 ns;
				ALU_Bin_sel_OUT 	<= ALU_Bin_sel_IN		after 10 ns;
				RF_A_OUT 			<= RF_A_IN				after 10 ns;
				RF_B_OUT 			<= RF_B_IN				after 10 ns;
				Immed_OUT 			<= Immed_IN				after 10 ns;
				PC_4_OUT 			<= PC_4_IN				after 10 ns;
				BranchEq_OUT		<= BranchEq_IN			after 10 ns;
				BranchNotEq_OUT		<= BranchNotEq_IN		after 10 ns;
				Jump_OUT			<= Jump_IN				after 10 ns;
				MEM_WrEn_OUT		<= MEM_WrEn_IN			after 10 ns;
				ByteOp_OUT			<= ByteOp_IN			after 10 ns;
				Write_Register_OUT	<= Write_Register_IN	after 10 ns;
				ID_EX_Rs_OUT		<= ID_EX_Rs_IN			after 10 ns;
				ID_EX_Rt_OUT		<= ID_EX_Rt_IN			after 10 ns;
				RF_WrEn_OUT			<= RF_WrEn_IN			after 10 ns;
				RF_WrData_sel_OUT	<= RF_WrData_sel_IN		after 10 ns;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------