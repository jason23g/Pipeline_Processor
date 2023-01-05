-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY REG IS
	PORT (
		CLK	: IN STD_LOGIC; -- clock.
		RST	: IN STD_LOGIC; -- async. clear.
		WE	: IN STD_LOGIC; -- load/enable.
		d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
	);
END REG;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF REG IS
BEGIN
	PROCESS (CLK, RST)
	BEGIN
		IF RST = '0' THEN
			q <= x"00000000" after 10 ns;
		ELSIF rising_edge(clk) THEN
			IF WE = '1' THEN
				q <= d after 10 ns;
			END IF;
		END IF;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------