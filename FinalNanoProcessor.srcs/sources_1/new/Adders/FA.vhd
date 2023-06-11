----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2023 03:55:59 PM
-- Design Name: 
-- Module Name: FA - Behavioral
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

ENTITY FA IS
    PORT (
        A : IN STD_LOGIC;
        B : IN STD_LOGIC;
        C_in : IN STD_LOGIC;
        S : OUT STD_LOGIC;
        C_out : OUT STD_LOGIC);
END FA;

ARCHITECTURE Behavioral OF FA IS
    COMPONENT HA
        PORT (
            A : IN STD_LOGIC;
            B : IN STD_LOGIC;
            S : OUT STD_LOGIC;
            C : OUT STD_LOGIC);
    END COMPONENT;
    SIGNAL HA0_S, HA0_C, HA1_S, HA1_C : STD_LOGIC;
BEGIN
    HA_0 : HA
    PORT MAP(
        A => A,
        B => B,
        S => HA0_S,
        C => HA0_C);
    HA_1 : HA
    PORT MAP(
        A => HA0_S,
        B => C_in,
        S => HA1_S,
        C => HA1_C);

    S <= HA1_S;
    C_out <= HA0_C OR HA1_C;
END Behavioral;