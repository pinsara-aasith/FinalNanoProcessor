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

ENTITY Add_Substract_4 IS
    PORT (
        A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

        AddSub_Ctrl : IN STD_LOGIC;

        Zero_flag : OUT STD_LOGIC;
        Overflow_flag : OUT STD_LOGIC;
        Carry_flag : OUT STD_LOGIC;
        Sign_flag : OUT STD_LOGIC
    );
END Add_Substract_4;

ARCHITECTURE Behavioral OF Add_Substract_4 IS
    COMPONENT RCA_4
        PORT (
            A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL Intermediate_B : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    RCA_0 : RCA_4
    PORT MAP(
        A => A,
        B => Intermediate_B,
        C_in => AddSub_Ctrl,
        S => S,
        C_Out => Carry_flag
    );

    Intermediate_B(0) <= B(0) XOR AddSub_Ctrl;
    Intermediate_B(1) <= B(1) XOR AddSub_Ctrl;
    Intermediate_B(2) <= B(2) XOR AddSub_Ctrl;
    Intermediate_B(3) <= B(3) XOR AddSub_Ctrl;

    Result <= S;

    Sign_flag <= S(3);
    Zero_flag <= (NOT S(0)) AND (NOT S(1)) AND (NOT S(2)) AND (NOT S(3));

    Overflow_flag <= (NOT AddSub_Ctrl) AND (A(3) XNOR Intermediate_B(3)) AND (A(3) XOR S(3));

END Behavioral;