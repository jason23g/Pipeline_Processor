-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY ALU_CONTROL IS
	PORT (
		ALU_Op	: IN  STD_LOGIC_VECTOR (2 DOWNTO 0);
		func	: IN  STD_LOGIC_VECTOR (5 DOWNTO 0);
		Op		: OUT  STD_LOGIC_VECTOR (3 DOWNTO 0)
	);
END ALU_CONTROL;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ALU_CONTROL IS
BEGIN
	PROCESS (ALU_Op, func)
	BEGIN
		CASE ALU_Op IS
			WHEN "000" =>	Op	<= func(3 DOWNTO 0);
			WHEN "001" =>	Op	<= "0000";--add
			WHEN "010" =>	Op	<= "0001";--sub
			WHEN "011" =>	Op	<= "0011";--or
			WHEN "100" =>	Op	<= "0101";--nand
			WHEN OTHERS =>	Op	<= "1111";--this operation is not a supported operation of the ALU
										--and the result of the ALU will be x"00000000"
		END CASE;
	END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------