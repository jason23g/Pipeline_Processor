-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY MUX_HAZARD IS
	PORT (
		Ctrl 					: IN STD_LOGIC;
		Op_IN					: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_IN 			: IN STD_LOGIC;
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		Op_OUT					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_OUT 		: OUT STD_LOGIC;
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
END MUX_HAZARD;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF MUX_HAZARD IS

BEGIN
	PROCESS (Ctrl, Op_IN, ALU_Bin_sel_IN, BranchEq_IN, BranchNotEq_IN,
			Jump_IN, MEM_WrEn_IN, ByteOp_IN, RF_WrEn_IN, RF_WrData_sel_IN)
	BEGIN
		CASE Ctrl IS
			WHEN '0'	=>	Op_Out					<= Op_IN		 after 10 ns;
							ALU_Bin_sel_Out 		<= ALU_Bin_sel_IN after 10 ns;
							BranchEq_OUT			<= BranchEq_IN	 after 10 ns;
							BranchNotEq_OUT			<= BranchNotEq_IN after 10 ns;
							Jump_OUT				<= Jump_IN		 after 10 ns;
							MEM_WrEn_OUT			<= MEM_WrEn_IN	 after 10 ns;
							ByteOp_OUT				<= ByteOp_IN	 after 10 ns;
							RF_WrEn_OUT				<= RF_WrEn_IN	 after 10 ns;
							RF_WrData_sel_OUT		<= RF_WrData_sel_IN after 10 ns;

			WHEN '1'	=>	Op_Out					<= "1111" after 10 ns;
							ALU_Bin_sel_Out 		<= '0' after 10 ns;
							BranchEq_OUT			<= '0' after 10 ns;
							BranchNotEq_OUT			<= '0' after 10 ns;
							Jump_OUT				<= '0' after 10 ns;
							MEM_WrEn_OUT			<= '0' after 10 ns;
							ByteOp_OUT				<= '0' after 10 ns;
							RF_WrEn_OUT				<= '0' after 10 ns;
							RF_WrData_sel_OUT		<= '0' after 10 ns;

			WHEN OTHERS =>	Op_Out					<= "1111" after 10 ns;
							ALU_Bin_sel_Out 		<= '0' after 10 ns;
							BranchEq_OUT			<= '0' after 10 ns;
							BranchNotEq_OUT			<= '0' after 10 ns;
							Jump_OUT				<= '0' after 10 ns;
							MEM_WrEn_OUT			<= '0' after 10 ns;
							ByteOp_OUT				<= '0' after 10 ns;
							RF_WrEn_OUT				<= '0' after 10 ns;
							RF_WrData_sel_OUT		<= '0' after 10 ns;
		END CASE;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------