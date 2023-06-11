LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Instruction_decoder IS
    PORT (
        Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        Reg_en : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);

        Load_sel : OUT STD_LOGIC;

        Imd_val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); --OK

        Reg_select_A : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); --OK
        Reg_select_B : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); --OK

        Add_sub_sel : OUT STD_LOGIC;

        Jump : OUT STD_LOGIC;
        Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Zero_flag : IN STD_LOGIC
    );
END Instruction_decoder;

ARCHITECTURE Behavioral OF Instruction_decoder IS

    SIGNAL Ins_ADD : STD_LOGIC;
    SIGNAL Ins_NEG : STD_LOGIC;
    SIGNAL Ins_JZR : STD_LOGIC;
    SIGNAL Ins_MOV : STD_LOGIC;

BEGIN
    PROCESS (Instruction(11 DOWNTO 10))
    BEGIN
        Ins_MOV <= '0';
        Ins_JZR <= '0';
        Ins_ADD <= '0';
        Ins_NEG <= '0';

        CASE Instruction(11 DOWNTO 10) IS
            WHEN "00" =>
                Ins_ADD <= '1';
            WHEN "01" =>
                Ins_NEG <= '1';
            WHEN "10" =>
                Ins_MOV <= '1';
            WHEN OTHERS =>
                Ins_JZR <= '1';
        END CASE;
    END PROCESS;

    PROCESS (Ins_MOV, Ins_ADD, Ins_NEG, Ins_JZR, Zero_flag)
    BEGIN
        Jump <= '0';

        IF (Ins_ADD = '1') THEN
            Reg_select_A <= Instruction(11 DOWNTO 9);
            Reg_select_B <= Instruction(8 DOWNTO 6);
            Add_sub_sel <= '1';
            Load_sel <= '0';
            Reg_en <= Instruction(11 DOWNTO 9);

        ELSIF (Ins_NEG = '1') THEN
            Reg_select_A <= "000"; -- ALWAYS 0
            Reg_select_B <= Instruction(11 DOWNTO 9);
            Reg_en <= Instruction(11 DOWNTO 9);
            Add_sub_sel <= '1';
            Load_sel <= '0';

        ELSIF (Ins_MOV = '1') THEN
            Load_sel <= '1';
            Imd_val <= Instruction(3 DOWNTO 0);
            Reg_en <= Instruction(11 DOWNTO 10);

        ELSIF (Ins_JZR = '1') THEN
            Reg_select_A <= Instruction(11 DOWNTO 9); -- GET THE VALUE OF THE REGISTER RRR IN THE REGISTER A
            IF (Zero_flag = '1') THEN
                Jump_address <= Instruction(2 DOWNTO 0);
                Jump <= '1';
            END IF;
        END IF;
    END PROCESS;

END Behavioral;