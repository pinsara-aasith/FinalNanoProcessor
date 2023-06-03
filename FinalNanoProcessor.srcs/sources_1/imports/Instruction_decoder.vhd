----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/21/2022 12:25:54 PM
-- Design Name: 
-- Module Name: Instruction_decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY Instruction_decoder IS
    PORT (
        Instruction : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
        Reg_en : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Load_sel : OUT STD_LOGIC;
        Imd_val : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Reg_selA : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Reg_selB : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        Add_sub_sel : OUT STD_LOGIC;
        Jump : OUT STD_LOGIC;
        Jump_address : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        HALT : OUT STD_LOGIC;
        JMP_SEL : IN STD_LOGIC
    );
    --     -- NEWLY ADDED CODE
    --     ATTRIBUTE  use_dsp : string;
    --     ATTRIBUTE  use_dsp of Instruction_decoder : entity is "yes";
END Instruction_decoder;

ARCHITECTURE Behavioral OF Instruction_decoder IS

    --    SIGNAL DEC_OUT : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL OP_ADD, OP_NEG, OP_JZR, OP_MOV : STD_LOGIC;

BEGIN

    PROCESS (Instruction(11 DOWNTO 10))
    BEGIN
        OP_ADD <= '0';
        OP_NEG <= '0';
        OP_MOV <= '0';
        OP_JZR <= '0';
        CASE Instruction(11 DOWNTO 10) IS
            WHEN "00" =>
                OP_ADD <= '1';
            WHEN "01" =>
                OP_NEG <= '1';
            WHEN "10" =>
                OP_MOV <= '1';
            WHEN OTHERS =>
                OP_JZR <= '1';
        END CASE;
    END PROCESS;

    Reg_en <= Instruction(9 DOWNTO 7);
    Imd_val <= Instruction(3 DOWNTO 0);
    Load_sel <= OP_MOV;
    Add_sub_sel <= OP_NEG;

    -- REGISTER A, REGISTER B ADDRESS VALUES
    PROCESS (Instruction(9 DOWNTO 4), OP_NEG)
    BEGIN
        IF (OP_NEG = '0') THEN
            Reg_selA <= Instruction(9 DOWNTO 7);
            Reg_selB <= Instruction(6 DOWNTO 4);
        ELSE
            Reg_selA <= "000";
            Reg_selB <= Instruction(9 DOWNTO 7);
        END IF;
    END PROCESS;

    PROCESS (JMP_SEL, OP_JZR)
    BEGIN
        IF OP_JZR = '1' THEN
            Jump <= JMP_SEL;
        ELSE
            Jump <= '0';
        END IF;
    END PROCESS;

    Jump_address <= Instruction(2 DOWNTO 0);

    PROCESS (OP_MOV, Instruction(6))
    BEGIN
        IF OP_MOV = '1' AND Instruction(6) = '1' THEN
            HALT <= '1';
        ELSE
            HALT <= '0';
        END IF;
    END PROCESS;

END Behavioral;