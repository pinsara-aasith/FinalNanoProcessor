LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Register_bank IS
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
END Register_bank;

ARCHITECTURE Behavioral OF Register_bank IS

    COMPONENT Register_4
        PORT (
            D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            En : IN STD_LOGIC;
            Clk : IN STD_LOGIC;
            Res : IN STD_LOGIC;
            Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
            );
    END COMPONENT;

    COMPONENT Decoder_3_to_8
        PORT (
            I : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Y : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
    END COMPONENT;
    SIGNAL Y0 : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

    Decoder_3_to_8_0 : Decoder_3_to_8 PORT MAP(
        I => Reg_En,
        Y => Y0
    );

    Reg1 : Register_4 PORT MAP(
        D => A,
        En => Y0(1),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B1
    );

    Reg2 : Register_4 PORT MAP(
        D => A,
        En => Y0(2),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B2
    );

    Reg3 : Register_4 PORT MAP(
        D => A,
        En => Y0(3),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B3
    );

    Reg4 : Register_4 PORT MAP(
        D => A,
        En => Y0(4),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B4
    );

    Reg5 : Register_4 PORT MAP(
        D => A,
        En => Y0(5),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B5
    );

    Reg6 : Register_4 PORT MAP(
        D => A,
        En => Y0(6),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B6
    );

    Reg7 : Register_4 PORT MAP(
        D => A,
        En => Y0(7),
        Clk => Clk,
        Res => Reset_Register_bank,
        Q => B7
    );

    B0 <= "0000";

END Behavioral;