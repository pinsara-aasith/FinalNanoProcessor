LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ROM IS
    PORT (
        Mem_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END ROM;

ARCHITECTURE Behavioral OF ROM IS
    TYPE rom_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(11 DOWNTO 0);

    SIGNAL rom : rom_type := (
        "100100000011", -- MOVI     R2, 3
        "101110000000", -- MOVI     R7, 0
        "101000001111", -- MOVI     R4, -1
        "001110100000", -- ADD      R7, R2 
        "000101000000", -- ADD      R2, R4
        "110100000111", -- JZR      R2, 8
        "110000000011", -- JZR      R0,4
        "001110000000" --  ADD      R7, R0
    );

BEGIN
    Instruction <= rom(to_integer(unsigned(Mem_address)));
END Behavioral;