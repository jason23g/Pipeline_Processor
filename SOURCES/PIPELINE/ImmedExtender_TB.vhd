-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY ImmedExtender_TB IS
END ImmedExtender_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF ImmedExtender_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT ImmedExtender
	PORT (
		ctrl	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Instr	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Immed	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL ctrl		: STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Instr	: STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL Immed	: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : ImmedExtender
	PORT MAP (
		ctrl	=> ctrl,
		Instr	=> Instr,
		Immed	=> Immed
	);

	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		ctrl	<= "00";
		Instr	<= "0000011110000111";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "00";
		Instr	<= "1111100001111000";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "01";
		Instr	<= "0000011110000111";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "01";
		Instr	<= "1111100001111000";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "10";
		Instr	<= "0000011110000111";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "10";
		Instr	<= "1111100001111000";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "11";
		Instr	<= "0000011110000111";
		WAIT FOR 100 ns;
		
		
		ctrl	<= "11";
		Instr	<= "1111100001111000";
		WAIT FOR 100 ns;
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------