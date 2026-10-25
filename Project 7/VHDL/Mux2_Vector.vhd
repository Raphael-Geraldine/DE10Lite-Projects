library IEEE;
use ieee.std_logic_1164.all;

entity Mux2_Vector is
    port(
        I0, I1: in std_logic_vector (7 downto 0);
        S: in std_logic;
        O: out std_logic_vector (7 downto 0)
    );
end Mux2_Vector;

architecture Multiplex of Mux2_Vector is
begin
    
    O <= I0 when S = '0' else I1;

end Multiplex;