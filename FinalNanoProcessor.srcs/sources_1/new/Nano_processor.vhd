LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Nano_processor IS
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Sign : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC;
        Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END Nano_processor;
ARCHITECTURE Behavioral OF Nano_processor IS

    COMPONENT Adder_3
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Program_counter
        PORT (
            D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC; -- SIGNAL TO RESET
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT Register_bank
        PORT (
            Reg_En : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Reg_bank_En : IN STD_LOGIC;
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Clk : IN STD_LOGIC;
            B0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reset_Reg_Bank : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Mux_2_way_3_bit
        PORT (
            S : IN STD_LOGIC;
            D0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux_2_way_4_bit
        PORT (
            S : IN STD_LOGIC;
            D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT ROM
        PORT (
            Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
            Mem_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT Instruction_decoder
        PORT (
            Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
            Load_sel : OUT STD_LOGIC;

            Reg_en : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Reg_bank_En : OUT STD_LOGIC;

            Reg_select_A : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Reg_select_B : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);

            Imd_val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Add_sub_sel : OUT STD_LOGIC;

            Jump : OUT STD_LOGIC;
            Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Register_check_for_jump : IN STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Add_Substract_4
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            AddSub_Ctrl : IN STD_LOGIC;
            Zero_flag : OUT STD_LOGIC;
            Sign_flag : OUT STD_LOGIC;
            Overflow_flag : OUT STD_LOGIC;
            Carry_flag : OUT STD_LOGIC
        );
        -- Parity_flag : OUT STD_LOGIC
    END COMPONENT;

    COMPONENT Mux_8_way_4_bit IS
        PORT (
            D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    SIGNAL S0, S1, S2, PC_Input : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- INSTRUCTION DECODER
    SIGNAL Reg_en0, Reg_select_A0, Reg_select_B0, Jump_address0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Load_sel0, Add_sub_sel0, Jmp, Reg_bank_En : STD_LOGIC;
    SIGNAL Imd_val0 : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL Zero_flag, Sign_flag, Overflow_flag, Carry_flag : STD_LOGIC;

    -- PROGRAM ROM
    SIGNAL PR_OUT : STD_LOGIC_VECTOR (11 DOWNTO 0);

    -- REGISTER BANK
    SIGNAL Reg_bank_input : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL RB0, RB1, RB2, RB3, RB4, RB5, RB6, RB7 : STD_LOGIC_VECTOR (3 DOWNTO 0);

    -- ADD/SUB
    SIGNAL Adder_Out, A, B : STD_LOGIC_VECTOR (3 DOWNTO 0);

    SIGNAL cout : STD_LOGIC;

BEGIN
    Adder_3_Bit : Adder_3
    PORT MAP(
        A => S0,
        Result => S1
    );

    Jump_selector : Mux_2_way_3_bit
    PORT MAP(
        D0 => S1,
        D1 => Jump_address0,
        S => Jmp,
        Y => PC_Input
    );

    Load_selector : Mux_2_way_4_bit
    PORT MAP(
        S => Load_sel0,
        D0 => Adder_Out,
        D1 => Imd_val0,
        Y => Reg_bank_input
    );

    PC : Program_counter
    PORT MAP(
        D => PC_Input,
        Clk => Clk,
        Q => S0,
        Res => Res
    );

    Program_ROM : ROM
    PORT MAP(
        Mem_address => S2,
        Instruction => PR_OUT
    );

    ID : Instruction_decoder
    PORT MAP(
        Instruction => PR_OUT,
        Reg_en => Reg_en0,
        Load_sel => Load_sel0,
        Imd_val => Imd_val0,
        Reg_select_A => Reg_select_A0,
        Reg_select_B => Reg_select_B0,
        Add_sub_sel => Add_sub_sel0,
        Jump_address => Jump_address0,
        Jump => Jmp,
        Register_check_for_jump => A,
        Reg_bank_En => Reg_bank_En
    );

    Reg_bank : Register_bank
    PORT MAP(
        B0 => RB0,
        B1 => RB1,
        B2 => RB2,
        B3 => RB3,
        B4 => RB4,
        B5 => RB5,
        B6 => RB6,
        B7 => RB7,
        Reg_En => Reg_en0,
        Reg_bank_En => Reg_bank_En,
        A => Reg_bank_input,
        Clk => Clk,
        Reset_Reg_Bank => Res
    );

    Add_Substract_4_0 : Add_Substract_4
    PORT MAP(
        A => A,
        B => B,
        AddSub_Ctrl => Add_sub_sel0,
        Result => Adder_Out,
        Zero_flag => Zero_flag,
        Overflow_flag => Overflow_flag,
        Carry_flag => Carry_flag,
        Sign_flag => Sign_flag
    );

    Reg_A_selector : Mux_8_way_4_bit
    PORT MAP(
        D0 => RB0,
        D1 => RB1,
        D2 => RB2,
        D3 => RB3,
        D4 => RB4,
        D5 => RB5,
        D6 => RB6,
        D7 => RB7,
        Y => A,
        S => Reg_select_A0
    );

    Reg_B_selector : Mux_8_way_4_bit
    PORT MAP(
        D0 => RB0,
        D1 => RB1,
        D2 => RB2,
        D3 => RB3,
        D4 => RB4,
        D5 => RB5,
        D6 => RB6,
        D7 => RB7,
        Y => B,
        S => Reg_select_B0
    );

    Zero <= Zero_flag;

    Sign <= Sign_flag;
    Overflow <= Overflow_flag;
    Carry <= Carry_flag;
    S2 <= S0;
    Value <= RB7;
END Behavioral;