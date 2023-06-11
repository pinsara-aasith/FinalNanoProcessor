LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY tb_ProgramRomAdd IS
END tb_ProgramRomAdd;

ARCHITECTURE Behavioral OF tb_ProgramRomAdd IS
    -- Constants
    CONSTANT MEM_SIZE : INTEGER := 4;

    -- Signal declarations
    SIGNAL Mem_address : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Instruction : STD_LOGIC_VECTOR(11 DOWNTO 0);

    -- Component declaration for the DUT (Design Under Test)
    COMPONENT ProgramRomAdd
        PORT (
            Mem_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;

BEGIN
    -- Instantiate the DUT
    UUT: ProgramRomAdd
    PORT MAP (
        Mem_address => Mem_address,
        Instruction => Instruction
    );

    -- Clock process
    PROCESS
    BEGIN
        WAIT FOR 10 ns;
        WAIT FOR 10 ns;
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;


    PROCESS
    BEGIN
        -- Initialize inputs
        Mem_address <= "000";

        -- Read instructions from memory
        for i in 0 to MEM_SIZE - 1 loop
            Mem_address <= std_logic_vector(to_unsigned(i, Mem_address'length));
            wait for 10 ns;
        end loop;

        wait;
    END PROCESS;

END Behavioral;

-- Instantiate the testbench
ARCHITECTURE testbench_arch OF tb_ProgramRomAdd IS
    COMPONENT ProgramRomAdd
        PORT (
            Mem_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
            Instruction : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    UUT: ProgramRomAdd
    PORT MAP (
        Mem_address => Mem_address,
        Instruction => Instruction
    );
END testbench_arch;
