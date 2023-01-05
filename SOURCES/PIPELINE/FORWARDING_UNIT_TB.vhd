-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY FORWARDING_UNIT_TB IS
END FORWARDING_UNIT_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF FORWARDING_UNIT_TB IS

	-- Component Declaration for the Unit Under Test (UUT)

	COMPONENT FORWARDING_UNIT
	PORT (
		ID_EX_Rs		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		EX_MEM_Rd		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		MEM_WB_Rd		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		EX_MEM_RF_WrEn	: IN STD_LOGIC;
		MEM_WB_RF_WrEn	: IN STD_LOGIC;
		forward_A		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		forward_B		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
	END COMPONENT;

	--Inputs
	SIGNAL ID_EX_Rs			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ID_EX_Rt			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL EX_MEM_Rd		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL MEM_WB_Rd		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL EX_MEM_RF_WrEn	: STD_LOGIC;
	SIGNAL MEM_WB_RF_WrEn	: STD_LOGIC;

	--Outputs
	SIGNAL forward_A		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL forward_B		: STD_LOGIC_VECTOR(1 DOWNTO 0);

BEGIN
	-- Instantiate the Unit Under Test (UUT)
	uut : FORWARDING_UNIT
	PORT MAP (
		ID_EX_Rs		=>	ID_EX_Rs,
		ID_EX_Rt		=>	ID_EX_Rt,
		EX_MEM_Rd		=>	EX_MEM_Rd,
		MEM_WB_Rd		=>	MEM_WB_Rd,
		EX_MEM_RF_WrEn	=>	EX_MEM_RF_WrEn,
		MEM_WB_RF_WrEn	=>	MEM_WB_RF_WrEn,
		forward_A		=>	forward_A,
		forward_B		=>	forward_B
	);
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN
		-- insert stimulus here
		--forward_A = "00"
		--forward_B = "00"
		ID_EX_Rs		<=	"00011";
		ID_EX_Rt		<=	"00011";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00101";
		EX_MEM_RF_WrEn	<=	'0';
		MEM_WB_RF_WrEn	<=	'1';
		WAIT FOR 100 ns;
		
		--forward_A = "00"
		--forward_B = "01"
		ID_EX_Rs		<=	"00001";
		ID_EX_Rt		<=	"00011";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00011";
		EX_MEM_RF_WrEn	<=	'0';
		MEM_WB_RF_WrEn	<=	'1';
		WAIT FOR 100 ns;
		
		--forward_A = "00"
		--forward_B = "00"
		ID_EX_Rs		<=	"00011";
		ID_EX_Rt		<=	"00011";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00100";
		EX_MEM_RF_WrEn	<=	'0';
		MEM_WB_RF_WrEn	<=	'0';
		WAIT FOR 100 ns;
		
		--forward_A = "00"
		--forward_B = "00"
		ID_EX_Rs		<=	"00011";
		ID_EX_Rt		<=	"00011";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00100";
		EX_MEM_RF_WrEn	<=	'1';
		MEM_WB_RF_WrEn	<=	'1';
		WAIT FOR 100 ns;
		
		--forward_A = "00"
		--forward_B = "01"
		ID_EX_Rs		<=	"00011";
		ID_EX_Rt		<=	"00101";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00101";
		EX_MEM_RF_WrEn	<=	'0';
		MEM_WB_RF_WrEn	<=	'1';
		WAIT FOR 100 ns;
		
		--forward_A = "00"
		--forward_B = "00"
		ID_EX_Rs		<=	"00011";
		ID_EX_Rt		<=	"00011";
		EX_MEM_Rd		<=	"00001";
		MEM_WB_Rd		<=	"00101";
		EX_MEM_RF_WrEn	<=	'1';
		MEM_WB_RF_WrEn	<=	'1';
		WAIT FOR 100 ns;

		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------