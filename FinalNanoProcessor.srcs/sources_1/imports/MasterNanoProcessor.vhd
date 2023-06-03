----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/13/2022 03:28:01 PM
-- Design Name: 
-- Module Name: MasterNanoProcessor - Behavioral
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

ENTITY MasterNanoProcessor IS
    PORT (
        Clk : IN STD_LOGIC;
        Res : IN STD_LOGIC;
        Halt : IN STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        S_LED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        S_7Seg : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
    );

END MasterNanoProcessor;

ARCHITECTURE Behavioral OF MasterNanoProcessor IS

    COMPONENT NanoProcessor
        PORT (
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Halt : IN STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC;
            OUT_REG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT LUT_16_7
        PORT (
            address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Slow_Clk IS
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL slowClk : STD_LOGIC;
    SIGNAL address : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN

    Clk0 : Slow_Clk
    PORT MAP(
        Clk_in => Clk,
        Clk_out => slowClk
    );

    NanoProcessor0 : NanoProcessor
    PORT MAP(
        Clk => slowClk,
        Res => Res,
        Halt => Halt,
        Zero => Zero,
        Overflow => Overflow,
        OUT_REG => address
    );
    
    LUT_16_7_0 : LUT_16_7
    PORT MAP(
        address => address,
        data => S_7Seg
    );

    -- to only switch on last 7 seg display
    Anode <= "1110";
    S_LED <= address;
END Behavioral;