-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY MEMSTAGE_TB IS
END MEMSTAGE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF MEMSTAGE_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT MEMSTAGE
	PORT (
		ByteOp			: IN STD_LOGIC;
		MEM_WrEn		: IN STD_LOGIC;
		ALU_MEM_Addr	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_DataIn		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_DataOut		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_Addr			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_WrEn			: OUT STD_LOGIC;
		MM_WrData		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_RdData		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
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
	
	--Inputs
	SIGNAL clk			: STD_LOGIC := '0';
	SIGNAL ByteOp		: STD_LOGIC := '0';
	SIGNAL MEM_WrEn		: STD_LOGIC := '0';
	SIGNAL ALU_MEM_Addr	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	SIGNAL MEM_DataIn	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
	SIGNAL MM_RdData	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

 	--Outputs
	SIGNAL MEM_DataOut	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MM_Addr		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MM_WrEn		: STD_LOGIC;
	SIGNAL MM_WrData	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Clock period definitions
	CONSTANT clk_period : TIME := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : MEMSTAGE
	PORT MAP (
		ByteOp			=> ByteOp,
		MEM_WrEn		=> MEM_WrEn,
		ALU_MEM_Addr	=> ALU_MEM_Addr,
		MEM_DataIn		=> MEM_DataIn,
		MEM_DataOut		=> MEM_DataOut,
		MM_Addr			=> MM_Addr,
		MM_WrEn			=> MM_WrEn,
		MM_WrData		=> MM_WrData,
		MM_RdData		=> MM_RdData
	);
	
	ram_inst : RAM PORT MAP (
		clk			=> clk,
		inst_addr	=> "00000000000",
		data_we		=> MM_WrEn,
		data_addr	=> MM_Addr(12 DOWNTO 2),
		data_din	=> MM_WrData,
		data_dout	=> MM_RdData
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
		-- insert stimulus here
		ByteOp 			<= '0';
		MEM_WrEn		<= '1';
		ALU_MEM_Addr	<= "00000000000000000000100111010001";
		MEM_DataIn		<= "10000110000001000111000000000111";
		--MM_RdData		<= "00000000111100000011100000000101";
		WAIT FOR clk_period;
		
		ByteOp 			<= '0';
		MEM_WrEn		<= '1';
		ALU_MEM_Addr	<= "00000000000000000000100111010001";
		MEM_DataIn		<= "10000110011101000111000000000111";
		--MM_RdData		<= "00111100111111111111100000011111";
		WAIT FOR clk_period;
		
		ByteOp 			<= '1';
		MEM_WrEn		<= '0';
		ALU_MEM_Addr	<= "00000000000000000000010111010001";
		MEM_DataIn		<= "10000110000001000111000000000111";
		--MM_RdData		<= "00000000111100000011100000000101";
		WAIT FOR clk_period;
		
		ByteOp 			<= '1';
		MEM_WrEn		<= '0';
		ALU_MEM_Addr	<= "00000000000000000000000000010001";
		MEM_DataIn		<= "10000110011101000111000000000111";
		--MM_RdData		<= "00111100111111111111100000011111";
		WAIT FOR clk_period;
		WAIT;
	END PROCESS;
	
END;
-------------------------------------------------------------------------------