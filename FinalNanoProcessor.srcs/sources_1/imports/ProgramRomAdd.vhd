----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:14:48 PM
-- Design Name: 
-- Module Name: ProgramRomAdd - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY ProgramRomAdd IS
    PORT (
        Mem_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END ProgramRomAdd;

ARCHITECTURE Behavioral OF ProgramRomAdd IS
    TYPE rom_type IS ARRAY (0 TO 4) OF STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL rom : rom_type := (
        "101110000001", -- MOVI R7, 1 ; R1 ? 1                 format: 10 RRR 000 dddd
        "100010000010", -- MOVI R1, 2 ; R1 ? 2                 format: 10 RRR 000 dddd
        "001110010000", -- ADD R7, R1 ; R7 ? R7 + R1           format: 00 RaRaRa RbRbRb 0000
        "001111110000", -- ADD R7, R7 ; R7 ? R7 + R7           format: 00 RaRaRa RbRbRb 0000
        "100001000000" -- HALT SIGNAL ENABLING                 format: 10 000 100 0000
    );

BEGIN
    Instruction <= rom(to_integer(unsigned(Mem_address)));
END Behavioral;