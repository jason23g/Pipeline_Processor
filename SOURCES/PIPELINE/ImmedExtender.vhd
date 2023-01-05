-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY ImmedExtender IS
	PORT (
		ctrl	: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Instr	: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Immed	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END ImmedExtender;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ImmedExtender IS

	--signals for the 4 operations
	SIGNAL sll_16				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL zerofill				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sign_extend_sll_2	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sign_extended		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL sign_extend			: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	
	sll_16(31 DOWNTO 16) <= Instr;
	sll_16(15 DOWNTO 0)  <= x"0000";
	----------------------------------
	zerofill(31 DOWNTO 16) <= x"0000";
	zerofill(15 DOWNTO 0)  <= Instr;
	----------------------------------
	--for 31 downto 16
	--sign_extended(i) <= Instr(15);
	--for 15 downto 0
	--sign_extended(i) <= Instr(i);
	sign_extended(15 DOWNTO 0)	<= Instr;
	sign_extended(16)			<= Instr(15);
	sign_extended(17)			<= Instr(15);
	sign_extended(18)			<= Instr(15);
	sign_extended(19)			<= Instr(15);
	sign_extended(20)			<= Instr(15);
	sign_extended(21)			<= Instr(15);
	sign_extended(22)			<= Instr(15);
	sign_extended(23)			<= Instr(15);
	sign_extended(24)			<= Instr(15);
	sign_extended(25)			<= Instr(15);
	sign_extended(26)			<= Instr(15);
	sign_extended(27)			<= Instr(15);
	sign_extended(28)			<= Instr(15);
	sign_extended(29)			<= Instr(15);
	sign_extended(30)			<= Instr(15);
	sign_extended(31)			<= Instr(15);

	--sign_extended(31 DOWNTO 16) <= Instr(15);
	
	sign_extend_sll_2(31 DOWNTO 2)	<= sign_extended(29 DOWNTO 0);
	sign_extend_sll_2(1 DOWNTO 0)	<= "00";
	-----------------------------
	sign_extend <= sign_extended;
	-----------------------------
	PROCESS (Instr, ctrl, sll_16, zerofill, sign_extend_sll_2, sign_extend)
	BEGIN
		CASE ctrl IS
			WHEN "00"	=> Immed	<= sll_16;
			WHEN "01"	=> Immed	<= zerofill;
			WHEN "10"	=> Immed	<= sign_extend_sll_2;
			WHEN "11"	=> Immed	<= sign_extend;
			WHEN OTHERS => Immed	<= x"00000000";
		END CASE;
	END PROCESS;

END Behavioral;
-------------------------------------------------------------------------------