-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PIPELINE_MEM_WB IS
	PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		ALU_Result_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- will be connected with MEM_DataOut output of MEMSTAGE
		MM_RdData_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		ALU_Result_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_RdData_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		--Control signals for Write Back
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
END PIPELINE_MEM_WB;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PIPELINE_MEM_WB IS
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
				ALU_Result_OUT		<= x"00000000"			after 10 ns;
				MM_RdData_OUT		<= x"00000000"			after 10 ns;
				Write_Register_OUT	<= "00000"				after 10 ns;
				RF_WrEn_OUT			<= '0'					after 10 ns;
				RF_WrData_sel_OUT	<= '0'					after 10 ns;
		ELSIF rising_edge(clk) THEN
			IF WE = '1' THEN
				ALU_Result_OUT		<= ALU_Result_IN		after 10 ns;
				MM_RdData_OUT		<= MM_RdData_IN			after 10 ns;
				Write_Register_OUT	<= Write_Register_IN	after 10 ns;
				RF_WrEn_OUT			<= RF_WrEn_IN			after 10 ns;
				RF_WrData_sel_OUT	<= RF_WrData_sel_IN		after 10 ns;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------