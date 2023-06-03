LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY twoWay_3Bit_Mux IS
    PORT (
        AdderIn : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        JumpAdd : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Jump : IN STD_LOGIC;
        PC_in : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END twoWay_3Bit_Mux;

ARCHITECTURE Behavioral OF twoWay_3Bit_Mux IS

    SIGNAL Y : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

    PROCESS (Jump, AdderIn, JumpAdd)
    BEGIN
        CASE Jump IS
            WHEN '0' =>
                PC_in <= AdderIn;
            WHEN '1' =>
                PC_in <= JumpAdd;
            WHEN OTHERS =>
                PC_in <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;