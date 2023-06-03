----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:15:57 PM
-- Design Name: 
-- Module Name: Program_counter - Behavioral
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

ENTITY Program_counter IS
    PORT (
        D : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC; -- SIGNAL TO RESET
        Load : IN STD_LOGIC; -- SIGNAL TO LOAD 
        Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END Program_counter;

ARCHITECTURE Behavioral OF Program_counter IS

BEGIN
    PROCESS (Clk) BEGIN
        IF (rising_edge(Clk)) THEN
            IF (Res = '1') THEN
                Q <= "000";
            ELSIF (Load = '1') THEN
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;