-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY EXSTAGE IS
	PORT (
		RF_A        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_Bin_sel : IN STD_LOGIC;
		Op		    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		PC_4		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_out     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_Immed	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_zero    : OUT STD_LOGIC
	);
END EXSTAGE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF EXSTAGE IS

	COMPONENT ALU
	PORT (
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Op		: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Cout	: OUT STD_LOGIC;
		Zero	: OUT STD_LOGIC;
		Ovf		: OUT STD_LOGIC;
		Output	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT ADDER
	PORT (
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Output	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT MUX_2x1 IS
	PORT (
		Ctrl	: IN STD_LOGIC;
		Din0	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	SIGNAL mux_out : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
BEGIN

	mux : MUX_2x1
	PORT MAP (
		ctrl	=> ALU_Bin_sel,
		Din0	=> RF_B,
		Din1	=> Immed,
		Dout	=> mux_out
	);

	arithmetic_logic_unit : ALU
	PORT MAP (
		A		=> RF_A,
		B		=> mux_out,
		Op		=> Op,
		--Cout => Cout,
		Zero	=> ALU_zero,
		-- Ovf => Ovf,
		Output	=> ALU_out
	);
	
	adder_4 : ADDER
	PORT MAP (
		A		=> PC_4,
		B		=> Immed,
		Output	=> PC_Immed
	);
	
END Behavioral;
-------------------------------------------------------------------------------