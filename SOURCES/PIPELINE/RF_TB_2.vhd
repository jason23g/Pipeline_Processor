-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-------------------------------------------------------------------------------
ENTITY RF_TB_2 IS
END RF_TB_2;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF RF_TB_2 IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT RF
	PORT (
		CLK		: IN STD_LOGIC;
		RST		: IN STD_LOGIC;
		WrEn	: IN STD_LOGIC;
		Ard1	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Dout1	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Ard2	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Dout2	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Awr		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Din		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	--Inputs
	SIGNAL CLK	: STD_LOGIC := '0';
	SIGNAL RST	: STD_LOGIC := '0';
	SIGNAL WrEn	: STD_LOGIC := '0';
	SIGNAL Ard1	: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Ard2	: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Awr	: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din	: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	
	--Outputs
	SIGNAL Dout1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Dout2 : STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock period definitions
	CONSTANT CLK_period : time := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : RF
	PORT MAP (
		CLK		=> CLK,
		RST		=> RST,
		WrEn	=> WrEn,
		Ard1	=> Ard1,
		Dout1	=> Dout1,
		Ard2	=> Ard2,
		Dout2	=> Dout2,
		Awr		=> Awr,
		Din		=> Din
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
		RST		<= '0';
		WAIT FOR 100 ns;

		WAIT FOR CLK_period*10;
		-- insert stimulus here
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00000";
		Din		<= x"04033001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00001";
		Din		<= x"00000001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "01001";
		Din		<= x"00030001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "10101";
		Din		<= x"00A00001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "10001";
		Din		<= x"0F000001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00011";
		Din		<= x"00045001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00101";
		Din		<= x"00015501";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00001";
		Din		<= x"00000001";
		WAIT FOR CLK_period;
		
		RST		<= '1';
		WrEn	<= '1';
		Awr		<= "00001";
		Din		<= x"00000001";
		WAIT FOR CLK_period;
		
		--RST		<= '0';
		WrEn	<= '0';
		WAIT;
		
	END PROCESS;
END;
-------------------------------------------------------------------------------