-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PIPELINE_IF_ID IS
	PORT (
		CLK			: IN STD_LOGIC; -- clock.
		RST			: IN STD_LOGIC; -- async. clear.
		WE  		: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		PC_4_IN		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Instr_IN	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- OUTPUTS
		PC_4_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- output
		Instr_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
	);
END PIPELINE_IF_ID;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PIPELINE_IF_ID IS
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
			PC_4_OUT		<= x"00000000"	after 10 ns;
			-- value after reset shouldn't be all zeros bc that's is an actual
			-- instruction
			Instr_OUT		<= x"40000000"	after 10 ns;
		ELSIF rising_edge(clk) THEN
			IF WE = '1' THEN
				PC_4_OUT	<= PC_4_IN		after 10 ns;
				Instr_OUT	<= Instr_IN		after 10 ns;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------