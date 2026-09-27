Library IEEE;
use ieee.std_logic_1164.all;

entity GerenciadorContagem is 
    port(
        rst: in std_logic;
        Clock, Cin: in std_logic;
        Cout: out std_logic;
        Spy0, Spy1, Spy2, Spy3: out std_logic
    );
end GerenciadorContagem;

architecture gerenciador of GerenciadorContagem is
    signal v0, v1, v2, v3, D : std_logic := '0';
    signal s0, s1, s2, s3 : std_logic;

    component ContadorDecimal   
        port(
            A0, A1, A2, A3: in std_logic;
            Cin: in std_logic;
            Cout: out std_logic;
            S0, S1, S2, S3: out std_logic
        );
    end component;

    component PIPO_4bits
    port(
        Clock, Preset, Clear: in std_logic;
        In0, In1, In2, In3: in std_logic;
        Out0, Out1, Out2, Out3: out std_logic
    );
    end component;

    begin
        D <= Cin;

        Contador: ContadorDecimal port map(
            A0 => (v0 and rst), A1 => (v1 and rst), A2 => (v2 and rst), A3 => (v3 and rst),
            Cout => Cout, Cin => D,
            S0 => s0, S1 => s1, S2 => s2, S3 => s3
        );

        OutIn: PIPO_4bits port map(
            Clock => Clock, Preset => '1', Clear => '1',
            In0 => s0, In1 => s1, In2 => s2, In3 => s3,
            Out0 => v0, Out1 => v1, Out2 => v2, Out3 => v3
        );

        Spy0 <= v0;
        Spy1 <= v1;
        Spy2 <= v2;
        Spy3 <= v3;

    end gerenciador;