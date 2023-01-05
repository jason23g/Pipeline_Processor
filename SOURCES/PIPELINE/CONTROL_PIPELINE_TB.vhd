-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY CONTROL_PIPELINE_TB IS
END CONTROL_PIPELINE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF CONTROL_PIPELINE_TB IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT CONTROL_PIPELINE
    PORT (
		Opcode			: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		ALU_Op			: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		ALU_Bin_sel		: OUT STD_LOGIC;
		RF_A_sel		: OUT STD_LOGIC;
		RF_B_sel		: OUT STD_LOGIC;
		MEM_WrEn		: OUT STD_LOGIC;
		RF_WrEn			: OUT STD_LOGIC;
		RF_WrData_sel	: OUT STD_LOGIC;
		BranchEq		: OUT STD_LOGIC;
		BranchNotEq		: OUT STD_LOGIC;
		Jump			: OUT STD_LOGIC;
		ByteOp			: OUT STD_LOGIC;
		Immed_ctrl		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		PC_LdEn			: OUT STD_LOGIC
	);
	END COMPONENT;

	--Inputs
	SIGNAL Opcode		: STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');

	--Outputs
	SIGNAL ALU_Op			: std_logic_vector(2 DOWNTO 0);
	SIGNAL ALU_Bin_sel		: std_logic;
	SIGNAL RF_A_sel			: std_logic;
	SIGNAL RF_B_sel			: std_logic;
	SIGNAL MEM_WrEn			: std_logic;
	SIGNAL RF_WrEn			: std_logic;
	SIGNAL RF_WrData_sel	: std_logic;
	SIGNAL BranchEq			: std_logic;
	SIGNAL BranchNotEq		: std_logic;
	SIGNAL Jump				: std_logic;
	SIGNAL ByteOp			: std_logic;
	SIGNAL Immed_ctrl		: std_logic_vector(1 DOWNTO 0);
	SIGNAL PC_LdEn			: std_logic;
	
	-- Clock period definitions
	CONSTANT CLK_period : TIME := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut : CONTROL_PIPELINE
	PORT MAP (
		Opcode			=> Opcode,
		ALU_Op			=> ALU_Op,
		ALU_Bin_sel		=> ALU_Bin_sel,
		RF_A_sel		=> RF_A_sel,
		RF_B_sel		=> RF_B_sel,
		MEM_WrEn		=> MEM_WrEn,
		RF_WrEn			=> RF_WrEn,
		RF_WrData_sel	=> RF_WrData_sel,
		BranchEq		=> BranchEq,
		BranchNotEq		=> BranchNotEq,
		Jump			=> Jump,
		ByteOp			=> ByteOp,
		Immed_ctrl		=> Immed_ctrl,
		PC_LdEn			=> PC_LdEn
	);

	-- Stimulus PROCESS
	stim_proc : PROCESS
	BEGIN		
		-- hold reset state for 2 clock cycles.
		--RST		<= '0';
		WAIT FOR CLK_period;
		
		-- stimulus here
		--RST		<= '1';
		Opcode	<= "100000";-- R-type instructions
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "111000";--li instruction 
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "110000";-- addi instruction 
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "110010";-- nandi instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "110011";--ori instruction 
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "111111";-- jump instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "000000";-- branch equal instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "000001";-- branch not equal instruction 
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "000011";-- load byte instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "000111";-- store byte instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "001111";-- load word instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "011111";-- store byte instruction
		WAIT FOR CLK_period;
		
		--RST		<= '1';
		Opcode	<= "010000";-- store byte instruction
		WAIT FOR CLK_period;
		WAIT;
	END PROCESS;
	
END;
-------------------------------------------------------------------------------