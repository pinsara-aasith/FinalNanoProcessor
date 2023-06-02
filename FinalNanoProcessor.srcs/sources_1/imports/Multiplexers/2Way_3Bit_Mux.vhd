----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2023 12:23:14 PM
-- Design Name: 
-- Module Name: twoWay_3Bit_Mux - Behavioral
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

ENTITY twoWay_3Bit_Mux IS
    PORT (
        AdderIn : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        JumpAdd : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Jump : IN STD_LOGIC;
        PC_in : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
END twoWay_3Bit_Mux;

ARCHITECTURE Behavioral OF twoWay_3Bit_Mux IS

    SIGNAL Y : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN

    PROCESS (Jump, AdderIn, JumpAdd)
    BEGIN
        CASE Jump IS
            WHEN '0' =>
                PC_in <= AdderIn;
            WHEN '1' =>
                PC_in <= JumpAdd;
            WHEN OTHERS =>
                PC_in <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;