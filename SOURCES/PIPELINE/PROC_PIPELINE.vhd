-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY PROC_PIPELINE IS
	PORT (
		CLK				: IN STD_LOGIC;
		RST				: IN STD_LOGIC;
		inst_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		inst_dout		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_we			: OUT STD_LOGIC;
		data_addr		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_din		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		data_dout		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END PROC_PIPELINE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF PROC_PIPELINE IS

	COMPONENT DATAPATH_PIPELINE
	PORT (
		CLK				: IN STD_LOGIC;
		RST				: IN STD_LOGIC;
		PC_LdEn			: IN STD_LOGIC;
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
		PC_4_OUT_IF_ID	: IN STD_LOGIC_VECTOR(31 DOWNTO 0); --connects with the input of IF/ID
		Instr			: IN STD_LOGIC_VECTOR(31 DOWNTO 0); --connect with IF/ID
		MM_RdData		: IN STD_LOGIC_VECTOR(31 DOWNTO 0); --connect with ram
		MM_Addr			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --connect with ram
		MM_WrEn			: OUT STD_LOGIC;					--connect with ram
		MM_WrData		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --connect with ram
		PC				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); --connect with ram
		PC_4_IN_IF_ID	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		IF_ID_WrEn		: OUT STD_LOGIC
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
	
	COMPONENT ALU_CONTROL
	PORT (
		ALU_Op	: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		func	: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Op		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
	END COMPONENT;
	
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
	
	COMPONENT PIPELINE_IF_ID
	PORT (
		CLK			: IN STD_LOGIC; -- clock.
		RST			: IN STD_LOGIC; -- async. clear.
		WE  		: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		PC_4_IN		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Instr_IN	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- OUTPUTS
		PC_4_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- output
		Instr_OUT	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
	);
	END COMPONENT;
	
	SIGNAL PC_LdEn_internal			: STD_LOGIC;
--	SIGNAL PC_sel_internal			: STD_LOGIC;
	SIGNAL RF_WrEn_internal			: STD_LOGIC;
	SIGNAL RF_WrData_sel_internal	: STD_LOGIC;
	SIGNAL RF_A_sel_internal		: STD_LOGIC;
	SIGNAL RF_B_sel_internal		: STD_LOGIC;
	SIGNAL Immed_ctrl_internal		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL ALU_Bin_sel_internal		: STD_LOGIC;
	SIGNAL Op_internal				: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ALU_Op_internal			: STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL ByteOp_internal			: STD_LOGIC;
	SIGNAL Mem_WrEn_internal		: STD_LOGIC;
--	SIGNAL ALU_zero_internal		: STD_LOGIC;
	SIGNAL BranchEq_internal		: STD_LOGIC;
	SIGNAL BranchNotEq_internal		: STD_LOGIC;
	SIGNAL Jump_internal			: STD_LOGIC;
	
	-- for IF/ID
	SIGNAL Instr_OUT_IF_ID			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_4_IN_IF_ID_internal	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_4_OUT_IF_ID_internal	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL IF_ID_WrEn_internal		: STD_LOGIC;
	
BEGIN
	
	datapath_inst : DATAPATH_PIPELINE
	PORT MAP (
		CLK				=> CLK,--connects with top level
		RST				=> RST,--connects with top level
		PC_LdEn			=> PC_LdEn_internal,
		BranchEq		=> BranchEq_internal,
		BranchNotEq		=> BranchNotEq_internal,
		Jump			=> Jump_internal,
		RF_WrEn			=> RF_WrEn_internal,
		RF_WrData_sel	=> RF_WrData_sel_internal,
		RF_A_sel		=> RF_A_sel_internal,
		RF_B_sel		=> RF_B_sel_internal,
		Immed_ctrl		=> Immed_ctrl_internal,
		ALU_Bin_sel		=> ALU_Bin_sel_internal,
		Op				=> Op_internal,
		ByteOp			=> ByteOp_internal,
		Mem_WrEn		=> Mem_WrEn_internal,
		PC_4_OUT_IF_ID	=> PC_4_OUT_IF_ID_internal, -- IT'S AN INPUT THAT COMES FROM IF/ID
		Instr			=> Instr_OUT_IF_ID,--comes from IF/ID
		MM_RdData		=> data_dout,
		MM_Addr			=> data_addr,
		MM_WrEn			=> data_we,
		MM_WrData		=> data_din,
		PC				=> inst_addr,
		PC_4_IN_IF_ID	=> PC_4_IN_IF_ID_internal, -- IT'S AN OUTPUT THAT GOES IN IF/ID
		IF_ID_WrEn		=> IF_ID_WrEn_internal
	);
	
	control_inst : CONTROL_PIPELINE
	PORT MAP (
		Opcode			=> Instr_OUT_IF_ID(31 DOWNTO 26),
		ALU_Op			=> ALU_Op_internal,
		ALU_Bin_sel		=> ALU_Bin_sel_internal,
		RF_A_sel		=> RF_A_sel_internal,
		RF_B_sel		=> RF_B_sel_internal,
		MEM_WrEn		=> MEM_WrEn_internal,
		RF_WrEn			=> RF_WrEn_internal,
		RF_WrData_sel	=> RF_WrData_sel_internal,
		BranchEq		=> BranchEq_internal,
		BranchNotEq		=> BranchNotEq_internal,
		Jump			=> Jump_internal,
		ByteOp			=> ByteOp_internal,
		Immed_ctrl		=> Immed_ctrl_internal,
		PC_LdEn			=> PC_LdEn_internal
	);
	
	alu_control_inst : ALU_CONTROL
	PORT MAP (
		ALU_Op	=> ALU_Op_internal,--input, comes from the FSM
		func	=> Instr_OUT_IF_ID(5 DOWNTO 0),--input, comes from the instruction
		Op		=> Op_internal-- output, goes to the Datapath and more specifically to the ALU
	);
	
	if_id_inst : PIPELINE_IF_ID
	PORT MAP (
		CLK			=> CLK,
		RST			=> RST,
		WE			=> IF_ID_WrEn_internal,-- will be connected with Hazard Detection Unit
		-- INPUTS
		PC_4_IN		=> PC_4_IN_IF_ID_internal,--will be connected with datapath(EX/MEM)
		Instr_IN	=> inst_dout,--will be connected wth RAM
		-- OUTPUTS
		PC_4_OUT	=> PC_4_OUT_IF_ID_internal,--will be connected with datapath
		Instr_OUT	=> Instr_OUT_IF_ID--will be connected with datapath
	);
	
END Behavioral;
-------------------------------------------------------------------------------