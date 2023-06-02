----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2023 07:05:01 PM
-- Design Name: 
-- Module Name: Decoder_2_to_4 - Behavioral
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

ENTITY Decoder_2_to_4 IS
    PORT (
        I : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        EN : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END Decoder_2_to_4;

ARCHITECTURE Behavioral OF Decoder_2_to_4 IS

BEGIN

    Y(0) <= NOT I(0) AND NOT I(1) AND EN;
    Y(1) <= I(0) AND NOT I(1) AND EN;
    Y(2) <= NOT I(0) AND I(1) AND EN;
    Y(3) <= I(0) AND I(1) AND EN;

END Behavioral;