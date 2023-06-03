LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Counter IS

    PORT (
        Dir : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );

END Counter;

ARCHITECTURE Behavioral OF Counter IS
    COMPONENT D_FF
        PORT (
            D : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Q : OUT STD_LOGIC;
            Qbar : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Slow_Clk
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL D0, D1, D2 : STD_LOGIC;
    SIGNAL Q0, Q1, Q2 : STD_LOGIC;
    SIGNAL Clk_slow : STD_LOGIC;

BEGIN

    Slow_Clk0 : Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => Clk_slow);
    D0 <= ((NOT Q2) AND (NOT Dir)) OR (Q1 AND Dir);
    D1 <= ((NOT Dir) AND Q0) OR (Dir AND Q2);
    D2 <= ((NOT Dir) AND Q1) OR (Dir AND (NOT Q0)
        );

    D_FF0 : D_FF
    PORT MAP(
        D => D0,
        Res => Res,
        Clk => Clk_slow,
        Q => Q0);

    D_FF1 : D_FF
    PORT MAP(
        D => D1,
        Res => Res,
        Clk => Clk_slow,
        Q => Q1);

    D_FF2 : D_FF
    PORT MAP(
        D => D2,
        Res => Res,
        Clk => Clk_slow,
        Q => Q2);

    Q(0) <= Q0;
    Q(1) <= Q1;
    Q(2) <= Q2;

END Behavioral;