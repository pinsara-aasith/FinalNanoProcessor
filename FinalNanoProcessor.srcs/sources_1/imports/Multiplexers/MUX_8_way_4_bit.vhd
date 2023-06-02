LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY MUX_8_Way_4_Bit IS
    PORT (
        D0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        D7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Y_out : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        S : IN STD_LOGIC_VECTOR (2 DOWNTO 0));
END MUX_8_Way_4_Bit;

ARCHITECTURE Behavioral OF MUX_8_Way_4_Bit IS

BEGIN

    PROCESS (S, D0, D1, D2, D3, D4, D5, D6, D7)
    BEGIN
        CASE S IS
            WHEN "000" =>
                Y_out <= D0;
            WHEN "001" =>
                Y_out <= D1;
            WHEN "010" =>
                Y_out <= D2;
            WHEN "011" =>
                Y_out <= D3;
            WHEN "100" =>
                Y_out <= D4;
            WHEN "101" =>
                Y_out <= D5;
            WHEN "110" =>
                Y_out <= D6;
            WHEN "111" =>
                Y_out <= D7;
            WHEN OTHERS =>
                Y_out <= (OTHERS => 'X');
        END CASE;
    END PROCESS;

END Behavioral;