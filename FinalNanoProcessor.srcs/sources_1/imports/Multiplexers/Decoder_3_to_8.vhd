LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Decoder_3_to_8 IS
    PORT (
        I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        EN : IN STD_LOGIC;
        Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END Decoder_3_to_8;

ARCHITECTURE Behavioral OF Decoder_3_to_8 IS

    COMPONENT Decoder_2_to_4
        PORT (
            I : IN STD_LOGIC_VECTOR;
            EN : IN STD_LOGIC;
            Y : OUT STD_LOGIC_VECTOR);
    END COMPONENT;

    SIGNAL I0, I1 : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL Y0, Y1 : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL EN0, EN1, I2 : STD_LOGIC;

BEGIN

    Decoder_2_to_4_0 : Decoder_2_to_4
    PORT MAP(
        I => I0,
        EN => EN0,
        Y => Y0
    );

    Decoder_2_to_4_1 : Decoder_2_to_4
    PORT MAP(
        I => I1,
        EN => EN1,
        Y => Y1
    );

    EN0 <= NOT(I(2)) AND EN;
    EN1 <= I(2) AND EN;

    I0 <= I(1 DOWNTO 0);
    I1 <= I(1 DOWNTO 0);
    I2 <= I(2);

    Y(3 DOWNTO 0) <= Y0;
    Y(7 DOWNTO 4) <= Y1;

END Behavioral;