LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_2_to_4 IS
    PORT (
        S : IN STD_LOGIC;
        D_0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        D_1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END Mux_2_to_4;

ARCHITECTURE Behavioral OF Mux_2_to_4 IS

BEGIN

    PROCESS (S, D_0, D_1)
    BEGIN
        CASE S IS
            WHEN '0' =>
                Y <= D_0;
            WHEN '1' =>
                Y <= D_1;
            WHEN OTHERS =>
                Y <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;