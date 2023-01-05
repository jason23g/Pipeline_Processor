-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-------------------------------------------------------------------------------
ENTITY EXSTAGE_TB IS
END EXSTAGE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF EXSTAGE_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT EXSTAGE
	PORT (
         RF_A			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         RF_B			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         Immed			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         ALU_Bin_sel	: IN STD_LOGIC;
         Op				: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         ALU_out		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         ALU_zero		: OUT STD_LOGIC
	);
    END COMPONENT;
	
	--Inputs
	SIGNAL RF_A			: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL RF_B			: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Immed		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ALU_Bin_sel	: STD_LOGIC := '0';
	SIGNAL Op			: STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	
 	--Outputs
	SIGNAL ALU_out		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL ALU_zero		: STD_LOGIC;
	
BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : EXSTAGE
	PORT MAP (
		RF_A			=> RF_A,
		RF_B			=> RF_B,
		Immed			=> Immed,
		ALU_Bin_sel		=> ALU_Bin_sel,
		Op				=> Op,
		ALU_out			=> ALU_out,
		ALU_zero		=> ALU_zero
	);
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0000";-- Instruction add
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0001";-- Instruction sub
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0010";-- Instruction and
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0011";-- Instruction or
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0100";-- Instruction not
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0101";-- Instruction Nand
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0110";-- Instruction Nor		
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1000";-- Instruction sra		
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1001";-- Instruction srl		
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1010";-- Instruction sll		
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1100";-- Instruction rol
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '0';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1101";-- Instruction ror
		WAIT FOR 100 ns;
		
--------------------- Using the ALU with immendiate value ---------------------
------------------------------ as input in RF_B -------------------------------
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";--
		RF_B <= "10000000000000000000000001001110";--
		Immed <= x"00000010";
		Op <= "0000";-- Instruction Add
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";--
		RF_B <= "10000000000000000000000001001110";--
		Immed <= x"00000010";
		Op <= "0001";-- Instruction sub
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0010";-- Instruction and
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0011";-- Instruction OR
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0100";-- Instruction not 
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0101";-- Instruction nand
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "0110";-- Instruction nor
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1000";-- Instruction sra
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1001";-- Instruction srl
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1010";-- Instruction sll
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1100";-- Instruction rol
		WAIT FOR 100 ns;
		
		ALU_Bin_sel <= '1';
		RF_A <= "00000000000000000000000001000100";
		RF_B <= "10000000000000000000000001001110";
		Immed <= x"00000010";
		Op <= "1101";-- Instruction ror
		WAIT FOR 100 ns;
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------