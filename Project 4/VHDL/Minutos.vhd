Library IEEE;
use ieee.std_logic_1164.all;

entity Minutos is 
    port(
        rst: in std_logic;
        clk, enable: in std_logic;
        numToDis5: out std_logic_vector(3 downto 0)
    );
end Minutos;    

architecture min of Minutos is
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
            Clock => clk, Cin => enable, Cout => open,
            Spy0 => numToDis5(0), Spy1 => numToDis5(1), Spy2 => numToDis5(2), Spy3 => numToDis5(3) 
        );

    end min;