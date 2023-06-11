LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Main_unit IS
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        S_7Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );

END Main_unit;

ARCHITECTURE Behavioral OF Main_unit IS
    COMPONENT Nano_processor
        PORT (
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Slow_Clk IS
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT LUT_16_7_Seg
        PORT (
            Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    SIGNAL SlowClk : STD_LOGIC;
    SIGNAL Zero_flag, Overflow_flag : STD_LOGIC;
    SIGNAL Val : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL S_7Seg_out : STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN

    Clock_0 : Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => SlowClk
    );

    Nano_processor_0 : Nano_processor
    PORT MAP(
        Clk => SlowClk,
        Res => Res,
        Zero => Zero_flag,
        Overflow => Overflow_flag,
        Value => Val
    );

    LUT : LUT_16_7_Seg PORT MAP(
        Address => Val,
        Data => S_7Seg_out
    );

    Value <= Val;
    Overflow <= Overflow_flag;
    Zero <= Zero_flag;

    S_7Seg <= S_7Seg_out;
    Anode <= "1110";
END Behavioral;