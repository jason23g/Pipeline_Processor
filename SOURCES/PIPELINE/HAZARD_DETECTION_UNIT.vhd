-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY HAZARD_DETECTION_UNIT IS
	PORT (
		PC_LdEn_CONTROL	: IN STD_LOGIC;
		Rs_IF_ID		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Rt_IF_ID		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Rd_IF_ID		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Opcode_IF_ID	: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Rd_ID_EX		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Opcode_ID_EX	: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		PC_LdEn			: OUT STD_LOGIC;
		IF_ID_WrEn		: OUT STD_LOGIC;
		Ctrl_sel		: OUT STD_LOGIC
	);
END HAZARD_DETECTION_UNIT;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF HAZARD_DETECTION_UNIT IS
BEGIN

-- first condition:
-- load
-- R-type

-- second condition:
-- load
-- load

-- third condition:
-- load
-- store

PC_LdEn <=	'0' WHEN Opcode_IF_ID = "100000"								AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rt_IF_ID)	ELSE
			
			'0' WHEN (Opcode_IF_ID = "001111" OR Opcode_IF_ID = "000011")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID)							ELSE
			
			'0' WHEN (Opcode_IF_ID = "011111" OR Opcode_IF_ID = "000111")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rd_IF_ID)	ELSE
			
			PC_LdEn_CONTROL;


IF_ID_WrEn <=	'0' WHEN Opcode_IF_ID = "100000"								AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rt_IF_ID)	ELSE
			
				'0' WHEN (Opcode_IF_ID = "001111" OR Opcode_IF_ID = "000011")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID)							ELSE
			
				'0' WHEN (Opcode_IF_ID = "011111" OR Opcode_IF_ID = "000111")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rd_IF_ID)	ELSE
			
				'1';


Ctrl_sel <=	'1' WHEN Opcode_IF_ID = "100000"								AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rt_IF_ID)	ELSE
			
			'1' WHEN (Opcode_IF_ID = "001111" OR Opcode_IF_ID = "000011")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID)							ELSE
			
			'1' WHEN (Opcode_IF_ID = "011111" OR Opcode_IF_ID = "000111")	AND (Opcode_ID_EX = "001111" OR Opcode_ID_EX = "000011") AND (Rd_ID_EX = Rs_IF_ID OR Rd_ID_EX = Rd_IF_ID)	ELSE
			
			'0';


END Behavioral;
-------------------------------------------------------------------------------

--(Opcode_IF_ID = "100000" OR Opcode_IF_ID = "001111")

--OR ((Opcode_ID_EX = "000111" OR Opcode_ID_EX = "011111") AND Rd_ID_EX = Rs_IF_ID))
--OR ((Opcode_ID_EX = "000111" OR Opcode_ID_EX = "011111") AND Rd_ID_EX = Rs_IF_ID))
--OR ((Opcode_ID_EX = "000111" OR Opcode_ID_EX = "011111") AND Rd_ID_EX = Rs_IF_ID))