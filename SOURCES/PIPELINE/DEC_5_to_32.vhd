----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
----------------------------------------------------------------------------------
ENTITY DEC_5_to_32 IS
	PORT (
		A : IN	STD_LOGIC_VECTOR(4 DOWNTO 0);
		X : OUT	STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END DEC_5_to_32;
----------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF DEC_5_to_32 IS

BEGIN

	PROCESS(A)
	BEGIN
		X <= x"00000000" after 10 ns;
		CASE A IS
			WHEN "00000" => X(0) <= '1' after 10 ns;
			WHEN "00001" => X(1) <= '1' after 10 ns;
			WHEN "00010" => X(2) <= '1' after 10 ns;
			WHEN "00011" => X(3) <= '1' after 10 ns;
			WHEN "00100" => X(4) <= '1' after 10 ns;
			WHEN "00101" => X(5) <= '1' after 10 ns;
			WHEN "00110" => X(6) <= '1' after 10 ns;
			WHEN "00111" => X(7) <= '1' after 10 ns;
			WHEN "01000" => X(8) <= '1' after 10 ns;
			WHEN "01001" => X(9) <= '1' after 10 ns;
			WHEN "01010" => X(10) <= '1' after 10 ns;
			WHEN "01011" => X(11) <= '1' after 10 ns;
			WHEN "01100" => X(12) <= '1' after 10 ns;
			WHEN "01101" => X(13) <= '1' after 10 ns;
			WHEN "01110" => X(14) <= '1' after 10 ns;
			WHEN "01111" => X(15) <= '1' after 10 ns;
			
			WHEN "10000" => X(16) <= '1' after 10 ns;
			WHEN "10001" => X(17) <= '1' after 10 ns;
			WHEN "10010" => X(18) <= '1' after 10 ns;
			WHEN "10011" => X(19) <= '1' after 10 ns;
			WHEN "10100" => X(20) <= '1' after 10 ns;
			WHEN "10101" => X(21) <= '1' after 10 ns;
			WHEN "10110" => X(22) <= '1' after 10 ns;
			WHEN "10111" => X(23) <= '1' after 10 ns;
			WHEN "11000" => X(24) <= '1' after 10 ns;
			WHEN "11001" => X(25) <= '1' after 10 ns;
			WHEN "11010" => X(26) <= '1' after 10 ns;
			WHEN "11011" => X(27) <= '1' after 10 ns;
			WHEN "11100" => X(28) <= '1' after 10 ns;
			WHEN "11101" => X(29) <= '1' after 10 ns;
			WHEN "11110" => X(30) <= '1' after 10 ns;
			WHEN "11111" => X(31) <= '1' after 10 ns;
			
			WHEN OTHERS => X <= x"00000000" after 10 ns;
		END CASE;
	END PROCESS;
END Behavioral;
----------------------------------------------------------------------------------