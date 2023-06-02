----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/08/2022 09:28:03 AM
-- Design Name: 
-- Module Name: fourBitAddSubUnit - Behavioral
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
        In_A : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        In_B : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Result : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        AddSub_Ctrl : IN STD_LOGIC;
        Zero_flag : OUT STD_LOGIC;
        Carry_flag : OUT STD_LOGIC;
        Overflow_flag : OUT STD_LOGIC;
        Sign_flag : OUT STD_LOGIC;
        Parity_flag : OUT STD_LOGIC);
END RCA_4;

ARCHITECTURE Behavioral OF RCA_4 IS
    COMPONENT FA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL FA_C : STD_LOGIC_VECTOR(4 DOWNTO 0);
    SIGNAL B0, B1, B2, B3, B4, B5, B6, B7 : STD_LOGIC; -- replace bus
    SIGNAL S0 : STD_LOGIC_VECTOR (4 DOWNTO 0);
BEGIN
    FA_0 : FA
    PORT MAP(
        A => In_A(0),
        B => B0,
        C_in => AddSub_Ctrl, -- AddSub_Ctrl signal to decide addition(0) or subtraction(1)
        S => S0(0),
        C_Out => FA0_C
    );

    -- subtraction logic  
    B0 <= In_B(0) XOR AddSub_Ctrl;
    B1 <= In_B(1) XOR AddSub_Ctrl;
    B2 <= In_B(2) XOR AddSub_Ctrl;
    B3 <= In_B(3) XOR AddSub_Ctrl;

    Result <= S0;

    Zero_flag <= (NOT S0(0)) AND (NOT S0(1)) AND (NOT S0(2)) AND (NOT S0(3)) AND (NOT S0(4)) AND (NOT S0(5)) AND (NOT S0(6)) AND (NOT S0(7));
    Sign_flag <= S0(7);
    Overflow_flag <= (NOT AddSub_Ctrl) AND (In_A(7) XNOR In_B(7)) AND(In_A(7) XOR S0(7));
    -- Overflow occurs only when addition, both have same sign, and the output has opposite sign
        
        
    -- 0 for odd, 1 for even (Set if the least-significant byte of the result contains an even number of 1 bits; cleared otherwise.)
    Parity_flag <= NOT(S0(0) XOR S0(1) XOR S0(2) XOR S0(3) XOR S0(4) XOR S0(5) XOR S0(6) XOR S0(7));

END Behavioral;