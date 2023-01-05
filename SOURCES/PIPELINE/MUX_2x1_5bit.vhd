-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY MUX_2x1_5bit IS
	PORT (
		Ctrl : IN STD_LOGIC;
		Din0 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Din1 : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		Dout : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
END MUX_2x1_5bit;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF MUX_2x1_5bit IS

BEGIN
	PROCESS (Din0, Din1, ctrl)
	BEGIN
		CASE ctrl IS
			WHEN '0' =>		Dout <= Din0 after 10 ns;
			WHEN '1' =>		Dout <= Din1 after 10 ns;
			WHEN OTHERS =>	Dout <= "00000" after 10 ns;
		END CASE;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------