LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_Mux_8_way_4_bit IS
END TB_Mux_8_way_4_bit;

ARCHITECTURE Behavioral OF tb_Mux_8_way_4_bit IS
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


    PROCESS
    BEGIN

        --INDEX NO 1 => 11 0011 0101 1011 1010
        --INDEX NO 2 => 11 0011 0101 0000 1101
    
        D0 <= "1010";
        D1 <= "1011";
        D2 <= "0101";
        D3 <= "0011";
        D4 <= "1101";
        D5 <= "0000";
        D6 <= "0101";
        D7 <= "0011";
        
        S <= "000";
        wait for 10ns;
        
        S <= "001";
        wait for 10ns;

        S <= "010";
        wait for 10ns;
        
        S <= "011";
        wait for 10ns;

        S <= "100";
        wait for 10ns;

        S <= "101";
        wait for 10ns;

        S <= "110";
        wait for 10ns;

        S <= "111";
        wait;
    END PROCESS;

END Behavioral;
