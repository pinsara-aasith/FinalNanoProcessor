LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MasterNanoProcessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Halt : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        S_LED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        S_7Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );

END MasterNanoProcessor;

ARCHITECTURE Behavioral OF MasterNanoProcessor IS

    COMPONENT NanoProcessor
        PORT (
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Halt : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            OUT_REG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT LUT_16_7
        PORT (
            address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Slow_Clk IS
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL slowClk : STD_LOGIC;
    SIGNAL address : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    Clk0 : Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => slowClk
    );

    NanoProcessor0 : NanoProcessor
    PORT MAP(
        Clk => slowClk,
        Res => Res,
        Halt => Halt,
        Zero => Zero,
        Overflow => Overflow,
        OUT_REG => address
    );

    LUT_16_7_0 : LUT_16_7
    PORT MAP(
        address => address,
        data => S_7Seg
    );

    -- to only switch on last 7 seg display
    Anode <= "1110";
    S_LED <= address;
END Behavioral;