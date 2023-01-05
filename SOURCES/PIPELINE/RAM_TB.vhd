-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY RAM_TB IS
END RAM_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF RAM_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT RAM
	PORT (
		clk				: IN  STD_LOGIC;
		inst_addr		: IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		inst_dout		: OUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we			: IN  STD_LOGIC;
		data_addr		: IN  STD_LOGIC_VECTOR(10 DOWNTO 0);
		data_din		: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout		: OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL clk			: STD_LOGIC := '0';
	SIGNAL inst_addr	: STD_LOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0');
	SIGNAL data_we		: STD_LOGIC := '0';
	SIGNAL data_addr	: STD_LOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0');
	SIGNAL data_din		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	
	--Outputs
	SIGNAL inst_dout	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL data_dout	: STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock period definitions
	CONSTANT clk_period : TIME := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : RAM PORT MAP (
		clk			=> clk,
		inst_addr	=> inst_addr,
		inst_dout	=> inst_dout,
		data_we		=> data_we,
		data_addr	=> data_addr,
		data_din	=> data_din,
		data_dout	=> data_dout
	);

	-- Clock process definitions
	clk_process : PROCESS
	BEGIN
		clk <= '0';
		WAIT FOR clk_period/2;
		clk <= '1';
		WAIT FOR clk_period/2;
	END PROCESS;
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
	
		-- stimulus here
		inst_addr	<= "00000000000";
		data_we		<= '0';
		data_addr	<= "10001100000";
		data_din	<= x"AABBCCDD";
		WAIT FOR clk_period;
		
		
		inst_addr	<= "00000000001";
		data_we		<= '1';
		data_addr	<= "10001100000";
		data_din	<= x"AABBCCDD";
		WAIT FOR clk_period;
		
		
		inst_addr	<= "00000000010";
		data_we		<= '0';
		data_addr	<= "11001100010";
		data_din	<= x"34567890";
		WAIT FOR clk_period;
		
		
		inst_addr	<= "00000000011";
		data_we		<= '1';
		data_addr	<= "10001100010";
		data_din	<= x"34567890";
		WAIT FOR clk_period;
		
		
		inst_addr	<= "00000001000";
		data_we		<= '0';
		data_addr	<= "10001100000";
		data_din	<= x"FFFFFFFF";
		WAIT FOR clk_period;
		WAIT;
	END PROCESS;

END;
-------------------------------------------------------------------------------