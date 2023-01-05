-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PROC_PIPELINE_TB IS
END PROC_PIPELINE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF PROC_PIPELINE_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT PROC_PIPELINE
	PORT (
		CLK				: IN STD_LOGIC;
		RST				: IN STD_LOGIC;
		inst_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		inst_dout		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we			: OUT STD_LOGIC;
		data_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_din		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT RAM
	PORT (
		clk				: IN STD_LOGIC;
		inst_addr		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		inst_dout		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we			: IN STD_LOGIC;
		data_addr		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		data_din		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	-- Inputs
	SIGNAL CLK				: STD_LOGIC := '0';
	SIGNAL RST				: STD_LOGIC := '0';

	SIGNAL inst_addr		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL inst_dout		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL data_we			: STD_LOGIC;
	SIGNAL data_addr		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL data_din			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL data_dout		: STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock period definitions
	CONSTANT CLK_period		: TIME := 100 ns;
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)

	uut : PROC_PIPELINE
	PORT MAP (
		CLK			=> CLK,
		RST			=> RST,
		inst_addr	=> inst_addr,
		inst_dout	=> inst_dout,
		data_we		=> data_we,
		data_addr	=> data_addr,
		data_din	=> data_din,
		data_dout	=> data_dout
	);

	ram_inst : RAM
	PORT MAP (
		clk			=> CLK,
		inst_addr	=> inst_addr(12 DOWNTO 2),
		inst_dout	=> inst_dout,
		data_we		=> data_we,
		data_addr	=> data_addr(12 DOWNTO 2),
		data_din	=> data_din,
		data_dout	=> data_dout
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
		WAIT FOR 100 ns;
		
		-- insert stimulus here
		RST <= '1';
		WAIT FOR CLK_period*30;
		--RST <= '0';
		
		WAIT;
	END PROCESS;

END;
-------------------------------------------------------------------------------