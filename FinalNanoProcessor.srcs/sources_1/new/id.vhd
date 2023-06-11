----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/20/2022 09:46:40 PM
-- Design Name: 
-- Module Name: InstructionDecoder - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;    


entity InstructionDecoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (13 downto 0);  -- 12 BIT INSTRUCTION
           Jump_sel : in STD_LOGIC_VECTOR (7 downto 0);       -- 8 BIT VALUE OF THE CORRESPONDING REGISTER
           Imd_val : out STD_LOGIC_VECTOR (7 downto 0);      -- IMMEDIATE VALUE THAT IS FROM THE INSTRUCTION
           Reg_en : out STD_LOGIC_VECTOR (2 downto 0);       -- ENABLE THE REGISTER TO SAVE IN THE REGISTER BANK
           Reg_select_A : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGISTER OF MUX A
           Load_sel : out STD_LOGIC;                         -- LOAD SIGNAL TO LOAD THE VALUE TO REGISTER BANK
           Reg_select_B : out STD_LOGIC_VECTOR (2 downto 0);     -- SELECT THE REGSTER OF MUX B
           Add_sub_sel : out STD_LOGIC;                      -- SELECT THE ADD/SUB INSTRUCTION
           Jump_address : out STD_LOGIC_VECTOR (2 downto 0); -- ADDRESS OF WHERE TO JUMP
           Jump : out STD_LOGIC);                            -- JUMP SIGNAL
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is    
    component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal MUX_A_DISABLED: STD_LOGIC;

    signal OP_ADD: STD_LOGIC;
    signal OP_NEG: STD_LOGIC;
    signal OP_MOVI: STD_LOGIC;
    signal OP_JZR: STD_LOGIC;
    signal OP_SUB: STD_LOGIC;
    signal OP_CLR: STD_LOGIC;
    signal OP_MOV: STD_LOGIC;
    signal OP_NOP: STD_LOGIC;
    
    signal DECODER_RESULT: std_logic_vector(7 downto 0);
    
begin

    Decoder_3_to_8_0: Decoder_3_to_8
        port map(
            I  => Instruction (16 downto 14),
            EN => '1',
            Y  => DECODER_RESULT
        );
                        
        OP_ADD  <= DECODER_RESULT(0);
        OP_NEG  <= DECODER_RESULT(1);
        OP_MOVI <= DECODER_RESULT(2);
        OP_JZR  <= DECODER_RESULT(3);
        
        
        OP_SUB  <= DECODER_RESULT(4);
        
        -- NEED TO CODE FOR THESE INSTRUCTIONS
        OP_CLR  <= DECODER_RESULT(5);
        OP_MOV  <= DECODER_RESULT(6);
        OP_NOP  <= DECODER_RESULT(7);
        
        MUX_A_DISABLED <= OP_NEG; --OR OP_MOV;  -- A has to be disabled in these instructions
        
        Reg_select_A(0) <= Instruction(11) AND NOT MUX_A_DISABLED;
        Reg_select_A(1) <= Instruction(12) AND NOT MUX_A_DISABLED;
        Reg_select_A(2) <= Instruction(13) AND NOT MUX_A_DISABLED;
        
        -- B should get instructions in last bits in these instructions
        Reg_select_B(0) <= Instruction(8) OR (Instruction(11) AND OP_NEG);
        Reg_select_B(1) <= Instruction(9) OR (Instruction(12) AND OP_NEG);
        Reg_select_B(2) <= Instruction(10) OR (Instruction(13) AND OP_NEG);
        
        Add_sub_sel <= OP_NEG OR OP_SUB;
        
        Reg_en <= Instruction(13 downto 11);
                    
        Load_sel <= OP_MOVI;
        Imd_val <= Instruction(7 downto 0);
        Jump <= OP_JZR AND (NOT Jump_sel(0))
                    AND (NOT Jump_sel(1))
                    AND (NOT Jump_sel(2))
                    AND (NOT Jump_sel(3))
                    AND (NOT Jump_sel(4))
                    AND (NOT Jump_sel(5))
                    AND (NOT Jump_sel(6))
                    AND (NOT Jump_sel(7));
                    
        Jump_address <= Instruction(2 DOWNTO 0);

end Behavioral;
