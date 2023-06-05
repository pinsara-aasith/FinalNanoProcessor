LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MasterNano_processor IS
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

END MasterNano_processor;

ARCHITECTURE Behavioral OF MasterNano_processor IS

    COMPONENT Nano_processor
        PORT (
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Halt : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            OUT_REG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
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

    Nano_processor0 : Nano_processor
    PORT MAP(
        Clk => slowClk,
        Res => Res,
        Halt => Halt,
        Zero => Zero,
        Overflow => Overflow,
        OUT_REG => address
    );

    Anode <= "1110";
    S_LED <= address;
END Behavioral;