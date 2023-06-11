LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Adder_3 IS
END tb_Adder_3;

ARCHITECTURE Behavioral OF tb_Adder_3 IS
    -- Component declaration for the DUT (Design Under Test)
    COMPONENT Adder_3
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL A : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Result : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
    -- Instantiate the DUT
    UUT: Adder_3
    PORT MAP (
        A => A,
        Result => Result
    );


    PROCESS
    BEGIN
        -- Initialize inputs
        A <= "000";
        wait for 10 ns;
        
        -- Test addition operation
        A <= "011";
        wait for 10 ns;
        
        -- Test subtraction operation
        A <= "101";
        wait for 10 ns;
    
        wait;
    END PROCESS;

END Behavioral;
