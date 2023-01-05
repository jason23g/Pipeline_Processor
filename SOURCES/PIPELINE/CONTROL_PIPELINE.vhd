-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY CONTROL_PIPELINE IS
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
END CONTROL_PIPELINE;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF CONTROL_PIPELINE IS

	TYPE STATE IS (S0);
	SIGNAL currS, nextS : STATE;

BEGIN

	fsm_Asynch : PROCESS (currS, Opcode)
	BEGIN
		CASE currS IS
			WHEN S0 =>
			IF (Opcode = "100000") THEN--R-type
				ALU_Op			<= "000";--depends on func
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';--we want rd
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '0';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';
				Immed_ctrl		<= "00";--do not care
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "000000") THEN--Branch equal
				ALU_Op			<= "010";
				BranchEq		<= '1';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';
				RF_B_sel		<= '1';
				ALU_Bin_sel		<= '0';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '0';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';
				Immed_ctrl		<= "10";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "000001") THEN--Branch not equal
				ALU_Op			<= "010";
				BranchEq		<= '0';
				BranchNotEq		<= '1';
				Jump			<= '0';
				RF_A_sel		<= '0';
				RF_B_sel		<= '1';
				ALU_Bin_sel		<= '0';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '0';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';
				Immed_ctrl		<= "10";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "111111") THEN--jump
				ALU_Op			<= "111";--do not care
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '1';
				RF_A_sel		<= '0';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '0';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '0';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';
				Immed_ctrl		<= "10";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "000011") THEN--lb
				ALU_Op			<= "001";
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
				nextS			<= S0;
				
			ELSIF (Opcode = "000111") THEN--sb
				ALU_Op			<= "001";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';
				RF_B_sel		<= '1';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '1';
				RF_WrEn			<= '0';
				RF_WrData_sel	<= '0';--do not care
				ByteOp			<= '1';
				Immed_ctrl		<= "11";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "001111") THEN--lw
				ALU_Op			<= "001";
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
				nextS			<= S0;

			ELSIF (Opcode = "011111") THEN--sw
				ALU_Op			<= "001";
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
				nextS			<= S0;

			ELSIF (Opcode = "110000") THEN--addi
				ALU_Op			<= "001";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';--do not care
				Immed_ctrl		<= "11";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "110010") THEN--nandi
				ALU_Op			<= "100";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				RF_B_sel		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';--do not care
				Immed_ctrl		<= "01";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "110011") THEN--ori
				ALU_Op			<= "011";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '0';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';--do not care
				Immed_ctrl		<= "01";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "111000") THEN--li
				ALU_Op			<= "011";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '1';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';--do not care
				Immed_ctrl		<= "11";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSIF (Opcode = "111001") THEN--lui
				ALU_Op			<= "011";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '1';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '1';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '1';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';--do not care
				Immed_ctrl		<= "00";
				PC_LdEn			<= '1';
				nextS			<= S0;

			ELSE
				ALU_Op			<= "011";
				BranchEq		<= '0';
				BranchNotEq		<= '0';
				Jump			<= '0';
				RF_A_sel		<= '1';
				RF_B_sel		<= '0';
				ALU_Bin_sel		<= '0';
				MEM_WrEn		<= '0';
				RF_WrEn			<= '0';
				RF_WrData_sel	<= '0';
				ByteOp			<= '0';
				Immed_ctrl		<= "00";
				PC_LdEn			<= '1';
				nextS			<= S0;

			END IF;

			WHEN OTHERS => nextS <= S0;
		END CASE;
	END PROCESS fsm_Asynch;
END Behavioral;
-------------------------------------------------------------------------------