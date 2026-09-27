Library IEEE;
use ieee.std_logic_1164.all;

entity Milisegundos is 
    port(
        rst: in std_logic;
        clk, enable: in std_logic;
        numToDis0, numToDis1, numToDis2: out std_logic_vector(3 downto 0);
        cout: out std_logic
    );
end Milisegundos;    

architecture mili of Milisegundos is
    signal C0I1, C1I2: std_logic;

    component GerenciadorContagem 
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
            Spy0 => numToDis0(0), Spy1 => numToDis0(1), Spy2 => numToDis0(2), Spy3 => numToDis0(3) 
        );

        Cont1: GerenciadorContagem port map(
            rst => rst,
            Clock => clk, Cin => C0I1, Cout => C1I2,
            Spy0 => numToDis1(0), Spy1 => numToDis1(1), Spy2 => numToDis1(2), Spy3 => numToDis1(3) 
        );

        Cont2: GerenciadorContagem port map(
            rst => rst,
            Clock => clk, Cin => C1I2, Cout => cout,
            Spy0 => numToDis2(0), Spy1 => numToDis2(1), Spy2 => numToDis2(2), Spy3 => numToDis2(3) 
        );
    end mili;