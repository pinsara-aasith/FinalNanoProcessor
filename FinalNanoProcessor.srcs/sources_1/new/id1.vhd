LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY InstructionDecoder IS
    PORT (
        Instruction : IN STD_LOGIC_VECTOR (13 DOWNTO 0);
        Jump_sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Imd_val : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        Reg_en : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
        Reg_select_A : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Load_sel : OUT STD_LOGIC;
        Reg_select_B : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        MUX_EN_A : OUT STD_LOGIC;
        MUX_EN_B : OUT STD_LOGIC;
        REG_BANK_EN : OUT STD_LOGIC;
        Mux_2_to_1_EN : OUT STD_LOGIC;
        Add_sub_sel : OUT STD_LOGIC;
        Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Jump : OUT STD_LOGIC);
END InstructionDecoder;

ARCHITECTURE Behavioral OF InstructionDecoder IS

BEGIN

    PROCESS (Instruction, Jump_sel)
    BEGIN

        MUX_EN_A <= '0';
        MUX_EN_B <= '0';
        REG_BANK_EN <= '0';
        Jump <= '0';

        IF (Instruction(13 DOWNTO 12) = "00") THEN -- Add
            MUX_EN_A <= '1';
            MUX_EN_B <= '1';
            Reg_select_A <= Instruction(11 DOWNTO 9);
            Reg_select_B <= Instruction(8 DOWNTO 6);
            Add_sub_sel <= '1';
            Mux_2_to_1_EN <= '1';
            Load_sel <= '0';
            REG_BANK_EN <= '1';
            Reg_en <= Instruction(11 DOWNTO 9);

        ELSIF (Instruction(13 DOWNTO 12) = "01") THEN
            MUX_EN_A <= '1';
            MUX_EN_B <= '1';
            Reg_select_A <= "000";
            Reg_select_B <= Instruction(11 DOWNTO 9);
            Add_sub_sel <= '1';
            Mux_2_to_1_EN <= '1';
            Load_sel <= '0';
            REG_BANK_EN <= '1';
            Reg_en <= Instruction(11 DOWNTO 9);

        ELSIF (Instruction(13 DOWNTO 12) = "10") THEN
            REG_BANK_EN <= '1';
            Reg_en <= Instruction(11 DOWNTO 10);
            Mux_2_to_1_EN <= '1';
            Load_sel <= '1';
            Imd_val <= Instruction(3 DOWNTO 0);

        ELSIF (Instruction(13 DOWNTO 12) = "11") THEN
            -- JZR R1, 7   ; If R1 = 0 jump to line 7 format: 11 RRR 0000 ddd
            Reg_select_A <= Instruction(11 DOWNTO 9); -- GET THE VALUE OF THE REGISTER RRR IN THE REGISTER A
            IF (Jump_sel = "0000") THEN
                Jump <= '1'; -- set jump flag
                Jump_address <= Instruction(2 DOWNTO 0);
            END IF;
        END IF;
    END PROCESS;
END Behavioral;