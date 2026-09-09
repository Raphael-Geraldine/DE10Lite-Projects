library IEEE;
use ieee.std_logic_1164.all;

entity Mux2 is
    port(
        I0, I1: in std_logic_vector(3 downto 0);
        S: in std_logic;
        O: out std_logic_vector(3 downto 0)
    );
end Mux2;

architecture Multiplex of Mux2 is
begin
    
    O <= I0 when S = '1' else I1;

end Multiplex;