LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Main_unit IS
END TB_Main_unit;

ARCHITECTURE Behavioral OF TB_Main_unit IS

    COMPONENT Main_unit
        PORT (
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC;
            S_7Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL Clk : STD_LOGIC := '0';

    -- Other signals
    SIGNAL Res, Zero, Overflow, Carry : STD_LOGIC;
    SIGNAL Value : STD_LOGIC_VECTOR(3 DOWNTO 0);

    SIGNAL S_7Seg : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL Anode : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN
    -- UUT instantiation
    UUT : Main_unit
    PORT MAP(
        Clk => Clk,
        Res => Res,
        Zero => Zero,
        Overflow => Overflow,
        Carry => Carry,
        Value => Value,
        S_7Seg => S_7Seg,
        Anode => Anode
    );

    -- Clock generation process
    PROCESS
    BEGIN
        Clk <= '0';
        WAIT FOR 5 NS;
        Clk <= '1';
        WAIT FOR 5 NS;
    END PROCESS;

    -- Stimulus process
    PROCESS
    BEGIN
        -- Initialize reset
        Res <= '1';
        WAIT FOR 40 NS;
        Res <= '0';

        WAIT;
    END PROCESS;

END Behavioral;