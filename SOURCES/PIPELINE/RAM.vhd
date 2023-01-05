-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE std.textio.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
-------------------------------------------------------------------------------
ENTITY RAM IS
	PORT (
		clk			: IN STD_LOGIC;
		inst_addr	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		inst_dout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we		: IN STD_LOGIC;
		data_addr	: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		data_din	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END RAM;
-------------------------------------------------------------------------------
ARCHITECTURE syn OF RAM IS

	TYPE ram_type IS ARRAY (2047 DOWNTO 0) OF STD_LOGIC_VECTOR (31 DOWNTO 0);

	IMPURE FUNCTION InitRamFromFile (RamFileName : IN STRING) RETURN ram_type IS

	FILE ramfile			: text IS IN RamFileName;
	VARIABLE RamFileLine	: line;
	VARIABLE ram			: ram_type;
	BEGIN
		FOR i IN 0 TO 255 LOOP
			readline(ramfile, RamFileLine);
			read(RamFileLine, ram(i));
		END LOOP;
		FOR i IN 256 TO 2047 LOOP
			ram(i) := x"00000000";
		END LOOP;
		RETURN ram;
	END FUNCTION;
	
	SIGNAL RAM : ram_type := InitRamFromFile("programs/prog11.data");
	
	BEGIN
		PROCESS (clk)
		BEGIN
			IF clk'EVENT AND clk = '1' THEN
				IF data_we = '1' THEN
					RAM(conv_integer(data_addr)) <= data_din;
				END IF;
			END IF;
		END PROCESS;

	data_dout <= RAM(conv_integer(data_addr)) after 12ns;
	inst_dout <= RAM(conv_integer(inst_addr)) after 12ns;

END syn;
-------------------------------------------------------------------------------