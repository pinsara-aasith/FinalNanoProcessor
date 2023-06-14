LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Adder_3 IS
    PORT (
        A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END Adder_3;

ARCHITECTURE Behavioral OF Adder_3 IS
    COMPONENT RCA_4
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL C_in : STD_LOGIC;
    SIGNAL C_out : STD_LOGIC;

    SIGNAL newA : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL newResult : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    RCA_0 : RCA_4
    PORT MAP(
        A => newA,
        B => B,
        C_in => C_in,
        S => newResult,
        C_Out => C_out
    );

    newA(2 DOWNTO 0) <= A;
    Result <= newResult(2 DOWNTO 0);
    newA(3) <= '0';

    C_in <= '1';
    B <= "0000";

END Behavioral;