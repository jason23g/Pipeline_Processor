---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------------------------------
ENTITY DATAPATH_PIPELINE IS
	PORT (
		CLK				: IN STD_LOGIC;
		RST 			: IN STD_LOGIC;
		PC_LdEn 		: IN STD_LOGIC; -- Comes from CONTROL
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
		IF_ID_WrEn		: OUT STD_LOGIC						--connect with IF/ID
	);
END DATAPATH_PIPELINE;
---------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF DATAPATH_PIPELINE IS

	COMPONENT IFSTAGE
	PORT (
		Clk			: IN STD_LOGIC;
		Reset		: IN STD_LOGIC;
		PC_LdEn		: IN STD_LOGIC;
		PC_sel		: IN STD_LOGIC;
		PC_Immed	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT DECSTAGE
	PORT (
		Clk				: IN STD_LOGIC;
		RST				: IN STD_LOGIC;
		Instr			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_WrEn			: IN STD_LOGIC;
		WrData			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Awr				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_A_sel		: IN STD_LOGIC;
		RF_B_sel		: IN STD_LOGIC;
		Immed_ctrl		: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		Immed			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_A			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT EXSTAGE
	PORT (
		RF_A        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_Bin_sel : IN STD_LOGIC;
		Op		    : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		PC_4		: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_out     : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_Immed	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		ALU_zero    : OUT STD_LOGIC
	);
    END COMPONENT;
	
	COMPONENT MEMSTAGE
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
	END COMPONENT;

	COMPONENT PIPELINE_ID_EX
		PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		Opcode_IN				: IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		Op_IN					: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_IN 			: IN STD_LOGIC;
		RF_A_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed_IN				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rs_IN				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt_IN				: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		Opcode_OUT				: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		--Control signals going to execution stage
		Op_OUT					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_OUT			: OUT STD_LOGIC;
		--Data signals for EXSTAGE
		RF_A_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		RF_B_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Immed_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		PC_4_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		--Control signals going to mem stage
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		--Control signals for Write Back
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rs_OUT			: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		ID_EX_Rt_OUT			: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
	END COMPONENT;

	COMPONENT PIPELINE_EX_MEM
	PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		-- for branches
		ALU_Zero_IN				: IN STD_LOGIC;
		PC_Immed_IN				: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		-- for load word/store word/R-type/I-type
		ALU_Result_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for store word
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		RF_B_IN					: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for load word/ R-type/I-type
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		-- for branches
		ALU_Zero_OUT			: OUT STD_LOGIC;
		PC_Immed_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		-- for load word/store word/R-type/I-type
		ALU_Result_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for store word
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		RF_B_OUT				: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- for load word/ R-type/I-type
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
	END COMPONENT;

	COMPONENT PIPELINE_MEM_WB
	PORT (
		CLK						: IN STD_LOGIC; -- clock.
		RST						: IN STD_LOGIC; -- async. clear.
		WE  					: IN STD_LOGIC; -- load/enable.
		-- INPUTS
		ALU_Result_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		-- will be connected with MEM_DataOut output of MEMSTAGE
		MM_RdData_IN			: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Write_Register_IN		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		-- OUTPUTS
		ALU_Result_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		MM_RdData_OUT			: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		--Control signals for Write Back
		Write_Register_OUT		: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
	END COMPONENT;

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

	COMPONENT HAZARD_DETECTION_UNIT IS
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
	END COMPONENT;

	COMPONENT MUX_HAZARD IS
	PORT (
		Ctrl 					: IN STD_LOGIC;
		Op_IN					: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_IN 			: IN STD_LOGIC;
		BranchEq_IN				: IN STD_LOGIC;
		BranchNotEq_IN			: IN STD_LOGIC;
		Jump_IN					: IN STD_LOGIC;
		MEM_WrEn_IN				: IN STD_LOGIC;
		ByteOp_IN				: IN STD_LOGIC;
		RF_WrEn_IN				: IN STD_LOGIC;
		RF_WrData_sel_IN		: IN STD_LOGIC;
		Op_OUT					: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		ALU_Bin_sel_OUT 		: OUT STD_LOGIC;
		BranchEq_OUT			: OUT STD_LOGIC;
		BranchNotEq_OUT			: OUT STD_LOGIC;
		Jump_OUT				: OUT STD_LOGIC;
		MEM_WrEn_OUT			: OUT STD_LOGIC;
		ByteOp_OUT				: OUT STD_LOGIC;
		RF_WrEn_OUT				: OUT STD_LOGIC;
		RF_WrData_sel_OUT		: OUT STD_LOGIC
	);
	END COMPONENT;

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

	COMPONENT MUX_2x1
	PORT (
		Ctrl : IN STD_LOGIC;
		Din0 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Din1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		Dout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

	SIGNAL PC_sel			: STD_LOGIC;
	SIGNAL MUX_WB_Data		: STD_LOGIC_VECTOR(31 DOWNTO 0);

	------ Control signals of forward unit ------------------------------------
	SIGNAL forward_A_sel	: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL forward_B_sel	: STD_LOGIC_VECTOR(1 DOWNTO 0);


	------ Output of forward unit muxes/Inputs of ex_stage RF_A, RF_B ---------
	SIGNAL forward_A_OUT	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL forward_B_OUT	: STD_LOGIC_VECTOR(31 DOWNTO 0);


	---------------- Internal signals of HAZARD DETECTION UNIT ----------------
	SIGNAL Op_ID_EX  					: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ALU_Bin_sel_ID_EX 			: STD_LOGIC;
	SIGNAL BranchEq_ID_EX  				: STD_LOGIC;
	SIGNAL BranchNotEq_ID_EX 			: STD_LOGIC;
	SIGNAL Jump_ID_EX 					: STD_LOGIC;
	SIGNAL MEM_WrEn_ID_EX 				: STD_LOGIC;
	SIGNAL ByteOp_ID_EX 				: STD_LOGIC;
	SIGNAL RF_WrEn_ID_EX  				: STD_LOGIC;
	SIGNAL RF_WrData_sel_ID_EX  		: STD_LOGIC;
	SIGNAL mux_hazard_sel				: STD_LOGIC;
	SIGNAL PC_LdEn_internal				: STD_LOGIC;


	------------------- Internal signals of PIPELINE_ID_EX ----------------
	-- INPUTS
	SIGNAL RF_A_IN_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RF_B_IN_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Immed_IN_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Write_Register_IN_ID_EX		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ID_EX_Rs_IN_ID_EX			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ID_EX_Rt_IN_ID_EX			: STD_LOGIC_VECTOR(4 DOWNTO 0);

	-- OUTPUTS
	SIGNAL Opcode_OUT_ID_EX				: STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL Op_OUT_ID_EX					: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ALU_Bin_sel_OUT_ID_EX 		: STD_LOGIC;
	SIGNAL RF_A_OUT_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL RF_B_OUT_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Immed_OUT_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL PC_4_OUT_ID_EX				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL BranchEq_OUT_ID_EX			: STD_LOGIC;
	SIGNAL BranchNotEq_OUT_ID_EX		: STD_LOGIC;
	SIGNAL Jump_OUT_ID_EX				: STD_LOGIC;
	SIGNAL MEM_WrEn_OUT_ID_EX			: STD_LOGIC;
	SIGNAL ByteOp_OUT_ID_EX				: STD_LOGIC;
	SIGNAL Write_Register_OUT_ID_EX		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ID_EX_Rs_OUT_ID_EX			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL ID_EX_Rt_OUT_ID_EX			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL RF_WrEn_OUT_ID_EX			: STD_LOGIC;
	SIGNAL RF_WrData_sel_OUT_ID_EX		: STD_LOGIC;


	--------------------Internals signals of PIPELINE_EX_MEM-----------------
	-- INPUTS
	SIGNAL ALU_Zero_IN_EX_MEM			: STD_LOGIC;
	SIGNAL PC_Immed_IN_EX_MEM			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL BranchEq_IN_EX_MEM			: STD_LOGIC;
	SIGNAL BranchNotEq_IN_EX_MEM		: STD_LOGIC;
	SIGNAL Jump_IN_EX_MEM				: STD_LOGIC;
	SIGNAL ALU_Result_IN_EX_MEM			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MEM_WrEn_IN_EX_MEM			: STD_LOGIC;
	SIGNAL ByteOp_IN_EX_MEM				: STD_LOGIC;
	SIGNAL Write_Register_IN_EX_MEM		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL RF_WrEn_IN_EX_MEM			: STD_LOGIC;
	SIGNAL RF_WrData_sel_IN_EX_MEM		: STD_LOGIC;

	-- OUTPUTS
	SIGNAL ALU_Zero_OUT_EX_MEM			: STD_LOGIC;
	SIGNAL PC_Immed_OUT_EX_MEM			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL BranchEq_OUT_EX_MEM			: STD_LOGIC;
	SIGNAL BranchNotEq_OUT_EX_MEM		: STD_LOGIC;
	SIGNAL Jump_OUT_EX_MEM				: STD_LOGIC;
	SIGNAL ALU_Result_OUT_EX_MEM		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MEM_WrEn_OUT_EX_MEM			: STD_LOGIC;
	SIGNAL ByteOp_OUT_EX_MEM			: STD_LOGIC;
	SIGNAL RF_B_OUT_EX_MEM				: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Write_Register_OUT_EX_MEM	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL RF_WrEn_OUT_EX_MEM			: STD_LOGIC;
	SIGNAL RF_WrData_sel_OUT_EX_MEM		: STD_LOGIC;


	------------------- Internals signals of PIPELINE_MEM_WB ------------------
	-- INPUTS
	SIGNAL ALU_Result_IN_MEM_WB			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MM_RdData_IN_MEM_WB			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Write_Register_IN_MEM_WB		: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL RF_WrEn_IN_MEM_WB			: STD_LOGIC;
	SIGNAL RF_WrData_sel_IN_MEM_WB		: STD_LOGIC;

	-- OUTPUTS
	SIGNAL ALU_Result_OUT_MEM_WB		: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL MM_RdData_OUT_MEM_WB			: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL Write_Register_OUT_MEM_WB	: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL RF_WrEn_OUT_MEM_WB			: STD_LOGIC;
	SIGNAL RF_WrData_sel_OUT_MEM_WB		: STD_LOGIC;


BEGIN

	PC_sel	<=	Jump_OUT_EX_MEM OR (BranchEq_OUT_EX_MEM AND ALU_Zero_OUT_EX_MEM) OR (BranchNotEq_OUT_EX_MEM AND (NOT ALU_Zero_OUT_EX_MEM));


	ifstage_inst : IFSTAGE
	PORT MAP (
		Reset			=> RST,
		Clk				=> CLK,
		PC_LdEn			=> PC_LdEn_internal, --apo to hazard detection unit
		PC_sel			=> PC_sel,
		PC_Immed		=> PC_Immed_OUT_EX_MEM, --apo ton reg_ex_mem
		PC				=> PC,
		PC_4			=> PC_4_IN_IF_ID
	);


	mux_wr_sel : MUX_2x1
	PORT MAP (
		Ctrl => RF_WrData_sel_OUT_MEM_WB,
		Din0 => ALU_Result_OUT_MEM_WB,
		Din1 => MM_RdData_OUT_MEM_WB,
		Dout => MUX_WB_Data
	);


	decstage_inst : DECSTAGE
	PORT MAP (
		Clk				=> CLK,
		RST				=> RST,
		Instr			=> Instr,
		RF_WrEn			=> RF_WrEn_OUT_MEM_WB,
		WrData			=> MUX_WB_Data,
		Awr				=> Write_Register_OUT_MEM_WB,
		RF_A_sel		=> RF_A_sel,
		RF_B_sel		=> RF_B_sel,
		Immed_ctrl		=> Immed_ctrl,
		Immed			=> Immed_IN_ID_EX, --apo to decode
		RF_A			=> RF_A_IN_ID_EX,
		RF_B			=> RF_B_IN_ID_EX
	);


	Write_Register_IN_ID_EX		<=	Instr(20 DOWNTO 16);
	ID_EX_Rs_IN_ID_EX			<=  Instr(25 DOWNTO 21);

	ID_EX_Rt_IN_ID_EX			<=	Instr(20 DOWNTO 16) WHEN Instr(31 DOWNTO 26) = "011111" ELSE
									Instr(15 DOWNTO 11);


	id_ex_inst : PIPELINE_ID_EX
	PORT MAP (
		CLK						=> CLK,
		RST						=> RST,
		WE  					=> '1',
		-- INPUTS
		Opcode_IN				=> Instr(31 DOWNTO 26),
		Op_IN					=> Op_ID_EX,
		ALU_Bin_sel_IN			=> ALU_Bin_sel_ID_EX,
		RF_A_IN					=> RF_A_IN_ID_EX,
		RF_B_IN					=> RF_B_IN_ID_EX,
		Immed_IN				=> Immed_IN_ID_EX,
		PC_4_IN					=> PC_4_OUT_IF_ID,
		BranchEq_IN				=> BranchEq_ID_EX,
		BranchNotEq_IN			=> BranchNotEq_ID_EX,
		Jump_IN					=> Jump_ID_EX,
		MEM_WrEn_IN				=> MEM_WrEn_ID_EX,
		ByteOp_IN				=> ByteOp_ID_EX,
		Write_Register_IN		=> Write_Register_IN_ID_EX,
		ID_EX_Rs_IN				=> ID_EX_Rs_IN_ID_EX,
		ID_EX_Rt_IN				=> ID_EX_Rt_IN_ID_EX,
		RF_WrEn_IN				=> RF_WrEn_ID_EX,
		RF_WrData_sel_IN		=> RF_WrData_sel_ID_EX,
		-- OUTPUTS
		Opcode_OUT				=> Opcode_OUT_ID_EX,
		--Control signals going to execution stage
		Op_Out					=> Op_OUT_ID_EX,
		ALU_Bin_sel_Out			=> ALU_Bin_sel_OUT_ID_EX,
		--Data signals for EXSTAGE
		RF_A_OUT				=> RF_A_OUT_ID_EX,
		RF_B_OUT				=> RF_B_OUT_ID_EX,
		Immed_OUT				=> Immed_OUT_ID_EX,
		PC_4_OUT				=> PC_4_OUT_ID_EX,
		BranchEq_OUT			=> BranchEq_OUT_ID_EX,
		BranchNotEq_OUT			=> BranchNotEq_OUT_ID_EX,
		Jump_OUT				=> Jump_OUT_ID_EX,
		--Control signals going to mem stage
		MEM_WrEn_OUT			=> MEM_WrEn_OUT_ID_EX,
		ByteOp_OUT				=> ByteOp_OUT_ID_EX,
		--Control signals for Write Back
		Write_Register_OUT		=> Write_Register_OUT_ID_EX,
		ID_EX_Rs_OUT			=> ID_EX_Rs_OUT_ID_EX,
		ID_EX_Rt_OUT			=> ID_EX_Rt_OUT_ID_EX,
		RF_WrEn_OUT				=> RF_WrEn_OUT_ID_EX,
		RF_WrData_sel_OUT		=> RF_WrData_sel_OUT_ID_EX
	);


	exstage_inst : EXSTAGE
	PORT MAP (
		RF_A			=> forward_A_OUT,
		RF_B			=> forward_B_OUT,
		Immed			=> Immed_OUT_ID_EX,
		ALU_Bin_sel		=> ALU_Bin_sel_OUT_ID_EX,
		PC_4			=> PC_4_OUT_ID_EX,
		Op				=> Op_OUT_ID_EX,
		--mia eisodos sto dec kai alles duo stous mux_forward_A kai mux_forward_A
		ALU_out			=> ALU_Result_IN_EX_MEM,
		PC_Immed		=> PC_Immed_IN_EX_MEM,
		ALU_zero		=> ALU_Zero_IN_EX_MEM
	);


	BranchEq_IN_EX_MEM			<=	BranchEq_OUT_ID_EX;
	BranchNotEq_IN_EX_MEM		<=	BranchNotEq_OUT_ID_EX;
	Jump_IN_EX_MEM				<=	Jump_OUT_ID_EX;
	MEM_WrEn_IN_EX_MEM			<=	MEM_WrEn_OUT_ID_EX;
	ByteOp_IN_EX_MEM			<=	ByteOp_OUT_ID_EX;
	Write_Register_IN_EX_MEM	<=	Write_Register_OUT_ID_EX;
	RF_WrEn_IN_EX_MEM			<=	RF_WrEn_OUT_ID_EX;
	RF_WrData_sel_IN_EX_MEM		<=	RF_WrData_sel_OUT_ID_EX;


	ex_mem_inst : PIPELINE_EX_MEM
	PORT MAP (
		CLK						=> CLK,
		RST						=> RST,
		WE						=> '1',
		-- INPUTS
		-- for branches
		ALU_Zero_IN				=> ALU_Zero_IN_EX_MEM,
		PC_Immed_IN				=> PC_Immed_IN_EX_MEM,
		BranchEq_IN				=> BranchEq_IN_EX_MEM,
		BranchNotEq_IN			=> BranchNotEq_IN_EX_MEM,
		Jump_IN					=> Jump_IN_EX_MEM,
		-- for load word/store word/R-type/I-type
		ALU_Result_IN			=> ALU_Result_IN_EX_MEM,
		-- for store word
		MEM_WrEn_IN				=> MEM_WrEn_IN_EX_MEM,
		ByteOp_IN				=> ByteOp_IN_EX_MEM,
		-- The following line is very much important. It connects the output
		-- of the FORWARDING_UNIT with RF_B_IN which is the data, that will
		-- be stored in the RAM.
		RF_B_IN					=> forward_B_OUT,
		-- for load word/ R-type/I-type
		Write_Register_IN		=> Write_Register_IN_EX_MEM,
		RF_WrEn_IN				=> RF_WrEn_IN_EX_MEM,
		RF_WrData_sel_IN		=> RF_WrData_sel_IN_EX_MEM,
		ALU_Zero_OUT			=> ALU_Zero_OUT_EX_MEM,
		PC_Immed_OUT			=> PC_Immed_OUT_EX_MEM,
		BranchEq_OUT			=> BranchEq_OUT_EX_MEM,
		BranchNotEq_OUT			=> BranchNotEq_OUT_EX_MEM,
		Jump_OUT				=> Jump_OUT_EX_MEM,
		-- for load word/store word/R-type/I-type
		ALU_Result_OUT			=> ALU_Result_OUT_EX_MEM,
		-- for store word
		MEM_WrEn_OUT			=> MEM_WrEn_OUT_EX_MEM,
		ByteOp_OUT				=> ByteOp_OUT_EX_MEM,
		RF_B_OUT				=> RF_B_OUT_EX_MEM,
		-- for load word/ R-type/I-type
		Write_Register_OUT		=> Write_Register_OUT_EX_MEM,
		RF_WrEn_OUT				=> RF_WrEn_OUT_EX_MEM,
		RF_WrData_sel_OUT		=> RF_WrData_sel_OUT_EX_MEM
	);


	memstage_inst : MEMSTAGE
	PORT MAP (
		ByteOp			=> ByteOp_OUT_EX_MEM,
		MEM_WrEn		=> MEM_WrEn_OUT_EX_MEM,
		ALU_MEM_Addr	=> ALU_Result_OUT_EX_MEM,
		MEM_DataIn		=> RF_B_OUT_EX_MEM,
		MEM_DataOut		=> MM_RdData_IN_MEM_WB,
		MM_Addr			=> MM_Addr,
		MM_WrEn			=> MM_WrEn,
		MM_WrData		=> MM_WrData,
		MM_RdData		=> MM_RdData
	);


	ALU_Result_IN_MEM_WB		<=	ALU_Result_OUT_EX_MEM;
	RF_WrEn_IN_MEM_WB			<=	RF_WrEn_OUT_EX_MEM;
	RF_WrData_sel_IN_MEM_WB		<=	RF_WrData_sel_OUT_EX_MEM;
	Write_Register_IN_MEM_WB	<=	Write_Register_OUT_EX_MEM;


	mem_wb_inst : PIPELINE_MEM_WB
	PORT MAP (
		CLK						=> CLK,
		RST						=> RST,
		WE						=> '1',
		-- INPUTS
		ALU_Result_IN			=> ALU_Result_IN_MEM_WB,
		-- will be connected with MEM_DataOut output of MEMSTAGE
		MM_RdData_IN			=> MM_RdData_IN_MEM_WB,
		Write_Register_IN		=> Write_Register_IN_MEM_WB,
		RF_WrEn_IN				=> RF_WrEn_IN_MEM_WB,
		RF_WrData_sel_IN		=> RF_WrData_sel_IN_MEM_WB,
		-- OUTPUTS
		ALU_Result_OUT			=> ALU_Result_OUT_MEM_WB,
		MM_RdData_OUT			=> MM_RdData_OUT_MEM_WB,
		--Control signals for Write Back
		Write_Register_OUT		=> Write_Register_OUT_MEM_WB,
		RF_WrEn_OUT				=> RF_WrEn_OUT_MEM_WB,
		RF_WrData_sel_OUT		=> RF_WrData_sel_OUT_MEM_WB
	);


	mux_forward_A : MUX_4x1
	PORT MAP (
		Ctrl => forward_A_sel,
		Din0 => RF_A_OUT_ID_EX,
		Din1 => MUX_WB_Data,
		Din2 => ALU_Result_OUT_EX_MEM,
		Din3 => x"00000000", --currently not used
		Dout => forward_A_OUT --connects with RF_A in EXSTAGE
	);


	mux_forward_B : MUX_4x1
	PORT MAP (
		Ctrl => forward_B_sel,
		Din0 => RF_B_OUT_ID_EX,
		Din1 => MUX_WB_Data,
		Din2 => ALU_Result_OUT_EX_MEM,
		Din3 => x"00000000", --currently not used
		Dout => forward_B_OUT --connects with RF_B in EXSTAGE
	);


	forwarding_unit_inst : FORWARDING_UNIT
	PORT MAP (
		ID_EX_Rs		=>	ID_EX_Rs_OUT_ID_EX,
		ID_EX_Rt		=>	ID_EX_Rt_OUT_ID_EX,
		EX_MEM_Rd		=>	Write_Register_OUT_EX_MEM,
		MEM_WB_Rd		=>	Write_Register_OUT_MEM_WB,
		EX_MEM_RF_WrEn	=>	RF_WrEn_OUT_EX_MEM,
		MEM_WB_RF_WrEn	=>	RF_WrEn_OUT_MEM_WB,
		forward_A		=>	forward_A_sel,
		forward_B		=>	forward_B_sel
	);


	mux_hazard_inst : MUX_HAZARD
	PORT MAP (
		Ctrl					=> mux_hazard_sel,
		Op_IN					=> Op,
		ALU_Bin_sel_IN 			=> ALU_Bin_sel,
		BranchEq_IN				=> BranchEq,
		BranchNotEq_IN			=> BranchNotEq,
		Jump_IN					=> Jump, 
		MEM_WrEn_IN				=> MEM_WrEn, 
		ByteOp_IN				=> ByteOp,
		RF_WrEn_IN				=> RF_WrEn,
		RF_WrData_sel_IN		=> RF_WrData_sel,
		Op_OUT					=> Op_ID_EX,
		ALU_Bin_sel_OUT 		=> ALU_Bin_sel_ID_EX,
		BranchEq_OUT			=> BranchEq_ID_EX,
		BranchNotEq_OUT			=> BranchNotEq_ID_EX,
		Jump_OUT				=> Jump_ID_EX,
		MEM_WrEn_OUT			=> MEM_WrEn_ID_EX,
		ByteOp_OUT				=> ByteOp_ID_EX,
		RF_WrEn_OUT				=> RF_WrEn_ID_EX,
		RF_WrData_sel_OUT		=> RF_WrData_sel_ID_EX
	);


	hazard_det_unit_inst : HAZARD_DETECTION_UNIT
	PORT MAP (
		PC_LdEn_CONTROL	=> PC_LdEn, -- From the DATAPATH input, which comes from CONTROL
		Rs_IF_ID		=> Instr(25 DOWNTO 21),
		Rt_IF_ID		=> Instr(15 DOWNTO 11),
		Rd_IF_ID		=> Instr(20 DOWNTO 16),
		Opcode_IF_ID	=> Instr(31 DOWNTO 26), -- the instruction after Opcode_OUT_ID_EX
		Rd_ID_EX		=> Write_Register_OUT_ID_EX,
		Opcode_ID_EX	=> Opcode_OUT_ID_EX,
		PC_LdEn			=> PC_LdEn_internal,
		IF_ID_WrEn		=> IF_ID_WrEn,
		Ctrl_sel		=> mux_hazard_sel
	);


END Behavioral;
---------------------------------------------------------------------------------