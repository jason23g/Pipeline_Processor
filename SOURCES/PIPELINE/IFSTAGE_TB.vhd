-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY IFSTAGE_TB IS
END IFSTAGE_TB;
--------------------------------------------------------------------------------
ARCHITECTURE behavior OF IFSTAGE_TB IS

    -- Component Declaration for the Unit Under Test (UUT)
	COMPONENT IFSTAGE
	PORT (
		PC_Immed	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_sel		: IN STD_LOGIC;
		PC_LdEn		: IN STD_LOGIC;
		Reset		: IN STD_LOGIC;
		Clk			: IN STD_LOGIC;
		PC			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
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
	SIGNAL PC_Immed	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL PC_sel	: STD_LOGIC := '0';
	SIGNAL PC_LdEn	: STD_LOGIC := '0';
	SIGNAL Reset	: STD_LOGIC := '0';
	SIGNAL Clk		: STD_LOGIC := '0';
	
	--Outputs
	SIGNAL PC		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL inst_dout	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Clock period definitions
	CONSTANT Clk_period : TIME := 100 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: IFSTAGE PORT MAP (
		PC_Immed	=> PC_Immed,
		PC_sel		=> PC_sel,
		PC_LdEn		=> PC_LdEn,
		Reset		=> Reset,
		Clk			=> Clk,
		PC			=> PC
	);
	
	ram_inst : RAM PORT MAP (
		clk			=> Clk,
		inst_addr	=> PC(12 DOWNTO 2),
		inst_dout	=> inst_dout,
		data_we		=> '0',
		data_addr	=> "00100000000",
		data_din	=> x"00000000"
--		data_dout	=> data_dout
	);
	
	-- Clock process definitions
	Clk_process : PROCESS
	BEGIN
		Clk <= '0';
		WAIT FOR Clk_period/2;
		Clk <= '1';
		WAIT FOR Clk_period/2;
	END PROCESS;
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- hold reset state for 4 cycles.
		Reset <= '0';
		WAIT FOR Clk_period*3;
		
		--plus 4 for 4 cycles
		PC_Immed	<= "00000000011110000011111100000000";
		PC_sel		<= '0';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period*6;
		
		--wait state
		PC_LdEn	<= '0';
		WAIT FOR Clk_period*2;
		
		-- load the immediate value
		PC_Immed	<= "00000000000000000000000111111110";
		PC_sel		<= '1';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period*2;
		
		-- ovf
		PC_Immed	<= "11111111111111111111111111111111";
		PC_sel		<= '1';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period;
		
		--plus 4 for 4 cycles
		PC_Immed	<= "00000000011110000011111100000000";
		PC_sel		<= '0';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period*4;
		
		Reset <= '0';
		WAIT FOR Clk_period;
		
		--plus 4
		PC_Immed	<= "00000000000000000000000000000000";
		PC_sel		<= '0';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period;
		
		--minus 4
		PC_Immed	<= "11111111111111111111111111111110";
		PC_sel		<= '1';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period;
		
		--plus 4
		PC_Immed	<= "00000000000000000000000000000000";
		PC_sel		<= '0';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period;
		
		--minus 4
		PC_Immed	<= "11111111111111111111111111111110";
		PC_sel		<= '1';
		PC_LdEn		<= '1';
		Reset		<= '1';
		WAIT FOR Clk_period;
		
		Reset		<= '0';
		WAIT FOR 140ns;
		
		Reset		<= '1';
		PC_LdEn 	<= '0';
		WAIT FOR Clk_period;
		WAIT;
	END PROCESS;

END;
-------------------------------------------------------------------------------