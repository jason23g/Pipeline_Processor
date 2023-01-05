-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------
ENTITY MUX_32x32 IS
	PORT (
		ctrl : IN	STD_LOGIC_VECTOR (4 DOWNTO 0);
		Din0 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din1 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din2 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din3 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din4 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din5 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din6 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din7 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din8 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din9 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din10 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din11 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din12 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din13 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din14 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din15 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din16 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din17 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din18 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din19 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din20 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din21 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din22 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din23 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din24 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din25 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din26 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din27 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din28 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din29 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din30 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Din31 : IN	STD_LOGIC_VECTOR (31 DOWNTO 0);
		Dout : OUT	STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END MUX_32x32;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF MUX_32x32 IS

BEGIN

	PROCESS (
		ctrl, Din0, Din1, Din2, Din3, Din4, Din5, Din6, Din7, Din8, Din9,
		Din10, Din11, Din12, Din13, Din14, Din15, Din16, Din17, Din18, Din19,
		Din20, Din21, Din22, Din23, Din24, Din25, Din26, Din27, Din28, Din29,
		Din30, Din31
	)
	BEGIN
		CASE ctrl IS
			WHEN "00000" => Dout <= Din0 after 10 ns;
			WHEN "00001" => Dout <= Din1 after 10 ns;
			WHEN "00010" => Dout <= Din2 after 10 ns;
			WHEN "00011" => Dout <= Din3 after 10 ns;
			WHEN "00100" => Dout <= Din4 after 10 ns;
			WHEN "00101" => Dout <= Din5 after 10 ns;
			WHEN "00110" => Dout <= Din6 after 10 ns;
			WHEN "00111" => Dout <= Din7 after 10 ns;
			WHEN "01000" => Dout <= Din8 after 10 ns;
			WHEN "01001" => Dout <= Din9 after 10 ns;
			WHEN "01010" => Dout <= Din10 after 10 ns;
			WHEN "01011" => Dout <= Din11 after 10 ns;
			WHEN "01100" => Dout <= Din12 after 10 ns;
			WHEN "01101" => Dout <= Din13 after 10 ns;
			WHEN "01110" => Dout <= Din14 after 10 ns;
			WHEN "01111" => Dout <= Din15 after 10 ns;
			
			WHEN "10000" => Dout <= Din16 after 10 ns;
			WHEN "10001" => Dout <= Din17 after 10 ns;
			WHEN "10010" => Dout <= Din18 after 10 ns;
			WHEN "10011" => Dout <= Din19 after 10 ns;
			WHEN "10100" => Dout <= Din20 after 10 ns;
			WHEN "10101" => Dout <= Din21 after 10 ns;
			WHEN "10110" => Dout <= Din22 after 10 ns;
			WHEN "10111" => Dout <= Din23 after 10 ns;
			WHEN "11000" => Dout <= Din24 after 10 ns;
			WHEN "11001" => Dout <= Din25 after 10 ns;
			WHEN "11010" => Dout <= Din26 after 10 ns;
			WHEN "11011" => Dout <= Din27 after 10 ns;
			WHEN "11100" => Dout <= Din28 after 10 ns;
			WHEN "11101" => Dout <= Din29 after 10 ns;
			WHEN "11110" => Dout <= Din30 after 10 ns;
			WHEN "11111" => Dout <= Din31 after 10 ns;
			WHEN OTHERS => Dout <= x"00000000" after 10 ns;
		END CASE;
	END PROCESS;
	
end Behavioral;
-------------------------------------------------------------------------------