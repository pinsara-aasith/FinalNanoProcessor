LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb_Register_bank IS
END tb_Register_bank;

ARCHITECTURE Behavioral OF tb_Register_bank IS
    -- Component declaration for the DUT (Design Under Test)
    COMPONENT Register_bank
        PORT (
            Reg_En : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Clk : IN STD_LOGIC;
            Reset_Register_bank : IN STD_LOGIC;
            B0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL Reg_En : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Clk : STD_LOGIC;
    SIGNAL Reset_Register_bank : STD_LOGIC;
    SIGNAL B0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B2 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B3 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B4 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B5 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B6 : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL B7 : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN
    UUT: Register_bank
    PORT MAP (
        Reg_En => Reg_En,
        A => A,
        Clk => Clk,
        Reset_Register_bank => Reset_Register_bank,
        B0 => B0,
        B1 => B1,
        B2 => B2,
        B3 => B3,
        B4 => B4,
        B5 => B5,
        B6 => B6,
        B7 => B7
    );

    -- Clock process
    clk_proc: PROCESS
    BEGIN
        Clk <= '0';
        wait for 5 ns;
        Clk <= '1';
        wait for 5 ns;
    END PROCESS clk_proc;


    sim_process: PROCESS
    BEGIN
        -- Initialize inputs
        Reg_En <= "000";
        A <= "0000";
        Reset_Register_bank <= '0';
        wait for 10 ns;
        
        -- Enable registers 1, 3, 5
        Reg_En <= "101";
        A <= "0101";
        wait for 10 ns;
        
        -- Disable registers 1, 3, 5 and enable registers 0, 2, 4, 6, 7
        Reg_En <= "111";
        A <= "0011";
        wait for 10 ns;
        
        -- Reset the register bank
        Reset_Register_bank <= '1';
        wait for 10 ns;
        Reset_Register_bank <= '0';
        
        wait;
    END PROCESS sim_process;

END Behavioral;

-- Instantiate the testbench
ARCHITECTURE testbench_arch OF tb_Register_bank IS
    COMPONENT Register_bank
        PORT (
            Reg_En : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Clk : IN STD_LOGIC;
            Reset_Register_bank : IN STD_LOGIC;
            B0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            B7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;
BEGIN
    UUT: Register_bank
    PORT MAP (
        Reg_En => Reg_En,
        A => A,
        Clk => Clk,
        Reset_Register_bank => Reset_Register_bank,
        B0 => B0,
        B1 => B1,
        B2 => B2,
        B3 => B3,
        B4 => B4,
        B5 => B5,
        B6 => B6,
        B7 => B7
    );
END testbench_arch;
