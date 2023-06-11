LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Adder_3 IS
END tb_Adder_3;

ARCHITECTURE Behavioral OF tb_Adder_3 IS
    COMPONENT Adder_3
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Result : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

    --INDEX NO => 11 0011 0101 1011 1010
    
    UUT : Adder_3
    PORT MAP(
        A => A,
        Result => Result
    );
    
    PROCESS
    BEGIN
        A <= "010";
        WAIT FOR 100ns;

        A <= "111";
        WAIT FOR 100ns;

        A <= "110";
        WAIT FOR 100ns;

        WAIT;
    END PROCESS;

END Behavioral;