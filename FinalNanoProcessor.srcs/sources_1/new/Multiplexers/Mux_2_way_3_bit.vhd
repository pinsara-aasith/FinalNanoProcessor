LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_2_way_3_bit IS
    PORT (
        S : IN STD_LOGIC;
        D0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        D1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END Mux_2_way_3_bit;

ARCHITECTURE Behavioral OF Mux_2_way_3_bit IS

BEGIN

    PROCESS (S, D0, D1)

    BEGIN
        CASE S IS
            WHEN '0' =>
                Y <= D0;
            WHEN '1' =>
                Y <= D1;
            WHEN OTHERS =>
                Y <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;