----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:11:12 PM
-- Design Name: 
-- Module Name: Register - Behavioral
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

ENTITY Register_4 IS
    PORT (
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        En : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Register_4;

ARCHITECTURE Behavioral OF Register_4 IS

BEGIN

    PROCESS (Clk, Res) BEGIN
        IF (Res = '1') THEN
            Q <= '0000';
        ELSIF (rising_edge(Clk)) THEN
            IF (En = '1') THEN
                Q <= D;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;