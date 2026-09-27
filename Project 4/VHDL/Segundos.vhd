Library IEEE;
use ieee.std_logic_1164.all;

entity Segundos is 
    port(
        rst: in std_logic;
        clk, enable: in std_logic;
        numToDis3, numToDis4: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
end Segundos;    

architecture sec of Segundos is
    signal C0I1: std_logic;

    component GerenciadorContagem 
        port(
            rst: in std_logic;
            Clock, Cin: in std_logic;
            Cout: out std_logic;
            Spy0, Spy1, Spy2, Spy3: out std_logic
        );
    end component;

    component GerenciadorContagemHexa
        port(
            rst: in std_logic;
            Clock, Cin: in std_logic;
            Cout: out std_logic;
            Spy0, Spy1, Spy2, Spy3: out std_logic
        );
    end component;

    begin
        Cont0: GerenciadorContagem port map(
            rst => rst,
            Clock => clk, Cin => enable, Cout => C0I1,
            Spy0 => numToDis3(0), Spy1 => numToDis3(1), Spy2 => numToDis3(2), Spy3 => numToDis3(3) 
        );

        Cont1: GerenciadorContagemHexa port map(
            rst => rst,
            Clock => clk, Cin => C0I1, Cout => cout,
            Spy0 => numToDis4(0), Spy1 => numToDis4(1), Spy2 => numToDis4(2), Spy3 => numToDis4(3) 
        );

    end sec;