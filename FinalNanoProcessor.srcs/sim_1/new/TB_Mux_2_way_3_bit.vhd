LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Mux_2_way_3_bit IS
END TB_Mux_2_way_3_bit;

ARCHITECTURE Behavioral OF tb_Mux_2_way_3_bit IS
    COMPONENT Mux_2_way_3_bit
        PORT (
            S : IN STD_LOGIC;
            D0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            D1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL S : STD_LOGIC;
    SIGNAL D0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL D1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Y : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
    UUT : Mux_2_way_3_bit
    PORT MAP(
        S => S,
        D0 => D0,
        D1 => D1,
        Y => Y
    );

    --INDEX NO => 11 0011 0101 1011 1010

    PROCESS
    BEGIN
        -- Initialize inputs
        S <= '0';
        D0 <= "010";
        D1 <= "111";
        WAIT FOR 100ns;

        S <= '1';
        D0 <= "010";
        D1 <= "111";

        WAIT;
    END PROCESS;

END Behavioral;