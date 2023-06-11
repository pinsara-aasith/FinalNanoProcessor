LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ROM IS
    PORT (
        Mem_address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        Instruction : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END ROM;

ARCHITECTURE Behavioral OF ROM IS
    TYPE rom_type IS ARRAY (0 TO 6) OF STD_LOGIC_VECTOR(11 DOWNTO 0);

    SIGNAL rom : rom_type := (
        "100010001010", -- MOVI R1, 10 ; R1 ? 10                 format: 10 RRR 000 dddd
        "100100000001", -- MOVI R2, 1  ; R2 ? 1                  format: 10 RRR 000 dddd
        "010100000000", -- NEG R2      ; R2 ? -R2                format: 01 RRR 0000000
        "000010100000", -- ADD R1, R2  ; R1 ? R1 + R2            format: 00 RaRaRa RbRbRb 0000
        "110010000110", -- JZR R1, 7   ; If R1 = 0 jump to line 7 format: 11 RRR 0000 ddd
        "110000000011" -- JZR R0, 3   ; If R0 = 0 jump to line 3 format: 11 RRR 0000 ddd
        -- no line 7
    );

BEGIN
    Instruction <= rom(to_integer(unsigned(Mem_address)));
END Behavioral;