----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/08/2023 08:01:34 PM
-- Design Name: 
-- Module Name: D_FF - Behavioral
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

ENTITY D_FF IS
    PORT (
        D : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        Qbar : OUT STD_LOGIC
    );
END D_FF;

ARCHITECTURE Behavioral OF D_FF IS

BEGIN

    PROCESS (Clk)
    BEGIN

        IF (rising_edge(Clk)) THEN
            IF Res = '1' THEN
                Q <= '0';
                Qbar <= '1';
            ELSE
                Q <= D;
                Qbar <= NOT D;
            END IF;
        END IF;

    END PROCESS;

END Behavioral;