-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
-------------------------------------------------------------------------------
ENTITY IFSTAGE IS
	PORT (
		Clk			: IN STD_LOGIC;
		Reset		: IN STD_LOGIC;
		PC_LdEn		: IN STD_LOGIC;
		PC_sel		: IN STD_LOGIC;
		PC_Immed	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END IFSTAGE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF IFSTAGE IS

	COMPONENT REG
	PORT (
		CLK		: IN STD_LOGIC; -- clock.
		RST		: IN STD_LOGIC; -- async. clear.
		WE		: IN STD_LOGIC; -- load/enable.
		d		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
	);
	END COMPONENT;

	COMPONENT ADDER
	PORT (
		A		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		B		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Output	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	COMPONENT MUX_2x1
	PORT (
		Ctrl	: IN STD_LOGIC;
		Din0	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL output_adder_4	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_in			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_out			: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

	pc_reg : REG
	PORT MAP (
		CLK		=> clk,
		RST		=> Reset,
		WE		=> PC_LdEn,
		d		=> PC_in,
		q		=> PC_out
	);
	
	mux : MUX_2x1
	PORT MAP (
		ctrl	=> PC_Sel,
		Din0	=> output_adder_4,
		Din1	=> PC_Immed,
		Dout	=> PC_in
	);
	
	adder_4 : ADDER
	PORT MAP (
		A		=> PC_out,
		B		=> x"00000004",
		Output	=> output_adder_4
	);

	PC <= PC_out;

	PC_4 <= output_adder_4;

END Behavioral;
-------------------------------------------------------------------------------