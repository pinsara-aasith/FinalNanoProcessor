----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2023 19:28:03 AM
-- Design Name: 
-- Module Name: Add_Substract_4 - Behavioral
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

ENTITY Adder_3 IS
    PORT (
        A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
    );
END Adder_3;

ARCHITECTURE Behavioral OF Adder_3 IS
    COMPONENT RCA
        PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Result : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL C_in : STD_LOGIC;
    SIGNAL C_out : STD_LOGIC;
    SIGNAL B : STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
    RCA_0 : RCA
    PORT MAP(
        A => A,
        B => B,
        C_in => C_in, -- AddSub_Ctrl signal to decide addition(0) or subtraction(1)
        Result => Result,
        C_Out => C_out
    );

    C_in => '1'
    B => '0000'

END Behavioral;