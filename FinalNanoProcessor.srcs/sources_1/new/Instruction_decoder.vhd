LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Instruction_decoder IS
    PORT (
        Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        Reg_en : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Reg_bank_En : OUT STD_LOGIC;

        Load_sel : OUT STD_LOGIC;

        Imd_val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); --OK

        Reg_select_A : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); --OK
        Reg_select_B : OUT STD_LOGIC_VECTOR (2 DOWNTO 0); --OK

        Add_sub_sel : OUT STD_LOGIC;

        Jump : OUT STD_LOGIC;
        Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Register_check_for_jump : IN STD_LOGIC_VECTOR (3 DOWNTO 0)
    );
END Instruction_decoder;

ARCHITECTURE Behavioral OF Instruction_decoder IS

BEGIN
    PROCESS (Instruction(11 DOWNTO 0), Register_check_for_jump)
    BEGIN
        Jump <= '0';
        Reg_bank_En <= '0';

        IF (Instruction(11 DOWNTO 10) = "00") THEN -- ADD
            Reg_select_A <= Instruction(9 DOWNTO 7);
            Reg_select_B <= Instruction(6 DOWNTO 4);
            Add_sub_sel <= '0';
            Load_sel <= '0';
            Reg_en <= Instruction(9 DOWNTO 7);
            Reg_bank_En <= '1';
        ELSIF (Instruction(11 DOWNTO 10) = "01") THEN -- NEG
            Reg_select_A <= "000";
            Reg_select_B <= Instruction(9 DOWNTO 7);
            Reg_en <= Instruction(9 DOWNTO 7);
            Reg_bank_En <= '1';
            Add_sub_sel <= '1';
            Load_sel <= '0';

        ELSIF (Instruction(11 DOWNTO 10) = "10") THEN -- MOVI
            Load_sel <= '1';
            Imd_val <= Instruction(3 DOWNTO 0);
            Reg_bank_En <= '1';
            Reg_en <= Instruction(9 DOWNTO 7);

        ELSIF (Instruction(11 DOWNTO 10) = "11") THEN -- JZR
            Reg_select_A <= Instruction(9 DOWNTO 7);
            IF (Register_check_for_jump = "0000") THEN
                Jump_address <= Instruction(2 DOWNTO 0);
                Jump <= '1';
            END IF;
        END IF;
    END PROCESS;
END Behavioral;