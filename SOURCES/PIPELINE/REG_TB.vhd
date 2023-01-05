-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------------
ENTITY REG_TB IS
END REG_TB;
-----------------------------------------------------------------------------
ARCHITECTURE behavior OF REG_TB IS

	COMPONENT REG
	PORT (
		CLK	: IN STD_LOGIC;
		RST	: IN STD_LOGIC;
		WE	: IN STD_LOGIC;
		d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL CLK	: STD_LOGIC := '0';
	SIGNAL RST	: STD_LOGIC := '0';
	SIGNAL WE	: STD_LOGIC := '0';
	SIGNAL d	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL q : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock period definitions
	CONSTANT CLK_period : TIME := 100 ns;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : REG
	PORT MAP (
		CLK		=> CLK,
		RST		=> RST,
		WE		=> WE,
		d		=> d,
		q		=> q
	);

	-- Clock process definitions
	CLK_process : PROCESS
	BEGIN
		CLK <= '0';
		WAIT FOR CLK_period/2;
		CLK <= '1';
		WAIT FOR CLK_period/2;
	END PROCESS;
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- hold reset state for 100 ns.
		RST <= '0';
		WAIT FOR CLK_period;
		
		-- insert stimulus here
		-- will write value in input
		RST	<= '1';
		WE	<= '1';
		d	<= "10000000000000000000000000000001";
		WAIT FOR CLK_period;
		
		-- will not write and output is 0
		RST	<= '0';
		WE	<= '1';
		d	<= "11001101010100000111010011111110";
		WAIT FOR CLK_period;
		
		-- holds last value, will not write
		RST	<= '1';
		WE	<= '0';
		d	<= "11111111111111111111111111111111";
		WAIT FOR CLK_period;
		
		-- will not write and output is 0
		RST	<= '0';
		WE	<= '0';
		d	<= "11111111111111111100001111111111";
		WAIT FOR CLK_period;
		
		-- just writes the values in input
		RST	<= '1';
		WE	<= '1';
		d	<= "11001101010100000111010011111110";
		WAIT FOR CLK_period;
		
		RST	<= '1';
		WE	<= '1';
		d	<= "11110111011000001111111111011111";
		WAIT FOR CLK_period;
		
		RST	<= '1';
		WE	<= '1';
		d	<= "01010101010111010101100101010100";
		WAIT FOR CLK_period;
		WAIT;
		
	END PROCESS;

END;
-----------------------------------------------------------------------------