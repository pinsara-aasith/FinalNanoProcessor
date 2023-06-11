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
         Overflow_flag : OUT STD_LOGIC;
         Sign_flag : OUT STD_LOGIC;
         Parity_flag : OUT STD_LOGIC
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
   SIGNAL Overflow_flag : STD_LOGIC;
   SIGNAL Sign_flag : STD_LOGIC;
   SIGNAL Parity_flag : STD_LOGIC;

BEGIN

   UUT : Add_Substract_4 PORT MAP(
      A => A,
      B => B,
      Result => Result,
      AddSub_Ctrl => AddSub_Ctrl,
      Zero_flag => Zero_flag,
      Carry_flag => Carry_flag,
      Overflow_flag => Overflow_flag,
      Sign_flag => Sign_flag,
      Parity_flag => Parity_flag
   );

   PROCESS
   BEGIN
      -- Test 1: Addition
      A <= "0010";
      B <= "0100";
      AddSub_Ctrl <= '0';
      WAIT FOR 10 ns;

      -- Test 2: Subtraction
      A <= "0110";
      B <= "0010";
      AddSub_Ctrl <= '1';
      WAIT FOR 10 ns;

      -- Test 3: Addition with carry
      A <= "1101";
      B <= "0111";
      AddSub_Ctrl <= '0';
      WAIT FOR 10 ns;

      -- Test 4: Subtraction with borrow
      A <= "1001";
      B <= "1110";
      AddSub_Ctrl <= '1';
      WAIT FOR 10 ns;

      -- Test 5: Addition with zero result
      A <= "0000";
      B <= "0000";
      AddSub_Ctrl <= '0';
      WAIT FOR 10 ns;

      -- Test 6: Subtraction with zero result
      A <= "1010";
      B <= "1010";
      AddSub_Ctrl <= '1';
      WAIT FOR 10 ns;

      WAIT;
   END PROCESS;