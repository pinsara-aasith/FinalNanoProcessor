----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 10:09:24 PM
-- Design Name: 
-- Module Name: TB_NanoProcessor - Behavioral
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
USE IEEE.NUMERIC_STD.ALL;

ENTITY NanoProcessor_TB IS
END NanoProcessor_TB;

ARCHITECTURE Behavioral OF NanoProcessor_TB IS
    -- Component declaration for the UUT
    COMPONENT NanoProcessor
        PORT (
            Clk : IN STD_LOGIC;
                Res : IN STD_LOGIC;
                Zero : OUT STD_LOGIC;
                Overflow : OUT STD_LOGIC;
                Carry : OUT STD_LOGIC;
                S_7Seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
                OUT_REG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
                Anode : out STD_LOGIC_VECTOR (3 downto 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL Res : STD_LOGIC := '0';
    SIGNAL Zero : STD_LOGIC;
    SIGNAL Overflow : STD_LOGIC;
    SIGNAL Carry : STD_LOGIC;
    SIGNAL OUT_REG : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL S_7Seg : STD_LOGIC_VECTOR(6 DOWNTO 0);
    sIGNAL Anode : STD_LOGIC_VECTOR (3 downto 0);

BEGIN
    -- UUT instantiation
    UUT : NanoProcessor
    PORT MAP(
        Clk => Clk,
        Res => Res,
        Zero => Zero,
        Overflow => Overflow,
        Carry => Carry,
        OUT_REG => OUT_REG,
        S_7Seg => S_7Seg,
        Anode => Anode
    );

    -- Clock generation process
    PROCESS
    BEGIN
        Clk <= '0';
        WAIT FOR 5 NS;
        Clk <= '1';
        WAIT FOR 5 NS;
    END PROCESS;

    -- Stimulus process
    PROCESS
    BEGIN
        -- Initialize reset
        Res <= '1';
        WAIT FOR 40 NS;
        Res <= '0';

        WAIT;
    END PROCESS;

END Behavioral;
