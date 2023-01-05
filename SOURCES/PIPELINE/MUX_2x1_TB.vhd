-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------------
ENTITY MUX_2x1_TB IS
END MUX_2x1_TB;
-----------------------------------------------------------------------------
ARCHITECTURE behavior OF MUX_2x1_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT MUX_2x1
	PORT (
		Ctrl : IN STD_LOGIC;
		Din0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL Ctrl : STD_LOGIC := '0';
	SIGNAL Din0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL Dout : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : MUX_2x1
	PORT MAP (
		Ctrl => Ctrl,
		Din0 => Din0,
		Din1 => Din1,
		Dout => Dout
	);

	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		Ctrl <= '1';
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		WAIT FOR 100 ns;
		
		Ctrl <= '1';
		Din0 <= x"00000000";
		Din1 <= x"FF11F1FA";
		WAIT FOR 100 ns;
		
		Ctrl <= '0';
		Din0 <= "11111111111111111100001111111111";
		Din1 <= "11110111011000001111111111011111";
		WAIT FOR 100 ns;
		
		Ctrl <= '0';
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		WAIT FOR 100 ns;
		
		WAIT;
	END PROCESS;

END;
-----------------------------------------------------------------------------