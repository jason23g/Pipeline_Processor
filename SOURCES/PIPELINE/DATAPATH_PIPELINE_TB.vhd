-------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-------------------------------------------------------------------------------
ENTITY DATAPATH_PIPELINE_TB IS
END DATAPATH_PIPELINE_TB;
-------------------------------------------------------------------------------
ARCHITECTURE behavior OF DATAPATH_PIPELINE_TB IS
	
	-- Component Declaration for the Unit Under Test (UUT)
	
	COMPONENT DATAPATH_PIPELINE
	PORT (
		CLK				: IN STD_LOGIC;
		RST 			: IN STD_LOGIC;
		PC_LdEn 		: IN STD_LOGIC;
		BranchEq		: IN STD_LOGIC;
		BranchNotEq		: IN STD_LOGIC;
		Jump			: IN STD_LOGIC;
		RF_WrEn			: IN STD_LOGIC;
		RF_WrData_sel	: IN STD_LOGIC;
		RF_A_sel		: IN STD_LOGIC;
		RF_B_sel		: IN STD_LOGIC;
		Immed_ctrl		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		ALU_Bin_sel 	: IN STD_LOGIC;
		Op				: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ByteOp			: IN STD_LOGIC;
		MEM_WrEn		: IN STD_LOGIC;
		Instr			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);		--connect with ram
		MM_RdData 		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);		--connect with ram
		MM_Addr 		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);	--connect with ram
		MM_WrEn 		: OUT STD_LOGIC;						--connect with ram
		MM_WrData 		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);	--connect with ram
		PC				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)		--connect with ram
	);
	END COMPONENT;
	
	COMPONENT RAM
	PORT (
		clk				: IN STD_LOGIC;
		inst_addr		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		inst_dout		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we			: IN STD_LOGIC;
		data_addr		: IN STD_LOGIC_VECTOR(10 DOWNTO 0);
		data_din		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	--Inputs
	SIGNAL CLK				: STD_LOGIC := '0';
	SIGNAL RST				: STD_LOGIC := '0';
	SIGNAL PC_LdEn			: STD_LOGIC := '0';
	SIGNAL BranchEq			: STD_LOGIC;
	SIGNAL BranchNotEq		: STD_LOGIC;
	SIGNAL Jump				: STD_LOGIC;
	SIGNAL RF_WrEn			: STD_LOGIC := '0';
	SIGNAL RF_WrData_sel	: STD_LOGIC := '0';
	SIGNAL RF_A_sel			: STD_LOGIC := '0';
	SIGNAL RF_B_sel			: STD_LOGIC := '0';
	SIGNAL Immed_ctrl		: STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ALU_Bin_sel		: STD_LOGIC := '0';
	SIGNAL Op				: STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
	SIGNAL ByteOp			: STD_LOGIC := '0';
	SIGNAL MEM_WrEn			: STD_LOGIC := '0';
	SIGNAL Instr			: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL MM_RdData		: STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
	
	--Outputs
	SIGNAL MM_Addr			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MM_WrEn			: STD_LOGIC;
	SIGNAL MM_WrData		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	-- Clock period definitions
	CONSTANT CLK_period		: TIME := 100 ns;
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)

	uut : DATAPATH_PIPELINE
	PORT MAP (
		CLK				=> CLK,
		RST				=> RST,
		PC_LdEn			=> PC_LdEn,
		BranchEq		=> BranchEq,
		BranchNotEq		=> BranchNotEq,
		Jump			=> Jump,
		RF_WrEn			=> RF_WrEn,
		RF_WrData_sel	=> RF_WrData_sel,
		RF_A_sel		=> RF_A_sel,
		RF_B_sel		=> RF_B_sel,
		Immed_ctrl		=> Immed_ctrl,
		ALU_Bin_sel		=> ALU_Bin_sel,
		Op				=> Op,
		ByteOp			=> ByteOp,
		Mem_WrEn		=> MEM_WrEn,
		Instr			=> Instr,
		MM_RdData		=> MM_RdData,
		MM_Addr			=> MM_Addr,
		MM_WrEn			=> MM_WrEn,
		MM_WrData		=> MM_WrData,
		PC				=> PC
	);
	
	ram_inst : RAM
	PORT MAP (
		clk				=> clk,
		inst_addr		=> PC(12 DOWNTO 2),
		inst_dout		=> Instr,
		data_we			=> MM_WrEn,
		data_addr		=> MM_Addr(12 DOWNTO 2),
		data_din		=> MM_WrData,
		data_dout		=> MM_RdData
	);
	
	-- Clock process definitions
	CLK_process : PROCESS
	BEGIN
		CLK <= '0';
		WAIT FOR CLK_period/2;
		CLK <= '1';
		WAIT FOR CLK_period/2;
	END PROCESS;
	
	-- Stimulus process
	stim_proc : PROCESS
	BEGIN

		------ PROGRAM 1 ------
		-- hold reset state for 100 ns.
		RST <= '0';
		WAIT FOR 100 ns;

		-- inesrt stimulus here
		
		-- addi r5, r0, 8
		RST				<= '1';
		Op				<= "0000";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';
		ALU_Bin_sel		<= '1';
		MEM_WrEn		<= '0';
		RF_WrEn			<= '1';
		RF_WrData_sel	<= '0';
		ByteOp			<= '0';-- do not care
		Immed_ctrl		<= "11";
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
		-- ori r3, r0, ABCD
		RST				<= '1';
		Op				<= "0011";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';
		ALU_Bin_sel		<= '1';
		MEM_WrEn		<= '0';
		RF_WrEn			<= '1';
		RF_WrData_sel	<= '0';
		ByteOp			<= '0';-- do not care
		Immed_ctrl		<= "01";
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
		-- sw r3, 4(r0)
		RST				<= '1';
		Op				<= "0000";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '1';
		ALU_Bin_sel		<= '1';
		MEM_WrEn		<= '1';
		RF_WrEn			<= '0';
		RF_WrData_sel	<= '0';--do not care
		ByteOp			<= '0';
		Immed_ctrl		<= "11";
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
		-- lw r10, -4(r5)
		RST				<= '1';
		Op				<= "0000";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';--do not care
		ALU_Bin_sel		<= '1';
		MEM_WrEn		<= '0';
		RF_WrEn			<= '1';
		RF_WrData_sel	<= '1';
		ByteOp			<= '0';
		Immed_ctrl		<= "11";
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
		-- lb r16, 4(r0)
		RST				<= '1';
		Op				<= "0000";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';--do not care
		ALU_Bin_sel		<= '1';
		MEM_WrEn		<= '0';
		RF_WrEn			<= '1';
		RF_WrData_sel	<= '1';
		ByteOp			<= '1';
		Immed_ctrl		<= "11";
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
		-- nand r4, r10, r16
		RST				<= '1';
		Op				<= "0101";
		BranchEq		<= '0';
		BranchNotEq		<= '0';
		Jump			<= '0';
		RF_A_sel		<= '0';
		RF_B_sel		<= '0';
		ALU_Bin_sel		<= '0';
		MEM_WrEn		<= '0';
		RF_WrEn			<= '1';
		RF_WrData_sel	<= '0';
		ByteOp			<= '0';
		Immed_ctrl		<= "00";-- do not care
		PC_LdEn			<= '1';
		WAIT FOR CLK_period;
		
		
--		------ PROGRAM 2 ------
--		-- hold reset state for 100 ns.
--		RST <= '0';
--		WAIT FOR 100 ns;
--		
--		-- inesrt stimulus here
--		
--		-- #1 Iteration
--		---- bne r5, r5, 8 ----
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '0';
--		BranchNotEq		<= '1';
--		Jump			<= '0';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- b -2 --------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '0';
--		BranchNotEq		<= '0';
--		Jump			<= '1';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		-- #2 Iteration
--		---- bne r5, r5, 8 ----
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- b -2 --------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		-- #3 Iteration
--		---- bne r5, r5, 8 ----
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- b -2 --------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		-- #4 Iteration
--		---- bne r5, r5, 8 ----
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- b -2 --------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		-- #5 Iteration
--		---- bne r5, r5, 8 ----
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- b -2 --------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
		
		
		
--		----- All Instructions -----
--		
--		-------- R-type -------
--		-- insert the right Op (operation of ALU)
--		RST				<= '1';
--		Op				<= "0101";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';
--		Immed_ctrl		<= "00";-- do not care
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period*12;
--		
--		
--		---------- li ---------
--		RST				<= '1';
--		Op				<= "0011";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '1';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';-- do not care
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- lui ---------
--		RST				<= '1';
--		Op				<= "0011";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '1';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';-- do not care
--		Immed_ctrl		<= "00";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- addi --------
--		RST				<= '1';
--		Op				<= "0000";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';-- do not care
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		-------- nandi --------
--		RST				<= '1';
--		Op				<= "0101";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';-- do not care
--		Immed_ctrl		<= "01";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		--------- ori ---------
--		RST				<= '1';
--		Op				<= "0011";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '0';
--		ByteOp			<= '0';-- do not care
--		Immed_ctrl		<= "01";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		---------- b ----------
--		-- branch always taken
--		RST				<= '1';
--		Op				<= "1111";--don't care
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';--don't care
--		RF_B_sel		<= '1';--don't care
--		ALU_Bin_sel		<= '0';--don't care
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		------- beq/bne -------
--		-- branch taken		PC_sel <= '1';
--		-- branch NOT taken	PC_sel <= '0';
--		RST				<= '1';
--		Op				<= "0001";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--don't care
--		ALU_Bin_sel		<= '0';
--		MEM_WrEn		<= '0';
--		ByteOp			<= '1';--don't care
--		Immed_ctrl		<= "10";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		---------- lb ---------
--		RST				<= '1';
--		Op				<= "0000";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';--do not care
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '1';
--		ByteOp			<= '1';
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		---------- sb ---------
--		RST				<= '1';
--		Op				<= "0000";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--do not care
--		ByteOp			<= '1';
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		---------- lw ---------
--		RST				<= '1';
--		Op				<= "0000";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '0';--do not care
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '0';
--		RF_WrEn			<= '1';
--		RF_WrData_sel	<= '1';
--		ByteOp			<= '0';
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
--		
--		
--		---------- sw ---------
--		RST				<= '1';
--		Op				<= "0000";
--		BranchEq		<= '';
--		BranchNotEq		<= '';
--		Jump			<= '';
--		RF_A_sel		<= '0';
--		RF_B_sel		<= '1';
--		ALU_Bin_sel		<= '1';
--		MEM_WrEn		<= '1';
--		RF_WrEn			<= '0';
--		RF_WrData_sel	<= '0';--do not care
--		ByteOp			<= '0';
--		Immed_ctrl		<= "11";
--		PC_LdEn			<= '1';
--		WAIT FOR CLK_period;
		
		WAIT;
	END PROCESS;
END;
-------------------------------------------------------------------------------