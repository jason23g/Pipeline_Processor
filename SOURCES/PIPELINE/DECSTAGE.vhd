-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY DECSTAGE IS
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
END DECSTAGE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF DECSTAGE IS
	
	SIGNAL Reg_A	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL Reg_B	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	COMPONENT MUX_2x1_5bit IS
	PORT (
		Ctrl	: IN STD_LOGIC;
		Din0	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Din1	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Dout	: OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT ImmedExtender IS
	PORT (
		ctrl	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Instr	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Immed	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT RF IS
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
	
BEGIN
	
	imm_ext : ImmedExtender
	PORT MAP (
		ctrl	=> Immed_ctrl,
		Instr	=> Instr(15 DOWNTO 0),
		Immed	=> Immed
	);

	mux_reg_a_sel : MUX_2x1_5bit
	PORT MAP (
		Ctrl => RF_A_sel,
		Din0 => Instr(25 DOWNTO 21),
		Din1 => "00000",
		Dout => Reg_A
	);

	mux_reg_b_sel : MUX_2x1_5bit
	PORT MAP (
		Ctrl => RF_B_sel,
		Din0 => Instr(15 DOWNTO 11),
		Din1 => Instr(20 DOWNTO 16),
		Dout => Reg_B
	);

	reg_file : RF
	PORT MAP (
		CLK		=> CLK,
		RST		=> RST,
		WrEn	=> RF_WrEn,
		Ard1	=> Reg_A,
		Dout1	=> RF_A,
		Ard2	=> Reg_B,
		Dout2	=> RF_B,
		Awr		=> Awr,
		Din		=> WrData
	);

END Behavioral;
-------------------------------------------------------------------------------