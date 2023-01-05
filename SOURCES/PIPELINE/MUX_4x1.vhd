-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY MUX_4x1 IS
	PORT (
		Ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Din0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MUX_4x1;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF MUX_4x1 IS

BEGIN
	PROCESS (Din0, Din1, Din2, Din3, ctrl)
	BEGIN
		CASE ctrl IS
			WHEN "00"	=>	Dout <= Din0 after 10 ns;
			WHEN "01"	=>	Dout <= Din1 after 10 ns;
			WHEN "10"	=>	Dout <= Din2 after 10 ns;
			WHEN "11"	=>	Dout <= Din3 after 10 ns;
			WHEN OTHERS	=>	Dout <= x"00000000" after 10 ns;
		END CASE;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------