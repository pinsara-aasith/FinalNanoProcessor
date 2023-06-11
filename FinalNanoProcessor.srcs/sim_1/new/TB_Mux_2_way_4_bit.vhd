LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Mux_2_way_4_bit IS
END tb_Mux_2_way_4_bit;

ARCHITECTURE Behavioral OF tb_Mux_2_way_4_bit IS
    -- Component declaration for the DUT (Design Under Test)
    COMPONENT Mux_2_way_4_bit
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
    -- Instantiate the DUT
    UUT: Mux_2_way_4_bit
    PORT MAP (
        S => S,
        D0 => D0,
        D1 => D1,
        Y => Y
    );


    sim_process: PROCESS
    BEGIN
        -- Initialize inputs
        S <= '0';
        D0 <= "000";
        D1 <= "111";
        wait for 10 ns;
        
        -- Test with S = '0'
        S <= '0';
        D0 <= "101";
        D1 <= "010";
        wait for 10 ns;
        
        -- Test with S = '1'
        S <= '1';
        D0 <= "011";
        D1 <= "100";
        wait for 10 ns;
        
        wait;
    END PROCESS sim_process;

END Behavioral;
