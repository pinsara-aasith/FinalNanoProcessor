LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Slow_Clk IS
    PORT (
        Clk_in : IN STD_LOGIC;
        Clk_out : OUT STD_LOGIC);
END Slow_Clk;

ARCHITECTURE Behavioral OF Slow_Clk IS

    SIGNAL count : STD_LOGIC_VECTOR(24 DOWNTO 0) := "0000000000000000000000000"; -- (25 DOWNTO 0)

    ATTRIBUTE use_dsp : STRING;
    ATTRIBUTE use_dsp OF count : SIGNAL IS "yes";
BEGIN
    -- For 100 MHz input clock this generates 1 Hz clock
    PROCESS (Clk_in, count) BEGIN
        IF (Clk_in'event AND Clk_in = '1') THEN
            count <= count + '1';
            Clk_out <= count(24); --count(24);
        END IF;
    END PROCESS;

END Behavioral;