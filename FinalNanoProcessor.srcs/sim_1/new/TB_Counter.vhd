LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Counter IS
END tb_Counter;

ARCHITECTURE Behavioral OF tb_Counter IS
    -- Component declarations for the DUT (Design Under Test)
    COMPONENT Counter
        PORT (
            Dir : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT D_FF
        PORT (
            D : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Q : OUT STD_LOGIC;
            Qbar : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT Slow_Clk
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL Dir : STD_LOGIC;
    SIGNAL Res : STD_LOGIC;
    SIGNAL Clk : STD_LOGIC;
    SIGNAL Q : STD_LOGIC_VECTOR(2 DOWNTO 0);

    -- Constants for simulation
    CONSTANT CLK_PERIOD : TIME := 10 ns;

BEGIN
    -- Instantiate the DUT
    UUT: Counter
    PORT MAP (
        Dir => Dir,
        Res => Res,
        Clk => Clk,
        Q => Q
    );

    -- Instantiate the Slow_Clk component to generate a slower clock for simulation
    clk_slow_gen: Slow_Clk
    PORT MAP (
        Clk_in => Clk,
        Clk_out => Clk
    );


    sim_process: PROCESS
    BEGIN
        -- Initialize inputs
        Dir <= '0';
        Res <= '0';
        Clk <= '0';
        wait for CLK_PERIOD;
        
        -- Test counting up
        Dir <= '0';
        Res <= '0';
        wait for 1 * CLK_PERIOD;
        
        -- Test counting down
        Dir <= '1';
        Res <= '0';
        wait for 1 * CLK_PERIOD;
        
        -- Test reset
        Dir <= '0';
        Res <= '1';
        wait for 1 * CLK_PERIOD;
        
        -- End simulation
        wait;
    END PROCESS sim_process;

END Behavioral;
