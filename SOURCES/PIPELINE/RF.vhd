-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY RF IS
	PORT (
		CLK		: IN STD_LOGIC;
		RST		: IN STD_LOGIC;
		WrEn	: IN STD_LOGIC;
		Ard1	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Dout1	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Ard2	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Dout2	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		Awr		: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		Din		: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END RF;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF RF IS

	--component for the 32 to 1 (w/ 32 bit input) mux
	COMPONENT MUX_32x32
		PORT (
			ctrl	: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
			Din0	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din1	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din2	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din3	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din4	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din5	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din6	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din7	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din8	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din9	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din10	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din11	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din12	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din13	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din14	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din15	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din16	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din17	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din18	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din19	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din20	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din21	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din22	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din23	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din24	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din25	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din26	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din27	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din28	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din29	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din30	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Din31	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			Dout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	END COMPONENT;
	
	--component for the 5 to 32 decoder
	COMPONENT DEC_5_to_32
		PORT (
			A : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
			X : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL dec_out	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--signal for connecting WE
	SIGNAL we_out	: STD_LOGIC_VECTOR(31 DOWNTO 0);

	-- these signals are for the output of the registers and will connect to
	-- the inputs of the 2 MUXs.
	SIGNAL q_out_0	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_1	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_2	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_3	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_4	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_5	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_6	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_7	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_8	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_9	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_10 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_11 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_12 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_13 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_14 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_15 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_16 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_17 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_18 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_19 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_20 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_21 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_22 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_23 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_24 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_25 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_26 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_27 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_28 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_29 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_30 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL q_out_31 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
	--component for the 32bit register
	COMPONENT REG
	PORT (
		CLK	: IN STD_LOGIC; -- clock.
		RST	: IN STD_LOGIC; -- async. clear.
		WE	: IN STD_LOGIC; -- load/enable.
		d	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		q	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
	);
	END COMPONENT;

--begin of the architecture
BEGIN

	we_out(0) 	<= '0';--WrEn AND dec_out(0);
	we_out(1)	<= WrEn AND dec_out(1) after 2 ns;
	we_out(2)	<= WrEn AND dec_out(2) after 2 ns;
	we_out(3)	<= WrEn AND dec_out(3) after 2 ns;
	we_out(4)	<= WrEn AND dec_out(4) after 2 ns;
	we_out(5)	<= WrEn AND dec_out(5) after 2 ns;
	we_out(6)	<= WrEn AND dec_out(6) after 2 ns;
	we_out(7)	<= WrEn AND dec_out(7) after 2 ns;
	we_out(8)	<= WrEn AND dec_out(8) after 2 ns;
	we_out(9)	<= WrEn AND dec_out(9) after 2 ns;
	we_out(10)	<= WrEn AND dec_out(10) after 2 ns;
	we_out(11)	<= WrEn AND dec_out(11) after 2 ns;
	we_out(12)	<= WrEn AND dec_out(12) after 2 ns;
	we_out(13)	<= WrEn AND dec_out(13) after 2 ns;
	we_out(14)	<= WrEn AND dec_out(14) after 2 ns;
	we_out(15)	<= WrEn AND dec_out(15) after 2 ns;
	we_out(16)	<= WrEn AND dec_out(16) after 2 ns;
	we_out(17)	<= WrEn AND dec_out(17) after 2 ns;
	we_out(18)	<= WrEn AND dec_out(18) after 2 ns;
	we_out(19)	<= WrEn AND dec_out(19) after 2 ns;
	we_out(20)	<= WrEn AND dec_out(20) after 2 ns;
	we_out(21)	<= WrEn AND dec_out(21) after 2 ns;
	we_out(22)	<= WrEn AND dec_out(22) after 2 ns;
	we_out(23)	<= WrEn AND dec_out(23) after 2 ns;
	we_out(24)	<= WrEn AND dec_out(24) after 2 ns;
	we_out(25)	<= WrEn AND dec_out(25) after 2 ns;
	we_out(26)	<= WrEn AND dec_out(26) after 2 ns;
	we_out(27)	<= WrEn AND dec_out(27) after 2 ns;
	we_out(28)	<= WrEn AND dec_out(28) after 2 ns;
	we_out(29)	<= WrEn AND dec_out(29) after 2 ns;
	we_out(30)	<= WrEn AND dec_out(30) after 2 ns;
	we_out(31)	<= WrEn AND dec_out(31) after 2 ns;
	
	dec : DEC_5_to_32
	PORT MAP (
		A => Awr,	--input of decoder connects to the input of the top_level.
		X => dec_out--output of the decoder connects with an intermediate signal which we will drive to and AND gate.
	);
	
	--Reg0 just sends the value zero. It doesn't need to be an actual register.
	q_out_0 <= x"00000000";
	
	--start of generated port-map code for regs 1-31
	
	reg1 : REG
	PORT MAP (
		CLK	=> CLK,
		RST => RST,
		WE  => we_out(1),
		d   => Din,
		q   => q_out_1
	);
	
	reg2 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(2),
		d   => Din,
		q   => q_out_2
	);
	
	reg3 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(3),
		d   => Din,
		q   => q_out_3
	);
	
	reg4 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(4),
		d   => Din,
		q   => q_out_4
	);
	
	reg5 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(5),
		d   => Din,
		q   => q_out_5
	);
	
	reg6 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(6),
		d   => Din, 
		q   => q_out_6
	);
	
	reg7 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(7),
		d   => Din,
		q   => q_out_7
	);
	
	reg8 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(8),
		d   => Din,
		q   => q_out_8
	);
	
	reg9 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(9),
		d   => Din,
		q   => q_out_9
	);
	
	reg10 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(10),
		d   => Din,
		q   => q_out_10
	);
	
	reg11 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(11),
		d   => Din,
		q   => q_out_11
	);
	
	reg12 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(12),
		d   => Din,
		q   => q_out_12
	);
	
	reg13 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(13),
		d   => Din,
		q   => q_out_13
	);
	
	reg14 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(14),
		d   => Din,
		q   => q_out_14
	);
	
	reg15 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(15),
		d   => Din,
		q   => q_out_15
	);
	
	reg16 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(16),
		d   => Din,
		q   => q_out_16
	);
	
	reg17 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(17),
		d   => Din,
		q   => q_out_17
	);
	
	reg18 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(18),
		d   => Din,
		q   => q_out_18
	);
	
	reg19 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(19),
		d   => Din,
		q   => q_out_19
	);
	
	reg20 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(20),
		d   => Din,
		q   => q_out_20
	);
	
	reg21 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(21),
		d   => Din,
		q   => q_out_21
	);
	
	reg22 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(22),
		d   => Din,
		q   => q_out_22
	);
	
	reg23 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(23),
		d   => Din,
		q   => q_out_23
	);
	
	reg24 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(24),
		d   => Din,
		q   => q_out_24
	);
	
	reg25 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(25),
		d   => Din,
		q   => q_out_25
	);
	
	reg26 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(26),
		d   => Din,
		q   => q_out_26
	);
	
	reg27 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(27),
		d   => Din,
		q   => q_out_27
	);
	
	reg28 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(28),
		d   => Din,
		q   => q_out_28
	);
	
	reg29 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(29),
		d   => Din,
		q   => q_out_29
	);
	
	reg30 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(30),
		d   => Din,
		q   => q_out_30
	);
	
	reg31 : REG
	PORT MAP (
		CLK => CLK,
		RST => RST,
		WE  => we_out(31),
		d   => Din,
		q   => q_out_31
	);

	--end of generated port-map code for regs 1-31

	mux_1 : MUX_32x32
	PORT MAP (
		ctrl  => Ard1, 
		Din0  => q_out_0,
		Din1  => q_out_1,
		Din2  => q_out_2,
		Din3  => q_out_3,
		Din4  => q_out_4,
		Din5  => q_out_5,
		Din6  => q_out_6,
		Din7  => q_out_7,
		Din8  => q_out_8,
		Din9  => q_out_9,
		Din10 => q_out_10,
		Din11 => q_out_11,
		Din12 => q_out_12,
		Din13 => q_out_13,
		Din14 => q_out_14,
		Din15 => q_out_15,
		Din16 => q_out_16,
		Din17 => q_out_17,
		Din18 => q_out_18,
		Din19 => q_out_19,
		Din20 => q_out_20,
		Din21 => q_out_21,
		Din22 => q_out_22,
		Din23 => q_out_23,
		Din24 => q_out_24,
		Din25 => q_out_25,
		Din26 => q_out_26,
		Din27 => q_out_27,
		Din28 => q_out_28,
		Din29 => q_out_29,
		Din30 => q_out_30,
		Din31 => q_out_31,
		Dout  => Dout1
	);
	
	mux_2 : MUX_32x32
	PORT MAP (
		ctrl  => Ard2,
		Din0  => q_out_0,
		Din1  => q_out_1,
		Din2  => q_out_2,
		Din3  => q_out_3,
		Din4  => q_out_4,
		Din5  => q_out_5,
		Din6  => q_out_6,
		Din7  => q_out_7,
		Din8  => q_out_8,
		Din9  => q_out_9,
		Din10 => q_out_10,
		Din11 => q_out_11,
		Din12 => q_out_12,
		Din13 => q_out_13,
		Din14 => q_out_14,
		Din15 => q_out_15,
		Din16 => q_out_16,
		Din17 => q_out_17,
		Din18 => q_out_18,
		Din19 => q_out_19,
		Din20 => q_out_20,
		Din21 => q_out_21,
		Din22 => q_out_22,
		Din23 => q_out_23,
		Din24 => q_out_24,
		Din25 => q_out_25,
		Din26 => q_out_26,
		Din27 => q_out_27,
		Din28 => q_out_28,
		Din29 => q_out_29,
		Din30 => q_out_30,
		Din31 => q_out_31,
		Dout  => Dout2
	);

END Behavioral;
-------------------------------------------------------------------------------