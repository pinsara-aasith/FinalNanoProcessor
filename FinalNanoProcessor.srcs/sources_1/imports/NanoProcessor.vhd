LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY NanoProcessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Halt : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        OUT_REG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END NanoProcessor;

ARCHITECTURE Behavioral OF NanoProcessor IS

    COMPONENT Adder_3_Bit
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Program_counter
        PORT (
            D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC; -- SIGNAL TO RESET
            Load : IN STD_LOGIC; -- SIGNAL TO LOAD 
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT twoWay_3Bit_Mux
        PORT (
            AdderIn : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            JumpAdd : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Jump : IN STD_LOGIC;
            PC_in : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT Register_bank
        PORT (
            Reg_En : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Clk : IN STD_LOGIC;
            RESET_Register_bank : IN STD_LOGIC;
            B0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Mux_2_to_4
        PORT (
            S : IN STD_LOGIC;
            D_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    --component ROM
    --   Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
    --      Instruction : out STD_LOGIC_VECTOR (11 downto 0));
    --end component;

    COMPONENT SAMPLE_CODE_ROM
        PORT (
            Mem_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
    END COMPONENT;

    -- component ProgramRomAdd
    --     Port ( Mem_address : in STD_LOGIC_VECTOR (2 downto 0);
    --        Instruction : out STD_LOGIC_VECTOR (11 downto 0));
    -- end component;

    COMPONENT Instruction_decoder
        PORT (
            Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
            Reg_en : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Load_sel : OUT STD_LOGIC; -- 4 way to 4 bit mux needed
            Imd_val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_selA : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Reg_selB : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Add_sub_sel : OUT STD_LOGIC;
            Jump : OUT STD_LOGIC;
            Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            -- HALT THE INSTRUCTION
            HALT : OUT STD_LOGIC;
            -- SELECT IF WE HAVE TO JUMP
            JMP_SEL : IN STD_LOGIC
        );
    END COMPONENT;

    COMPONENT RCA_4
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Ctrl : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT MUX_8_way_4_bit IS
        PORT (
            D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            D7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Y_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            S : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    --SIGNAL slowClk: std_logic;
    SIGNAL S0, S1, S2, ProgCount_Input : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- PROGRAM ROM
    SIGNAL PR_OUT : STD_LOGIC_VECTOR (11 DOWNTO 0);

    -- INSTRUCTION DECODER
    SIGNAL Reg_en0, Reg_selA0, Reg_selB0, Jump_address0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Load_sel0, Add_sub_sel0, JMP : STD_LOGIC;
    SIGNAL Imd_val0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL mux_a_en, mux_b_en, MUX_EN_2TO4 : STD_LOGIC;
    SIGNAL haltInsDec : STD_LOGIC;
    SIGNAL ZERO_FLAG : STD_LOGIC;

    -- REGISTER BANK
    SIGNAL A0 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL B00, B01, B02, B03, B04, B05, B06, B07 : STD_LOGIC_VECTOR (3 DOWNTO 0);

    -- ADD/SUB
    SIGNAL add_out, A, B : STD_LOGIC_VECTOR (3 DOWNTO 0);

    -- PROGRAM COUNTER
    SIGNAL LoadProgRom : STD_LOGIC;
    SIGNAL cout : STD_LOGIC;

BEGIN

    Adder3Bit0 : Adder_3_Bit
    PORT MAP(
        A => S0, -- INPUT FROM THE PC
        S => S1 -- INCREMENTED VALUE
    );

    mux2to10 : twoWay_3Bit_Mux
    PORT MAP(
        AdderIn => S1,
        JumpAdd => Jump_address0,
        Jump => JMP,
        PC_in => ProgCount_Input
    );

    Mux_2_to_4_0 : Mux_2_to_4
    PORT MAP(
        S => Load_sel0,
        D_0 => add_out,
        D_1 => Imd_val0,
        Y => A0
    );

    Program_counter0 : Program_counter
    PORT MAP(
        D => ProgCount_Input, -- input
        Clk => Clk,
        Q => S0, -- output
        Res => Res, -- RESET THE VALUE TO 000
        Load => LoadProgRom
    );

    ROM0 : SAMPLE_CODE_ROM
    PORT MAP(
        Mem_address => S2,
        Instruction => PR_OUT
    );

    Instruction_decoder0 : Instruction_decoder
    PORT MAP(
        Instruction => PR_OUT,
        Reg_en => Reg_en0,
        Load_sel => Load_sel0,
        Imd_val => Imd_val0,
        Reg_selA => Reg_selA0,
        Reg_selB => Reg_selB0,
        Add_sub_sel => Add_sub_sel0,
        Jump_address => Jump_address0,
        Jump => JMP,
        HALT => haltInsDec,
        JMP_SEL => ZERO_FLAG
    );

    Register_bank0 : Register_bank
    PORT MAP(
        Reg_En => Reg_en0,
        A => A0,
        Clk => Clk,
        RESET_Register_bank => Res,
        B0 => B00,
        B1 => B01,
        B2 => B02,
        B3 => B03,
        B4 => B04,
        B5 => B05,
        B6 => B06,
        B7 => B07
    );

    RCA_40 : RCA_4
    PORT MAP(
        A => A,
        B => B,
        Ctrl => Add_sub_sel0,
        S => add_out,
        Zero => ZERO_FLAG,
        Overflow => Overflow
    );

    MUX_8_way_4_bit0 : MUX_8_way_4_bit
    PORT MAP(
        D0 => B00,
        D1 => B01,
        D2 => B02,
        D3 => B03,
        D4 => B04,
        D5 => B05,
        D6 => B06,
        D7 => B07,
        Y_out => a,
        S => Reg_selA0
    );
    MUX_8_way_4_bit1 : MUX_8_way_4_bit
    PORT MAP(
        D0 => B00,
        D1 => B01,
        D2 => B02,
        D3 => B03,
        D4 => B04,
        D5 => B05,
        D6 => B06,
        D7 => B07,
        Y_out => b,
        S => Reg_selB0
    );

    Zero <= ZERO_FLAG;

    S2 <= S0;
    LoadProgRom <= NOT (Halt OR haltInsDec);
    OUT_REG <= B07;
END Behavioral;