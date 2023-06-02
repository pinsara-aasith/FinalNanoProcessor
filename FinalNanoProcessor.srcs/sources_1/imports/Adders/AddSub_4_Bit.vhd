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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RCA_4 is
    Port ( AddSubIn_A : in STD_LOGIC_VECTOR (7 downto 0);
           AddSubIn_B : in STD_LOGIC_VECTOR (7 downto 0);
           AddSubOut : out STD_LOGIC_VECTOR (7 downto 0);
           Ctrl: in STD_LOGIC; -- same as C_in
           Zero_flag : out STD_LOGIC;
           Overflow_flag : out STD_LOGIC;
           Sign_flag : out STD_LOGIC;
           Carry_flag : out STD_LOGIC;
           Parity_flag : out STD_LOGIC);
end RCA_4;

architecture Behavioral of RCA_4 is
    component FA
        port (A: in std_logic;
              B: in std_logic;
              C_in: in std_logic;
              S: out std_logic;
              C_out: out std_logic);
    end component;
    SIGNAL FA0_C, FA1_C, FA2_C, FA3_C, FA4_C, FA5_C, FA6_C, FA7_C: std_logic;
    SIGNAL B0, B1, B2, B3, B4, B5, B6, B7: std_logic; -- replace bus
    SIGNAL S0 : STD_LOGIC_VECTOR (7 downto 0);
    begin
        FA_0 : FA
            port map (
            A => AddSubIn_A(0),
            B => B0,
            C_in => Ctrl, -- ctrl signal to decide addition(0) or subtraction(1)
            S => S0(0),
            C_Out => FA0_C);
        FA_1 : FA
            port map (
            A => AddSubIn_A(1),
            B => B1,
            C_in => FA0_C,
            S => S0(1),
            C_Out => FA1_C);
        FA_2 : FA
            port map (
            A => AddSubIn_A(2),
            B => B2,
            C_in => FA1_C,
            S => S0(2),
            C_Out => FA2_C);
        FA_3 : FA
            port map (
            A => AddSubIn_A(3),
            B => B3,
            C_in => FA2_C,
            S => S0(3),
            C_Out => FA3_C);
        FA_4 : FA
            port map (
            A => AddSubIn_A(4),
            B => B4,
            C_in => FA3_C, 
            S => S0(4),
            C_Out => FA4_C);
        FA_5 : FA
            port map (
            A => AddSubIn_A(5),
            B => B5,
            C_in => FA4_C,
            S => S0(5),
            C_Out => FA5_C);
        FA_6 : FA
            port map (
            A => AddSubIn_A(6),
            B => B6,
            C_in => FA5_C,
            S => S0(6),
            C_Out => FA6_C);
        FA_7 : FA
            port map (
            A => AddSubIn_A(7),
            B => B7,
            C_in => FA6_C,
            S => S0(7),
            C_Out => Carry_flag); -- carry flag
        -- subtraction logic  
        B0<= AddSubIn_B(0) XOR Ctrl;
        B1<= AddSubIn_B(1) XOR Ctrl;
        B2<= AddSubIn_B(2) XOR Ctrl;
        B3<= AddSubIn_B(3) XOR Ctrl;
        B4<= AddSubIn_B(4) XOR Ctrl;
        B5<= AddSubIn_B(5) XOR Ctrl;
        B6<= AddSubIn_B(6) XOR Ctrl;
        B7<= AddSubIn_B(7) XOR Ctrl;

        AddSubOut <= S0;
        
        Zero_flag <= (NOT S0(0)) AND (NOT S0(1)) AND (NOT S0(2)) AND (NOT S0(3)) AND (NOT S0(4)) AND (NOT S0(5)) AND (NOT S0(6)) AND (NOT S0(7));
        Sign_flag <= S0(7);
        Overflow_flag <= (NOT Ctrl) AND                               -- Overflow occurs only when addition, both have same sign, and the output has opposite sign
                     (AddSubIn_A(7) XNOR  AddSubIn_B(7)) AND                      
                     (AddSubIn_A(7) XOR S0(7));     
        -- 0 for odd, 1 for even (Set if the least-significant byte of the result contains an even number of 1 bits; cleared otherwise.)
        Parity_flag <=  NOT(S0(0) XOR S0(1) XOR S0(2) XOR S0(3) XOR S0(4) XOR S0(5) XOR S0(6) XOR S0(7));
        
end Behavioral;