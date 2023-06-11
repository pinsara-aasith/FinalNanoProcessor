LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Mux_8_way_4_bit IS
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
        S : IN STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END Mux_8_way_4_bit;

ARCHITECTURE Behavioral OF Mux_8_way_4_bit IS

BEGIN

    PROCESS (S, D0, D1, D2, D3, D4, D5, D6, D7)
    BEGIN
        CASE S IS
            WHEN "000" =>
                Y <= D0;
            WHEN "001" =>
                Y <= D1;
            WHEN "010" =>
                Y <= D2;
            WHEN "011" =>
                Y <= D3;
            WHEN "100" =>
                Y <= D4;
            WHEN "101" =>
                Y <= D5;
            WHEN "110" =>
                Y <= D6;
            WHEN "111" =>
                Y <= D7;
            WHEN OTHERS =>
                Y <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;