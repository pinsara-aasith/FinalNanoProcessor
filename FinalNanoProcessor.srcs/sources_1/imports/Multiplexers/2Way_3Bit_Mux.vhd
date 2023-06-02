----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:23:14 PM
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity twoWay_3Bit_Mux is
    Port ( AdderIn : in STD_LOGIC_VECTOR (2 downto 0);
           JumpAdd : in STD_LOGIC_VECTOR (2 downto 0);
           Jump : in STD_LOGIC;
           PC_in : out STD_LOGIC_VECTOR (2 downto 0));
end twoWay_3Bit_Mux;

architecture Behavioral of twoWay_3Bit_Mux is

SIGNAL Y : STD_LOGIC_VECTOR (2 DOWNTO 0);

begin
    
    PROCESS(Jump, AdderIn, JumpAdd)
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

end Behavioral;