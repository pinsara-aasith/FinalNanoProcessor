library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2_to_4 is
        Port(
            S: in STD_LOGIC;
            D_0 : in STD_LOGIC_VECTOR (3 downto 0);
            D_1 : in STD_LOGIC_VECTOR (3 downto 0);
            Y: out STD_LOGIC_VECTOR(3 downto 0)
            );
end Mux_2_to_4;

architecture Behavioral of Mux_2_to_4 is
    
begin
    
     PROCESS (S, D_0, D_1)
     BEGIN
        CASE S IS
            WHEN '0' => 
                Y <= D_0;
            WHEN '1' => 
                Y <= D_1;
            WHEN OTHERS => 
                Y <= (OTHERS => 'X');
        END CASE;
     END PROCESS;
      
end Behavioral;