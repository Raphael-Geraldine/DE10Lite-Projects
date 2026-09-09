library IEEE;
use ieee.std_logic_1164.all;

entity RegDeslocamento is
    port(
        Serial: in std_logic;
        Pst, Clr: in std_logic;
        Clk: in std_logic;
        O, Oo: out std_logic_vector(4 downto 0)
    );
end RegDeslocamento;

architecture SISO of RegDeslocamento is
    component MyDLatch 
        port(
            D: in std_logic;
            Preset, Clear: in std_logic;
            clk: in std_logic;
            Q, Qo: out std_logic
        );
    end component;

    signal s_Q  : std_logic_vector(4 downto 0) := (others => '0');
    signal s_Qo : std_logic_vector(4 downto 0) := (others => '1');

begin
    nivel0: MyDLatch port map (
        D => Serial, Preset => Pst, Clear => Clr, clk => Clk,
        Q => s_Q(0), Qo => s_Qo(0) 
    );
    nivel1: MyDLatch port map (
        D => s_Q(0), Preset => Pst, Clear => Clr, clk => Clk,
        Q => s_Q(1), Qo => s_Qo(1) 
    );
    nivel2: MyDLatch port map (
        D => s_Q(1), Preset => Pst, Clear => Clr, clk => Clk,
        Q => s_Q(2), Qo => s_Qo(2) 
    );
    nivel3: MyDLatch port map (
        D => s_Q(2), Preset => Pst, Clear => Clr, clk => Clk,
        Q => s_Q(3), Qo => s_Qo(3) 
    );
    nivel4: MyDLatch port map (
        D => s_Q(3), Preset => Pst, Clear => Clr, clk => Clk,
        Q => s_Q(4), Qo => s_Qo(4) 
    );

    O  <= s_Q;
    Oo <= s_Qo;

end SISO;