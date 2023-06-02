----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2023 11:47:57 AM
-- Design Name: 
-- Module Name: RCA_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY RCA_4 IS
    PORT (
        A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        C_in : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        C_out : OUT STD_LOGIC
    );
END RCA_4;

ARCHITECTURE Behavioral OF RCA_4 IS
    COMPONENT FA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC);
    END COMPONENT;

    SIGNAL FA_S : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL FA_C : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    FA_0 : FA
    PORT MAP(
        A => A(0),
        B => B(0),
        C_in => C_in,
        S => S(0),
        C_Out => FA_C(0)
    );

    FA_1 : FA
    PORT MAP(
        A => A(1),
        B => B(1),
        C_in => FA_C(0),
        S => S(1),
        C_Out => FA_C(1)
    );

    FA_2 : FA
    PORT MAP(
        A => A(2),
        B => B(2),
        C_in => FA_C(1),
        S => S(2),
        C_Out => FA_C(2)
    );
    FA_3 : FA
    PORT MAP(
        A => A(3),
        B => B(3),
        C_in => FA_C(2),
        S => S(3),
        C_Out => C_out
    );

END Behavioral;