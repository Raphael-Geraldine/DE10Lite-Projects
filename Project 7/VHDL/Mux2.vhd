library IEEE;
use ieee.std_logic_1164.all;

entity Mux2 is
    port(
        I0, I1: in std_logic;
        S: in std_logic;
        O: out std_logic
    );
end Mux2;

architecture Multiplex of Mux2 is
begin
    
    O <= I0 when S = '0' else I1;

end Multiplex;