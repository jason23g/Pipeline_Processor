-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY DECSTAGE_TB IS
END DECSTAGE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF DECSTAGE_TB IS

	-- Component Declaration for the Unit Under Test (UUT)
	
	COMPONENT DECSTAGE
	PORT (
		Clk				: IN STD_LOGIC;
		RST				: IN STD_LOGIC;
		Instr			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_WrEn			: IN STD_LOGIC;
		WrData			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Awr				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_A_sel		: IN STD_LOGIC;
		RF_B_sel		: IN STD_LOGIC;
		Immed_ctrl		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Immed			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_A			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	--Inputs
	SIGNAL Clk				: STD_LOGIC := '0';
	SIGNAL RST				: STD_LOGIC := '0';
	SIGNAL Instr			: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL RF_WrEn			: STD_LOGIC := '0';
	SIGNAL WrData			: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Awr				: STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');
	SIGNAL RF_A_sel			: STD_LOGIC := '0';
	SIGNAL RF_B_sel			: STD_LOGIC := '0';
	SIGNAL Immed_ctrl		: STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	
	--Outputs
	SIGNAL Immed			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RF_A				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RF_B				: STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- Clock period definitions
	CONSTANT Clk_period		: TIME := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : DECSTAGE
	PORT MAP (
		Clk				=> Clk,
		RST				=> RST,
		Instr			=> Instr,
		RF_WrEn			=> RF_WrEn,
		WrData			=> WrData,
		Awr				=> Awr,
		RF_A_sel		=> RF_A_sel,
		RF_B_sel		=> RF_B_sel,
		Immed_ctrl		=> Immed_ctrl,
		Immed			=> Immed,
		RF_A			=> RF_A,
		RF_B			=> RF_B
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
		-- hold reset state for 100 ns.
		RST <= '0';
		WAIT FOR 100 ns;
		
		
		-- insert stimulus here
		--------------- Prog 1 ---------------
		RST				<= '1';
		Instr			<= x"C0050008";--addi r5, r0, 8
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';
		RF_WrEn			<= '1';
		Immed_ctrl		<= "11";
		WrData			<= x"00000008";
		WAIT FOR Clk_period;
		
		
		RST				<= '1';
		Instr			<= x"CC03ABCD";--ori r3, r0, ABCD
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';
		RF_WrEn			<= '1';
		Immed_ctrl		<= "01";
		WrData			<= x"0000ABCD";
		WAIT FOR Clk_period;
		
		
		RST				<= '1';
		Instr			<= x"7C030004";--sw r3, 4(r0)
		RF_A_sel		<= '0';
		RF_B_sel		<= '1';
		RF_WrEn			<= '0';
		Immed_ctrl		<= "11";
		WrData			<= x"00000008";
		WAIT FOR Clk_period;
		
		
		RST				<= '1';
		Instr			<= x"3CAAFFFC";--lw r10, -4(r5)
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';--do not care
		RF_WrEn			<= '1';
		Immed_ctrl		<= "11";
		WrData			<= x"00000008";
		WAIT FOR Clk_period;
		
		
		RST				<= '1';
		Instr			<= x"0C100004";--lb r16, 4(r0)
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';--do not care
		RF_WrEn			<= '1';
		Immed_ctrl		<= "11";
		WrData			<= x"00000008";
		WAIT FOR Clk_period;
		
		
		RST				<= '1';
		Instr			<= x"81448035";--nand r4, r10, r16
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';--do not care
		RF_WrEn			<= '1';
		Immed_ctrl		<= "11";
		WrData			<= x"07070A08";
	
		WAIT FOR Clk_period;
		
		
--		--------------- Prog 2 ---------------
--		RST				<= '1';
--		Instr			<= x"04A50008";--bne r5, r5, 8
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		Immed_ctrl		<= "10";
--		WrData			<= x"00000000";
--		WAIT FOR Clk_period;
--		
--		RST				<= '1';
--		Instr			<= x"FC00FFFE";--b -2
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		RF_WrEn			<= '0';
--		Immed_ctrl		<= "10";
--		WrData			<= x"00000000";
--		WAIT FOR Clk_period;
		
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------