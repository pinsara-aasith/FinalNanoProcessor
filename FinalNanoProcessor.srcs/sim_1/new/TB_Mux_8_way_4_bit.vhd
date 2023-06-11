LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Mux_8_way_4_bit IS
END tb_Mux_8_way_4_bit;

ARCHITECTURE Behavioral OF tb_Mux_8_way_4_bit IS
    -- Component declaration for the DUT (Design Under Test)
    COMPONENT Mux_8_way_4_bit
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
    END COMPONENT;

    -- Signal declarations
    SIGNAL D0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D4 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D5 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D6 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL D7 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Y : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
    -- Instantiate the DUT
    UUT: Mux_8_way_4_bit
    PORT MAP (
        D0 => D0,
        D1 => D1,
        D2 => D2,
        D3 => D3,
        D4 => D4,
        D5 => D5,
        D6 => D6,
        D7 => D7,
        Y => Y,
        S => S
    );


    sim_process: PROCESS
    BEGIN
        -- Initialize inputs
        D0 <= "0000";
        D1 <= "1111";
        D2 <= "0101";
        D3 <= "1010";
        D4 <= "0011";
        D5 <= "1100";
        D6 <= "0110";
        D7 <= "1001";
        S <= "000";
        wait for 10 ns;
        
        -- Test with S = "001"
        S <= "001";
        wait for 10 ns;
        
        -- Test with S = "010"
        S <= "010";
        wait for 10 ns;
        
        -- Test with S = "111"
        S <= "111";
        wait for 10 ns;
        
        -- End simulation
        wait;
    END PROCESS sim_process;

END Behavioral;
