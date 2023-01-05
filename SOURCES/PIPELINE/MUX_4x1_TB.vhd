-----------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------------------------------------
ENTITY MUX_4x1_TB IS
END MUX_4x1_TB;
-----------------------------------------------------------------------------
ARCHITECTURE behavior OF MUX_4x1_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT MUX_4x1
	PORT (
		Ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Din0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din3 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL Ctrl : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din0 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din1 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din2 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL Din3 : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL Dout : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : MUX_4x1
	PORT MAP (
		Ctrl => Ctrl,
		Din0 => Din0,
		Din1 => Din1,
		Din2 => Din2,
		Din3 => Din3,
		Dout => Dout
	);

	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		Ctrl <= "00";
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		
		
		Ctrl <= "01";
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		Ctrl <= "10";
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		Ctrl <= "11";
		Din0 <= x"FFFFFFFF";
		Din1 <= x"FF11F1FF";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		-- for new inputs
		Ctrl <= "00";
		Din0 <= x"00000000";
		Din1 <= x"FF11F1FA";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		Ctrl <= "01";
		Din0 <= x"00000000";
		Din1 <= x"FF11F1FA";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		Ctrl <= "10";
		Din0 <= x"00000000";
		Din1 <= x"FF11F1FA";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		

		Ctrl <= "11";
		Din0 <= x"00000000";
		Din1 <= x"FF11F1FA";
		Din2 <= x"AABFFFFF";
		Din3 <= x"FFCCC1FF";
		WAIT FOR 100 ns;
		
		
		WAIT;
	END PROCESS;

END;
-----------------------------------------------------------------------------