-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
-------------------------------------------------------------------------------
ENTITY ADDER IS
	PORT (
		A		: IN std_logic_vector (31 DOWNTO 0);
		B		: IN std_logic_vector (31 DOWNTO 0);
		Output	: OUT std_logic_vector (31 DOWNTO 0)
	);
END ADDER;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ADDER IS
BEGIN
	Output <= A + B;
END Behavioral;
-------------------------------------------------------------------------------