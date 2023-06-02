LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Adder_3_Bit IS
      PORT (
            A : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
      );

      --           -- NEWLY ADDED CODE
      --           ATTRIBUTE  use_dsp : string;
      --           ATTRIBUTE  use_dsp of Adder_3_Bit : entity is "yes";
END Adder_3_Bit;
ARCHITECTURE Behavioral OF Adder_3_Bit IS

BEGIN
      S <= A + "001";
END Behavioral;