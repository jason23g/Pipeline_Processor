-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY FORWARDING_UNIT IS
	PORT (
		--IF_ID_Rs		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		--IF_ID_Rt		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rs		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		EX_MEM_Rd		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		MEM_WB_Rd		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		EX_MEM_RF_WrEn	: IN STD_LOGIC;
		MEM_WB_RF_WrEn	: IN STD_LOGIC;
		forward_A		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		forward_B		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END FORWARDING_UNIT;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF FORWARDING_UNIT IS
BEGIN
	
	forward_A	<=	"10" WHEN EX_MEM_RF_WrEn = '1'
					AND EX_MEM_Rd /= "00000"
					AND EX_MEM_Rd = ID_EX_Rs

					ELSE "01" WHEN MEM_WB_RF_WrEn = '1'
					AND MEM_WB_Rd /= "00000"
					--AND NOT( (EX_MEM_RF_WrEn = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = ID_EX_Rs) )
					AND (MEM_WB_Rd = ID_EX_Rs)

					ELSE "00";

					--AND (NOT (EX_MEM_Rd = ID_EX_Rs)) very fucking wrong
					--AND NOT( (EX_MEM_RF_WrEn = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd /= ID_EX_Rs) ) possibly wrong


	forward_B	<=	"10" WHEN EX_MEM_RF_WrEn = '1'
					AND EX_MEM_Rd /= "00000"
					AND EX_MEM_Rd = ID_EX_Rt

					ELSE "01" WHEN MEM_WB_RF_WrEn = '1'
					AND MEM_WB_Rd /= "00000"
					--AND NOT( (EX_MEM_RF_WrEn = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd = ID_EX_Rt) )
					AND (MEM_WB_Rd = ID_EX_Rt)

					ELSE "00";

					-- AND (NOT (EX_MEM_Rd = ID_EX_Rt)) very fucking wrong
					--AND NOT( (EX_MEM_RF_WrEn = '1') AND (EX_MEM_Rd /= "00000") AND (EX_MEM_Rd /= ID_EX_Rt) ) possibly wrong

END Behavioral;
-------------------------------------------------------------------------------