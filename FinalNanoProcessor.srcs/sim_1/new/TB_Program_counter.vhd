
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY PC_Sim IS
    --  Port ( );
END PC_Sim;


ARCHITECTURE Behavioral OF PC_Sim IS
    COMPONENT PC
        PORT (
            D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Res : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Load : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    SIGNAL D : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Res, Clk : STD_LOGIC;
    SIGNAL Q : STD_LOGIC_VECTOR(2 DOWNTO 0);

    CONSTANT Clk_period : TIME := 10 ns;

BEGIN

    --INDEX NO => 11 0011 0101 0000 1101

    UUT : PC PORT MAP(
        D => D,
        Res => Res,
        Clk => Clk,
        Q => Q
    );

    Clk_process : PROCESS
    BEGIN
        Clk <= '0';
        WAIT FOR Clk_period/2;
        Clk <= '1';
        WAIT FOR Clk_period/2;
    END PROCESS;

    PROCESS
    BEGIN
        Load <= '1';
        Res <= '0';

        D <= "101";
        WAIT FOR 100ns;
        Res <= '1';
        WAIT FOR 100ns;

        D <= "001";
        WAIT FOR 100ns;
        Res <= '1';
        WAIT FOR 100ns;

        WAIT;
    END PROCESS;
END Behavioral;