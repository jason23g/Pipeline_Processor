-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY ALU_CONTROL_TB IS
END ALU_CONTROL_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF ALU_CONTROL_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT ALU_CONTROL
	PORT (
		ALU_Op	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		func	: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Op		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL ALU_Op	: STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
	SIGNAL func		: STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL Op		: STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : ALU_CONTROL
	PORT MAP (
		ALU_Op	=> ALU_Op,
		func	=> func,
		Op		=> Op
	);
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		ALU_Op	<= "000";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "001";
		func	<= "110010";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "011";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "010";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "100";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "001";
		func	<= "110001";
		WAIT FOR 100 ns;

----------------- R-type instruction -----------------

		ALU_Op	<= "000";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "000";
		func	<= "110010";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "000";
		func	<= "110011";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "000";
		func	<= "111100";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "000";
		func	<= "110000";
		WAIT FOR 100 ns;
		
		ALU_Op	<= "000";
		func	<= "110101";
		WAIT FOR 100 ns;
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------