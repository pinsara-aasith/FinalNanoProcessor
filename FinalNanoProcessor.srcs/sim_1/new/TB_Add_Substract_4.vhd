LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Add_Substract_4_TB IS
END Add_Substract_4_TB;

ARCHITECTURE behaviour OF Add_Substract_4_TB IS

   COMPONENT Add_Substract_4
      PORT (
         A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         Result : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         AddSub_Ctrl : IN STD_LOGIC;
         Zero_flag : OUT STD_LOGIC;
         Carry_flag : OUT STD_LOGIC;
         Sign_flag : OUT STD_LOGIC;
      );
   END COMPONENT;

   -- Inputs
   SIGNAL A : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL B : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL AddSub_Ctrl : STD_LOGIC := '0';

   -- Outputs
   SIGNAL Result : STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL Zero_flag : STD_LOGIC;
   SIGNAL Carry_flag : STD_LOGIC;
   SIGNAL Sign_flag : STD_LOGIC;

BEGIN

A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
Result : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);

AddSub_Ctrl : IN STD_LOGIC;

Zero_flag : OUT STD_LOGIC;
Carry_flag : OUT STD_LOGIC;
Sign_flag : OUT STD_LOGIC

   UUT : Add_Substract_4 PORT MAP(
      A => A,
      B => B,
      Result => Result,
      AddSub_Ctrl => AddSub_Ctrl,

      Zero_flag => Zero_flag,
      Carry_flag => Carry_flag,
      Sign_flag => Sign_flag,
   );

   PROCESS
   BEGIN

      --INDEX NO => 11 0011 0101 1011 1010
      -- Test 1: Addition
      A <= "1010";
      B <= "1011";
      AddSub_Ctrl <= '0';
      WAIT FOR 100ns;

      -- Test 2: Subtraction
      A <= "1011";
      B <= "1010";
      AddSub_Ctrl <= '1';
      WAIT FOR 100ns;

      -- Test 3: Addition with zero result
      A <= "0000";
      B <= "0000";
      AddSub_Ctrl <= '0';
      WAIT FOR 100ns;

      -- Test 4: Substraction with negative result
      A <= "0000";
      B <= "0001";
      AddSub_Ctrl <= '1';
      WAIT FOR 100ns;

      -- Test 5: Addition with carry
      A <= "1111";
      B <= "0001";
      AddSub_Ctrl <= '0';
      WAIT FOR 100ns;

      WAIT;
   END PROCESS;