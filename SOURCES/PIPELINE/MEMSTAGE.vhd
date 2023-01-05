-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;
USE IEEE.NUMERIC_STD.ALL;
-------------------------------------------------------------------------------
ENTITY MEMSTAGE IS
	PORT (
		ByteOp			: IN STD_LOGIC;
		MEM_WrEn		: IN STD_LOGIC;
		ALU_MEM_Addr	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_DataIn		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		MEM_DataOut		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_Addr			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_WrEn			: OUT STD_LOGIC;
		MM_WrData		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_RdData		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END MEMSTAGE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF MEMSTAGE IS

	SIGNAL load_byte : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL store_byte : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN

	PROCESS(ByteOp, load_byte, store_byte, ALU_MEM_Addr, MEM_DataIn, MM_RdData, MEM_WrEn, ALU_MEM_Addr)
	BEGIN
		--ByteOp
		load_byte(7 DOWNTO 0)	<= MM_RdData(7 DOWNTO 0);
		load_byte(31 DOWNTO 8)	<= x"000000";
		store_byte(7 DOWNTO 0)	<= MEM_DataIn(7 DOWNTO 0);
		store_byte(31 DOWNTO 8)	<= x"000000";
		
		IF ByteOp = '1' THEN 
			MM_WrData	<= store_byte;
			MEM_DataOut	<= load_byte;
		ELSE
			MM_WrData	<= MEM_DataIn;
			MEM_DataOut	<= MM_RdData;
		END IF;
		
		MM_WrEn	<= MEM_WrEn;
		MM_Addr	<= ALU_MEM_Addr + x"00000400";
	END PROCESS;

END Behavioral;
-------------------------------------------------------------------------------