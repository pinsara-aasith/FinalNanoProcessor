LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LUT_16_7_Seg IS
    PORT (
        Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END LUT_16_7_Seg;

ARCHITECTURE Behavioral OF LUT_16_7_Seg IS
    TYPE rom_type IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(6 DOWNTO 0);

    SIGNAL Seven_Segment_ROM : rom_type := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0110001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "0010000", -- 9
        "0001000", -- A
        "0000011", -- B
        "1000110", -- C
        "0100001", -- D
        "0000110", -- E
        "0001110" -- 
    );
BEGIN
    data <= Seven_Segment_ROM(to_integer(unsigned(address)));
END Behavioral;