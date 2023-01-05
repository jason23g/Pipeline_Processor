--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--------------------------------------------------------------------------------
ENTITY PIPELINE_REG_IF_ID_TB IS
END PIPELINE_REG_IF_ID_TB;
--------------------------------------------------------------------------------
ARCHITECTURE behavior OF PIPELINE_REG_IF_ID_TB IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT PIPELINE_IF_ID
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         WE : IN  std_logic;
         PC_4_IN : IN  std_logic_vector(31 downto 0);
         Instr_IN : IN  std_logic_vector(31 downto 0);
         PC_4_OUT : OUT  std_logic_vector(31 downto 0);
         Instr_OUT : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';
   signal WE : std_logic := '0';
   signal PC_4_IN : std_logic_vector(31 downto 0) := (others => '0');
   signal Instr_IN : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal PC_4_OUT : std_logic_vector(31 downto 0);
   signal Instr_OUT : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: PIPELINE_IF_ID PORT MAP (
          CLK => CLK,
          RST => RST,
          WE => WE,
          PC_4_IN => PC_4_IN,
          Instr_IN => Instr_IN,
          PC_4_OUT => PC_4_OUT,
          Instr_OUT => Instr_OUT
        );

	-- Clock process definitions
	CLK_process : process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	
	-- Stimulus process
	stim_proc : process
	begin
		-- hold reset state for 100 ns.
		wait for 100 ns;
		RST <= '0';
		wait for CLK_period*10;
		wait;
	end process;

END;
--------------------------------------------------------------------------------