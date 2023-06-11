LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Instruction_decoder IS
END tb_Instruction_decoder;

ARCHITECTURE Behavioral OF tb_Instruction_decoder IS
    -- Signal declarations
    SIGNAL Instruction : STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL Reg_en : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Load_sel : STD_LOGIC;
    SIGNAL Imd_val : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Reg_select_A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Reg_select_B : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Add_sub_sel : STD_LOGIC;
    SIGNAL Jump : STD_LOGIC;
    SIGNAL Jump_address : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Zero_flag : STD_LOGIC;

    -- Component declaration for the DUT (Design Under Test)
    COMPONENT Instruction_decoder
        PORT (
            Instruction : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
            Reg_en : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Load_sel : OUT STD_LOGIC;
            Imd_val : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Reg_select_A : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Reg_select_B : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Add_sub_sel : OUT STD_LOGIC;
            Jump : OUT STD_LOGIC;
            Jump_address : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            Zero_flag : IN STD_LOGIC
        );
    END COMPONENT;

BEGIN
    -- Instantiate the DUT
    UUT : Instruction_decoder
    PORT MAP(
        Instruction => Instruction,
        Reg_en => Reg_en,
        Load_sel => Load_sel,
        Imd_val => Imd_val,
        Reg_select_A => Reg_select_A,
        Reg_select_B => Reg_select_B,
        Add_sub_sel => Add_sub_sel,
        Jump => Jump,
        Jump_address => Jump_address,
        Zero_flag => Zero_flag
    );

    -- Clock process
    PROCESS
    BEGIN
        WAIT FOR 10ns;
        WAIT FOR 10ns;
        WAIT FOR 10ns;
        WAIT;
    END PROCESS;
    PROCESS
    BEGIN
        Zero_flag <= '0';

        Instruction <= "100010000001"; -- MOVI  R1, 1 
        WAIT FOR 20ns;

        Instruction <= "101110000000"; -- MOVI  R7, 0
        WAIT FOR 20ns;

        Instruction <= "001110010000"; -- ADD   R7, R1
        WAIT FOR 20ns;

        Instruction <= "011110000000"; -- NEG   R7
        WAIT FOR 20ns;

        Zero_flag <= '0';
        Instruction <= "110010000001"; -- JZR   R1, 1
        WAIT FOR 20ns;

        Zero_flag <= '1';
        Instruction <= "110010000001";
        WAIT FOR 20ns;

        WAIT;

    END PROCESS;

END Behavioral;