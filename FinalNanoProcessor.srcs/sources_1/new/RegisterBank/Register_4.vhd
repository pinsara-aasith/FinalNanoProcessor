LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Register_4 IS
    PORT (
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        En : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Register_4;

ARCHITECTURE Behavioral OF Register_4 IS
BEGIN
    PROCESS (Clk) BEGIN
        IF (rising_edge(Clk)) THEN -- respond when clock rises
            IF En = '1' THEN -- Enable should be set
                Q <= D;
            END IF;
        END IF;
        IF res = '1' THEN
            Q <= "0000";
        END IF;
    END PROCESS;
END Behavioral;