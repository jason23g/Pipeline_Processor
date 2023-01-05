-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------
ENTITY ALU IS
	PORT (
		A			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		B			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		Op			: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Cout		: OUT STD_LOGIC;
		Zero		: OUT STD_LOGIC;
		Ovf			: OUT STD_LOGIC;
		Output		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END ALU;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF ALU IS

	SIGNAL result	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL out_ovf	: STD_LOGIC_VECTOR (32 DOWNTO 0);
	SIGNAL out_A	: STD_LOGIC_VECTOR (32 DOWNTO 0);
	SIGNAL out_B	: STD_LOGIC_VECTOR (32 DOWNTO 0);

BEGIN

	PROCESS(A, B, Op, out_A, out_B, result, out_ovf)
	BEGIN
		out_A(32)			<= A(31);
		out_A(31 DOWNTO 0)	<= A;
		out_B(32)			<= B(31);
		out_B(31 DOWNTO 0)	<= B;
		
		CASE Op IS
		WHEN "0000" =>--Add
			out_ovf	<= out_A + out_B;
			result	<= out_ovf(31 DOWNTO 0);
			IF (((NOT A(31)) AND (NOT B(31)) AND out_ovf(31)) OR (A(31) AND B(31) AND (NOT out_ovf(31)))) = '1' THEN
				Ovf		<= '1' after 10 ns;
				Cout	<= out_ovf(32) after 10 ns;
			ELSE
				Ovf		<= '0' after 10 ns;
				Cout	<= out_ovf(32) after 10 ns;
			END IF;
			
		WHEN "0001" =>--Sub
			out_ovf	<= out_A - out_B;
			result	<= out_ovf(31 DOWNTO 0);
			IF ((A(31) AND (NOT B(31)) AND (NOT out_ovf(31))) OR ((NOT A(31)) AND B(31) AND out_ovf(31))) = '1' THEN
				Ovf		<= '1' after 10 ns;
				Cout	<= out_ovf(32) after 10 ns;
			ELSE
				Ovf		<= '0' after 10 ns;
				Cout	<= out_ovf(32) after 10 ns;
			END IF;
			
		WHEN "0010" =>--and
			result	<= A AND B;
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "0011" =>--or
			result	<= A OR B;
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "0100" =>--not
			result	<= NOT A;
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "0101" =>--nand
			result	<=  NOT (A AND B);
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "0110" =>--nor
			result	<=  NOT (A OR B);
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "1000" =>--sra 1
			result	<= STD_LOGIC_VECTOR(shift_right(signed(A), 1));
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "1001" =>--srl 1
			result	<= STD_LOGIC_VECTOR(unsigned(A) SRL 1);
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "1010" =>--sll 1
			result	<= STD_LOGIC_VECTOR(unsigned(A) SLL 1);
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "1100" =>--rotate left by 1
			result	<= STD_LOGIC_VECTOR(unsigned(A) ROL 1);
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN "1101" =>--rotate right by 1
			result	<= STD_LOGIC_VECTOR(unsigned(A) ROR 1); 
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
			
		WHEN OTHERS =>--any other input
			result	<= x"00000000";
			Ovf		<= '0' after 10 ns;
			Cout	<= '0' after 10 ns;
		END CASE;
		
		--for zero output
		IF (result	= x"00000000") THEN
			Zero <= '1' after 10 ns;
		ELSE
			Zero <= '0' after 10 ns;
		END IF;
		
	END PROCESS;
	
	Output <= result after 10 ns;
	
END Behavioral;
-------------------------------------------------------------------------------