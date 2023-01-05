-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY DEC_5_to_32_TB IS
END DEC_5_to_32_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF DEC_5_to_32_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT DEC_5_to_32
	PORT (
		A : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		X : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL A : STD_LOGIC_VECTOR(4 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL X : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : DEC_5_to_32
	PORT MAP (
		A => A, 
		X => X
	);

	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		A <= "00000";
		WAIT FOR 100 ns;

		A <= "00001";
		WAIT FOR 100 ns;

		A <= "00010";
		WAIT FOR 100 ns;

		A <= "00100";
		WAIT FOR 100 ns;

		A <= "01000";
		WAIT FOR 100 ns;

		A <= "10000";
		WAIT FOR 100 ns;

		A <= "10101";
		WAIT FOR 100 ns;
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------