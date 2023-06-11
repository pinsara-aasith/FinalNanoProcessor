LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Nano_processor_tb IS
END Nano_processor_tb;

ARCHITECTURE behavior OF Nano_processor_tb IS

    COMPONENT Nano_processor
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    -- Clock signal
    SIGNAL Clk : STD_LOGIC := '0';

    -- Other signals
    SIGNAL Res, Zero, Overflow : STD_LOGIC;
    SIGNAL Value : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

    UUT: Nano_processor
    PORT MAP (
        Clk => Clk,
        Res => Res,
        Zero => Zero,
        Overflow => Overflow,
        Value => Value
    );

    -- Clock process
    CLK_PROCESS :PROCESS
    BEGIN
        Clk <= '0';
        WAIT FOR 10 ns;
        Clk <= '1';
        WAIT FOR 10 ns;
    END PROCESS;

    -- Stimulus process
    STIM_PROCESS :PROCESS
    BEGIN
        -- Initialize inputs
        Res <= '0';

        -- Wait for 10 ns for reset to take effect
        WAIT FOR 10 ns;

        -- Apply test stimulus
        -- Modify the inputs as desired for testing different scenarios
        -- Example:
        -- Res <= '1'; -- Apply reset signal

        -- Add further stimulus if needed

        -- Wait for simulation to finish
        WAIT;
    END PROCESS;

END behavior;

-- Instantiate the testbench
ARCHITECTURE testbench OF Nano_processor_tb IS
BEGIN
    -- Component declaration for the unit under test (UUT)
    COMPONENT Nano_processor
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    -- Signal declaration
    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL Res, Zero, Overflow : STD_LOGIC;
    SIGNAL Value : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    -- Instantiate the unit under test (UUT)
    UUT: Nano_processor
    PORT MAP (
        Clk => Clk,
        Res => Res,
        Zero => Zero,
        Overflow => Overflow,
        Value => Value
    );

    -- Clock process
    CLK_PROCESS : PROCESS
    BEGIN
        WHILE NOW < 1000 ns LOOP  -- Modify the simulation time as needed
            Clk <= '0';
            WAIT FOR 5 ns;
            Clk <= '1';
            WAIT FOR 5 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    STIM_PROCESS : PROCESS
    BEGIN
        -- Initialize inputs
        Res <= '0';

        -- Wait for 10 ns for reset to take effect
        WAIT FOR 10 ns;

        -- Apply test stimulus
        -- Modify the inputs as desired for testing different scenarios
        -- Example:
        -- Res <= '1'; -- Apply reset signal

        -- Add further stimulus if needed

        -- Wait for simulation to finish
        WAIT;
    END PROCESS;

END testbench;
