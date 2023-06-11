LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Main_unit_tb IS
END Main_unit_tb;

ARCHITECTURE behavior OF Main_unit_tb IS

    COMPONENT Main_unit
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        S_7Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Value : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
    END COMPONENT;

    SIGNAL Clk : STD_LOGIC := '0';

    SIGNAL Res, Zero, Overflow : STD_LOGIC;
    SIGNAL S_7Seg, Anode, Value : STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
    UUT: Main_unit
    PORT MAP (
        Clk => Clk,
        Res => Res,
        Zero => Zero,
        Overflow => Overflow,
        S_7Seg => S_7Seg,
        Anode => Anode,
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
    -- Load instructions into the program ROM
    -- The instructions for adding numbers from 1 to 3 are:
    -- Address 0: Load immediate value 1 to register 0
    -- Address 1: Add register 0 with immediate value 2 and store the result in register 0
    -- Address 2: Add register 0 with immediate value 3 and store the result in register 0
    -- Address 3: Halt instruction
    -- These instructions should result in the value in register 0 being 6 after execution

    -- Load instruction 0: Load immediate value 1 to register 0
    LoadProgRom <= '1';
    PC_Input <= "000";
    WAIT FOR 10 ns;
    LoadProgRom <= '0';

    -- Load instruction 1: Add register 0 with immediate value 2 and store the result in register 0
    LoadProgRom <= '1';
    PC_Input <= "001";
    WAIT FOR 10 ns;
    LoadProgRom <= '0';

    -- Load instruction 2: Add register 0 with immediate value 3 and store the result in register 0
    LoadProgRom <= '1';
    PC_Input <= "010";
    WAIT FOR 10 ns;
    LoadProgRom <= '0';

    -- Load instruction 3: Halt instruction
    LoadProgRom <= '1';
    PC_Input <= "011";
    WAIT FOR 10 ns;
    LoadProgRom <= '0';

    -- Wait for the result to stabilize
    WAIT FOR 10 ns;

    -- Print the output value
    REPORT "Output Value: " & INTEGER'IMAGE(to_integer(unsigned(Value))) & " Expected: 6";

    -- Wait for simulation to finish
    WAIT;
END PROCESS;


END behavior;
