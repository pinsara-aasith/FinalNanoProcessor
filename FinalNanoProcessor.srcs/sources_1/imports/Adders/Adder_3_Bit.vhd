library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Adder_3_Bit is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0)
           );
           
--           -- NEWLY ADDED CODE
--           ATTRIBUTE  use_dsp : string;
--           ATTRIBUTE  use_dsp of Adder_3_Bit : entity is "yes";
end Adder_3_Bit;
architecture Behavioral of Adder_3_Bit is

begin   
      S <= A + "001";
end Behavioral;